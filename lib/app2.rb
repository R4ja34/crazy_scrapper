require 'nokogiri'
require 'open-uri'
require 'json'
require 'google_drive'
require 'csv'


def extract_data_from_elements(elements)
  data_list = []
  elements.each do |element|
    data = element.text.strip
    data_list << data unless data.empty?
  end
  data_list
end

def create_hash_from_lists(list1, list2)
  hash = list1.zip(list2).to_h
end

# Fonction pour extraire des informations à partir d'une URL et une expression XPath
def extract_info_from_url(url, xpath_expression)
  page = Nokogiri::HTML(URI.open(url))
  info_elements = page.xpath(xpath_expression)
  extract_data_from_elements(info_elements)
end

url = "https://www.annuaire-des-mairies.com/01/"
xpath = '//a[contains(text(), ".html")]/@href'

array_of_email = []
ville = []

list_mairie = extract_info_from_url(url, xpath)
list_mairie.each do |suffix|
  end_of_url = "/01/#{suffix}"
  url_mairie = "https://annuaire-des-mairies.com#{end_of_url}"
  xpath_email = '//td[contains(text(), "@")]'
  email = extract_info_from_url(url_mairie, xpath_email)
  if email
    # puts "#{suffix.delete_prefix("./34/").delete_suffix!(".html")} : #{email}"
    array_of_email << email.first
    ville << (suffix.delete_prefix("./34/").delete_suffix!(".html"))
    array_of_email
  end
end

hash_of_ville = create_hash_from_lists(ville, array_of_email)


#####################################################################
#                       methode to convert hash in json
#####################################################################

json_string = hash_of_ville.to_json
# Spécifiez le nom de fichier que vous souhaitez créer
json_filename = "mairies.json"

# Écrire la chaîne JSON dans le fichier
File.open(json_filename, "w") do |file|
  file.write(json_string)
end


#####################################################################
#                       methode to convert hash in json
#####################################################################

# Spécifiez le nom de fichier que vous souhaitez créer
csv_name = "mairies.csv"

# Ouvrez le fichier CSV en mode écriture
CSV.open(csv_filename, "w") do |csv|
  # Écrivez les en-têtes (noms de colonnes) si nécessaire
  csv << ['Ville', 'Email']

  # Parcourez le hash et écrivez les données dans le fichier CSV
  hash_of_ville.each do |ville, email|
    csv << [ville, email]
  end
end