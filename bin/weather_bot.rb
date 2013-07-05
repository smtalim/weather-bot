require_relative '../lib/forecast/extract'

forecast = Forecast::Extract.new
forecast.get_weather_forecast
