require 'rest-client'
require 'json'
require 'logger'

RestClient.get(URI.encode("http://staging.educade.org/sethu-test"))
=begin
API_KEY = ENV['API_KEY']

parsed = JSON.parse(RestClient.get(URI.encode("https://api.forecast.io/forecast/#{API_KEY}/37.4220773,-122.0829147")))
log = Logger.new(STDOUT)
log.level = Logger::INFO
if parsed["currently"]["temperature"] > 60.0 
  log.info "HIGH temperature today...(send SMS)"  
else
  log.info "OK"
end
=end

