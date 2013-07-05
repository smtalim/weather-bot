require 'rest-client'
require 'json'
require 'mail'

module Forecast  
  class Extract  
    # Default API endpoint
    DEFAULT_FORECAST_IO_API_ENDPOINT = 'https://api.forecast.io'
    
    API_KEY = '7646eeb396a97ec9481b2727933f0e03'

    Mail.defaults do
      delivery_method :smtp, {
        :port      => 587,
        :address   => "smtp.mandrillapp.com",
        :user_name => ENV['MANDRILL_USERNAME'],
        :password  => ENV['MANDRILL_APIKEY'],
        :domain =>    'heroku.com',
        :authentication => :plain
      }
    end
   
    def initialize(latitude, longitude)
      @latitude  = latitude
      @longitude = longitude
      @forecast_url = "#{DEFAULT_FORECAST_IO_API_ENDPOINT}/forecast/#{API_KEY}/#{@latitude},#{@longitude}"
    end
    
    def get_weather_forecast
      parsed = JSON.parse(RestClient.get(URI.encode(@forecast_url)))
      msg = "The current weather summary = "+"#{parsed["currently"]["summary"]}"+" and the temperature in F is "+"#{parsed["currently"]["temperature"].to_s}. "
      if !(parsed["alerts"].nil?)
        msg += "An alert has been issued: "+"#{parsed["alerts"][0]["title"]}"
      end
      send_email(msg)
    end
    
    private
    def send_email(msg)
      mail = Mail.deliver do
        to      'satish.talim@gmail.com'
        from    'Satish Talim <satish@rubylearning.org>' # Your from name and email address
        subject 'Your weather report!'

        text_part do
          body msg
        end
      end
    end
  end  
end 

forecast = Forecast::Extract.new(37.423021, -122.083739)
forecast.get_weather_forecast
