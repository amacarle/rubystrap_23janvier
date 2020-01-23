require 'nokogiri'
require 'rubygems'
require 'open-uri'
require 'pry'


def pageUrl
  return page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
end 


def currency_table(page)
  crypto_currency = []
  page.xpath('//*[@id="__next"]/div/div[2]/div[1]/div[2]/div[2]/div[2]/div[3]/div/table/tbody/tr/td[3]').each do |key|
  crypto_currency << key.text
  end
  return crypto_currency
end


def values_table(page)
  currency_value = []
  page.xpath('//*[@id="__next"]/div/div[2]/div[1]/div[2]/div[2]/div[2]/div[3]/div/table/tbody/tr/td[5]').each do |value|
  currency_value << value.text
  end
  return currency_value
end

def cryptohash(crypto_currency, currency_value)
  hash = Hash[crypto_currency.zip(currency_value)]
  array_of_hashes = []
  hash.each{|key, value| array_of_hashes << {key => value.delete("$").to_f}}
  return array_of_hashes
end


def perform
  puts cryptohash(currency_table(pageUrl), values_table(pageUrl))
end
perform