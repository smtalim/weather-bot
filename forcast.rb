require 'rest-client'
require 'json'
API_KEY = ENV['MONGOHQ_URL']
parsed = JSON.parse(RestClient.get(URI.encode("https://api.forecast.io/forecast/#{API_KEY}/37.4220773,-122.0829147")))
if parsed["currently"]["temperature"] > 60.0 
  p "HIGH temperature today...(send SMS)"  
else
  p "OK"
end
p "Sleep for a day"

