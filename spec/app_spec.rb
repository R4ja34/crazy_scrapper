require_relative '../lib/app.rb'  # Incluez le fichier contenant votre code

describe "the get_name_crypto_in_array method" do
  it "pick up crypto symbols names and show it in an array" do
  expect(crypto_name(Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/")))).to eq(["BTC", "ETH", "USDT", "BNB", "XRP", "USDC", "SOL", "ADA", "DOGE", "TRX", "TON", "DAI", "DOT", "MATIC", "LTC", "WBTC", "BCH", "SHIB", "LINK", "LEO"])
  end
end