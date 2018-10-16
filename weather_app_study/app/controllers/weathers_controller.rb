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
    response = open(url).read
    response_precip_hour = open("#{url}?extend=hourly").read

    weather = JSON.parse(response)
    precip_hour = JSON.parse(response_precip_hour)

    #今日の天気情報を取得
    @today_weather = weather["currently"]["icon"]
    @temp_high = ((weather["daily"]["data"][0]["apparentTemperatureMax"] -32)/1.8).floor(2)
    @temp_low = ((weather["daily"]["data"][0]["apparentTemperatureMin"] -32) /1.8).floor(2)
    precip = (weather["daily"]["data"][0]["precipProbability"])*100
    @precip = precip.floor(2)

 
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

    #明日の天気を取得
    unixtime_tomorrow = (Date.today+1).to_s
    unixtime_tomorrow = Time.parse(unixtime_tomorrow).to_i
    response_tomorrow = open("#{url},#{unixtime_tomorrow}").read
    weather_tomorrow = JSON.parse(response_tomorrow)
    @tomorrow_weather = weather_tomorrow["currently"]["icon"]

   #昨日の天気
   unixtime_yesterday = (Date.today-1).to_s
   unixtime_yesterday = Time.parse(unixtime_yesterday).to_i
   response_yesterday = open("#{url},#{unixtime_yesterday}").read
   weather_yesterday = JSON.parse(response_yesterday)
   @yesterday_weather = weather_yesterday["currently"]["icon"]

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
