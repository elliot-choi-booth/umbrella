# Write your soltuion here!
require "http"
require "json"
require "dotenv/load"

pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")

pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/41.8887,-87.6355"

pp "Where are you located?"

user_location = gets.chomp.gsub(" ", "%20")
#user_location = "Chicago"

pp user_location

maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location +"&key=" + ENV.fetch("GMAPS_KEY") 

response = HTTP.get(maps_url)

raw_response = response.to_s

parsed_response = JSON.parse(raw_response)

results = parsed_response.fetch("results")

first_result = results.at(0)

geo = first_result.fetch("geometry")

location = geo.fetch("location")

pp latitude = location.fetch("lat")
pp longitude = location.fetch("lng")
