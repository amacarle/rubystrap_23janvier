require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

#def get_towns_url
    page = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/val-d-oise.html"))   
    all_towns_name = page.xpath('//*[@class="lientxt"]')
    towns_arr = all_towns_name.collect(&:text)
#end
#puts towns_arr


#def get_towns_url(town_arr)
    url_arr = []
    towns_arr.each do |i|
        url = "https://www.annuaire-des-mairies.com/95/#{i.downcase.gsub(" ", "-")}"
        url_arr << url
    end 
#end
#puts url_arr


# # def town_and_email(url_arr)
    emails_arr = []
    url_arr.each do |url|
        page = Nokogiri::HTML(open(url))
        all_emails = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
        emails_arr << all_emails.text
    end 
# #end
# puts emails_arr

# #def return_array(crypto_names_arr, crypto_values_arr)
    total = Hash[towns_arr.zip(emails_arr)]
    result = []
    total.each {|k,v| result << {k.capitalize => v } }
#end    
puts result




