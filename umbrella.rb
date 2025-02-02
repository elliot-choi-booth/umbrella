# Write your soltuion here!
require "http"
require "json"
require "dotenv/load"

pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")

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

latitude = location.fetch("lat")
longitude = location.fetch("lng")

pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/" + latitude.to_s + "," + longitude.to_s

pirate_maps_response = HTTP.get(pirate_weather_url)

pm_raw_response = pirate_maps_response.to_s

pm_parsed = JSON.parse(pm_raw_response)

currently = pm_parsed.fetch("currently")

summary = currently.fetch("summary")
temperature = currently.fetch("temperature")

pp "It is currently #{temperature} degrees outside, and #{summary.downcase}."
