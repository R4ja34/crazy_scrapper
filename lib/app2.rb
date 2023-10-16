require 'nokogiri'
require 'open-uri'


def extract_data_from_elements(elements)
  data_list = []
  elements.each do |element|
    data = element.text.strip
    data_list << data unless data.empty?
  end
  data_list
end

# Fonction pour extraire des informations à partir d'une URL et une expression XPath
def extract_info_from_url(url, xpath_expression)
  page = Nokogiri::HTML(URI.open(url))
  info_elements = page.xpath(xpath_expression)
  extract_data_from_elements(info_elements)
end

url = "https://annuaire-des-mairies.com/ain.html"
xpath = '//a[contains(@class, "lientxt")]/@href'

array_of_email = []
list_mairie = extract_info_from_url(url, xpath)
list_mairie.each do |suffix, index|
  end_of_url = "/#{suffix}"
  url_mairie = "https://annuaire-des-mairies.com#{end_of_url}"
  xpath_email = '//td[contains(text(), "@")]'
  email = extract_info_from_url(url_mairie, xpath_email)
  if email 
  puts "#{index} : #{email}"
  # array_of_email << email
  # array_of_email
end