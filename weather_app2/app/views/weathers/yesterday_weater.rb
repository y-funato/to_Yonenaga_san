require "json"
require "open-uri"
require 'time'

unixtime_yesterday = (Date.today-1).to_s
unixtime_yesterday = Time.parse(unixtime_yesterday).to_i

response_yesterday = open("https://api.darksky.net/forecast/080fa7f90e3e587b2de824aa0bcc0dd4/" + "35.6895,139.6917,#{unixtime_yesterday}").read

weather_yesterday = JSON.parse(response_yesterday)
yesterday_weather = weather_yesterday["currently"]["icon"]

puts "昨日の天気:#{yesterday_weather}"
