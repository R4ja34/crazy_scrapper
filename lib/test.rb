require 'nokogiri'
require 'open-uri'
require 'http'



def crypto_name()
  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
  all_name = []
  name_crypto = page.xpath('//*[@id="__next"]/div[2]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[3]')
  name_crypto.each do |crypto_name|
    name = crypto_name.text.strip
    all_name << name unless name.empty?
  end
  return all_name
end

def crypto_price()
  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
  all_price = []
  price_crypto = page.xpath('//*[@id="__next"]/div[2]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[5]')
  price_crypto.each do |crypto_price|
    price = crypto_price.text.strip
    all_price << price unless price.empty?
  end
  return all_price
end

def crypto_array(names, prices)
  crypto_hash = names.zip(prices).to_h # .zip permet de relier deux liste
  # Créez un tableau à partir du hash
  crypto_a = crypto_hash.map{ |crypt, price| { crypt => price } }
  return crypto_a
end


def perform
name = crypto_name()
price = crypto_price()
crypto_array(name, price)
end


# Fonction pour rechercher une cryptomonnaie par son symbole dans le tableau de hachages
def trouver_prix_crypto_dans_array(array, symbole)
  array.each do |crypto_hash|
    prix = crypto_hash[symbole]
    if prix
      puts "Le prix de #{symbole} est #{prix}"
      return # Si trouvé, sortir de la boucle
    end
  end
  puts "La cryptomonnaie #{symbole} n'a pas été trouvée."
end


def choisir_action
  puts "Choisissez une action :"
  puts "1. tableau de tout les crypto"
  puts "2. recherche du prix d'une crypto pas son symbole"
  print "Entrez votre choix d'action : "
  choix = gets.chomp.to_i

  case choix
  when 1
    puts "Voici l'ensemble du tableau."
    puts perform()
  when 2
    print " veuiller entrer le symbol de la crypto rechercher : "
    symbol_of_crypto = gets.chomp
    trouver_prix_crypto_dans_array(perform(), symbol_of_crypto)
  else
    puts "Choix invalide. Veuillez sélectionner 1 ou 2."
  end
end

choisir_action()

#__next > div.sc-4ee23222-0.jqZPoA.cmc-app-wrapper.cmc-app-wrapper--env-prod.cmc-theme--day > div.container.cmc-main-section > div > div.sc-57cdc47a-0.drcTQP.cmc-view-all-coins > div > div.sc-37735160-0.hfCxNe.cmc-table--sort-by__rank.cmc-table > div:nth-child(3) > div > table > tbody > tr:nth-child(20) > td.cmc-table__cell.cmc-table__cell--sortable.cmc-table__cell--left.cmc-table__cell--hide-sm.cmc-table__cell--sort-by__symbol > div