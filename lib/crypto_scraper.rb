
require 'rubygems'
require 'nokogiri'
require 'open-uri'

def getcryptocurrency
  rates = []
  crypnames = []
  page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all"))  

  page.xpath('/html/body/div/div/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div').each do |tr|
    crypnames << tr.text
  end 

    page.xpath('/html/body/div/div/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/a').each do |tr|
    rates << tr.text.gsub(/[^\d\.]/, '').to_f
  end

  begin
    list = []
    market = Hash.new
    market = Hash[crypnames.zip(rates)]
    list = market.map { |k, v| { k => v } }
    puts list
    puts "This list is an #{list.class} of #{market.count} crypto-currencies' rates in $"
  end

end
getcryptocurrency
