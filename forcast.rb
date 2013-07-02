require 'rest-client'
require 'json'
require 'logger'

#API_KEY = ENV['MONGOHQ_URL']
API_KEY =  "0b67c5a90a9961cc59f91d07192fc1c6"
parsed = JSON.parse(RestClient.get(URI.encode("https://api.forecast.io/forecast/#{API_KEY}/37.4220773,-122.0829147")))
log = Logger.new(STDOUT)
log.level = Logger::INFO
if parsed["currently"]["temperature"] > 60.0 
  log.info "HIGH temperature today...(send SMS)"  
else
  log.info "OK"
end

