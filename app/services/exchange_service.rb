require 'open-uri'
require 'json'

module ExchangeService
  extend self

  def call
    json = open('http://apilayer.net/api/live?access_key=2cfa84fee139b0646fd41d5f0148be73&currencies=MXN&source=USD&format=1').read
    JSON.parse(json)["quotes"]["USDMXN"]
  end
end
