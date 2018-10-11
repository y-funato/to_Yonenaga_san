require "json"
require "open-uri"
require  'time'



response_precip_hour = open("https://api.darksky.net/forecast/080fa7f90e3e587b2de824aa0bcc0dd4/" + "35.6895,139.6917" + "?extend=hourly").read

precip_hour = JSON.parse(response_precip_hour)

puts precip_hour["hourly"]["data"][0]["precipProbability"]
