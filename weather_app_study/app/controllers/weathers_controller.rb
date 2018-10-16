class WeathersController < ApplicationController
  require 'json'
  require 'time'
  require 'open-uri'
  require 'nokogiri'

  DARK_SKY_URI = 'https://api.darksky.net/forecast/080fa7f90e3e587b2de824aa0bcc0dd4/'
  
  #検索画面
  def index
    
  end
  

  #天気情報画面
  def info
    
    #経度と緯度を取得
    address = params[:address]
    @address = address
    geo_uri = URI.encode "https://www.geocoding.jp/api/?q=#{address}"
    
    xml = Nokogiri::XML(open(geo_uri).read)
    latitude = xml.xpath('/result/coordinate/lat').text.to_i
    longitude = xml.xpath('/result/coordinate/lng').text.to_i


    #お天気APIに経度と緯度を代入して、情報を取得
    uri = DARK_SKY_URI
    url = "#{uri}#{latitude},#{longitude}"
    @url = "#{uri}#{latitude},#{longitude}"
    
    response = open(url).read
    response_precip_hour = open("#{url}?extend=hourly").read

    weather = JSON.parse(response)
    precip_hour = JSON.parse(response_precip_hour)

    #今日の天気情報を取得
    def fahrenheit_to_celsius(temperature)
      ((temperature-32)/1.8).floor(2)
    end

    @today_weather = weather["currently"]["icon"]
    @temp_low = fahrenheit_to_celsius(weather["daily"]["data"][0]["apparentTemperatureMin"])
    @temp_high =fahrenheit_to_celsius(weather["daily"]["data"][0]["apparentTemperatureMax"])
    @precip = ((weather["daily"]["data"][0]["precipProbability"])*100).floor(2)

    #4時間ごとの天気
    hour_num = [4,8,12,16,20,24]
    res_hour = []
    
    hour_num.each do |num|
      res_hour << precip_hour["hourly"]["data"][num]["precipProbability"]
    end
     
    test = []

    res_hour.each.with_index(1) do |x, i|
      hour = i*4
      per = (x*100).floor(2)
      test << "[#{hour}時間後の降水確率:#{per}%]"
    end
    @res_4hour = test

   #前日/翌日の天気
   def weather_of_another_day(offset)
     yesterday_or_tomorrow = (Date.today + offset).to_s
     unixtime = Time.parse(yesterday_or_tomorrow).to_i
     response = open("#{@url},#{unixtime}").read
     weather = JSON.parse(response)
     weather["currently"]["icon"]
   end

   yesterday = -1
   tomorrow = 1
   yesterday.freeze
   tomorrow.freeze

   @yesterday_weather = weather_of_another_day(yesterday)
   @tomorrow_weather = weather_of_another_day(tomorrow)


   #1週間の天気
   week = []

   for num in 1..7 do
     unixtime_week = (Date.today+num).to_s
     unixtime_week = Time.parse(unixtime_week).to_i
     response_week = open("#{url},#{unixtime_week}").read
     weather_week = JSON.parse(response_week)
     week_weather = weather_week["currently"]["icon"]
     week << "[#{num}日後の天気:#{week_weather}]"
   end

   @week = week
  end

end
