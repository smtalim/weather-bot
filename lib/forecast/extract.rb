require 'rest-client'
require 'json'
require 'mail'

module Forecast  
  class Extract  
    # Default API endpoint
    DEFAULT_FORECAST_IO_API_ENDPOINT = 'https://api.forecast.io'
    
    Mail.defaults do
      delivery_method :smtp, {
        :port                 => 587,
        :address              => "smtp.sendgrid.net",
        :user_name            => ENV['SENDGRID_USERNAME'], # has been set on Heroku
        :password             => ENV['SENDGRID_PASSWORD'], # has been set on Heroku
        :domain               => 'heroku.com',
        :authentication       => :plain,
        :enable_starttls_auto => true
      }
    end
   
    def initialize
      # ENV['API_KEY']    has been set on Heroku
      # ENV['LATITUDE']   has been set on Heroku
      # ENV['LONGITUDE']  has been set on Heroku
      @forecast_url = "#{DEFAULT_FORECAST_IO_API_ENDPOINT}/forecast/#{ENV['API_KEY']}/#{ENV['LATITUDE']},#{ENV['LONGITUDE']}"
    end
    
    def get_weather_forecast
      parsed = JSON.parse(RestClient.get(URI.encode(@forecast_url)))
      msg = "The current weather summary = #{parsed["currently"]["summary"]} and the temperature in F is #{parsed["currently"]["temperature"].to_s}. "
      if !(parsed["alerts"].nil?)
        msg += "An alert has been issued: #{parsed["alerts"][0]["title"]}"
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
