require "json"
require "open-uri"
require 'time'

 response_today = open("https://api.darksky.net/forecast/080fa7f90e3e587b2de824aa0bcc0dd4/" + "35.6895,139.6917").read

weather = JSON.parse(response_today)

today_weather = weather["currently"]["icon"]

temp_high = (weather["daily"]["data"][0]["apparentTemperatureMax"] - 32) / 1.8
temp_high = temp_high.floor(2)

temp_low = (weather["daily"]["data"][0]["apparentTemperatureMin"] -32) / 1.8
temp_low = temp_low.floor(2)

precip = weather["daily"]["data"][0]["precipProbability"]


puts "今日の天気:#{today_weather}"
puts "今日の最高気温:#{temp_high}"
puts "今日の最低気温:#{temp_low}"
puts "今日の降水確率:#{precip}"
