require "json"
require "open-uri"
require 'time'

for num in 1..7 do
  unixtime_week = (Date.today+num).to_s
  unixtime_week = Time.parse(unixtime_week).to_i
  response_week = open("https://api.darksky.net/forecast/080fa7f90e3e587b2de824aa0bcc0dd4/" + "35.6895,139.6917,#{unixtime_week}").read
  weather_week = JSON.parse(response_week)
  week_weather = weather_week["currently"]["icon"]
end
