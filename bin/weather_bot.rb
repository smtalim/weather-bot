require_relative '../lib/forecast/extract'

forecast = Forecast::Extract.new(37.423021, -122.083739)
forecast.get_weather_forecast
