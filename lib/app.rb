require 'nokogiri'
require 'open-uri'

# Fonction pour extraire des données à partir d'éléments
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

# Fonction pour créer un tableau associatif (hash) à partir de deux listes
def create_hash_from_lists(list1, list2)
  list1.zip(list2).to_h
end

# Fonction pour rechercher le prix d'une crypto par son symbole
def trouver_prix_crypto_dans_hash(data, symbol)
  if data.key?(symbol)
    puts "Le prix de #{symbol} est #{data[symbol]}"
  else
    puts "La cryptomonnaie #{symbol} n'a pas été trouvée."
  end
end

url = "https://coinmarketcap.com/all/views/all/"
xpath_for_crypto_names = '//td[contains(@class, "by__symbol")]'
xpath_for_crypto_prices = '//*[@id="__next"]/div[2]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[5]'

# Exemple d'utilisation pour extraire des données et créer un tableau associatif
crypto_names = extract_info_from_url(url, xpath_for_crypto_names)
crypto_prices = extract_info_from_url(url, xpath_for_crypto_prices)
crypto_data = create_hash_from_lists(crypto_names, crypto_prices)

puts "Choisissez une action :"
puts "1. Afficher l'ensemble du tableau des cryptomonnaies et de leurs prix"
puts "2. Rechercher le prix d'une crypto par son symbole"
print "Entrez votre choix d'action : "
choix = gets.chomp.to_i

case choix
when 1
  puts "Voici l'ensemble du tableau :"
  crypto_data.each do |symbol, price|
    puts "#{symbol}: #{price}"
  end
when 2
  print "Veuillez entrer le symbole de la crypto recherchée : "
  symbol_of_crypto = gets.chomp
  trouver_prix_crypto_dans_hash(crypto_data, symbol_of_crypto)
else
  puts "Choix invalide. Veuillez sélectionner 1 ou 2."
end