require "json"
require "open-uri"
require 'time'

response_precip_hour = open("https://api.darksky.net/forecast/080fa7f90e3e587b2de824aa0bcc0dd4/" + "35.6895,139.6917" + "?extend=hourly").read

precip_hour = JSON.parse(response_precip_hour)

hour_num = [0,4,8,12,16,20,24]

hour_num.each do |num|
puts "降水確率:#{precip_hour["hourly"]["data"][num]["precipProbability"]}"
end


