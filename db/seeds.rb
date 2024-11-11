# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Clear existing data
require 'nokogiri'
require 'open-uri'

Fragrance.destroy_all
Genre.destroy_all
Group.destroy_all
Brand.destroy_all


ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='fragrances'")
ActiveRecord::Base.connection.execute("UPDATE sqlite_sequence SET seq = 0 WHERE name = 'genres'")

ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='groups'")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='brands'")


Genre.create(
    name: "Men",
)
Genre.create(
    name: "Women",
)
Genre.create(
    name: "Unisex",
)
puts "Seeded Genres: Men, Women, Unisex"

Group.create(
    name: "On Sale",
)
Group.create(
    name: "New",
)
Group.create(
    name: "Rare Gem",
)
puts "Seeded Group: On Sale, New, Rare Gem"
Brand.create(
    name: "Jean Paul Gaultier",
)
Brand.create(
    name: "Versace",
)




$all_fragrances = []

def scrape_and_seed
    url = 'https://www.lasfragancias.com/perfumes/perfumes-de-hombre-premium?PS=24'
    html = URI.open(url)
    doc = Nokogiri::HTML(html)
    fragrances = []
  
    # Iterate over product list items
    doc.css('.prateleira.vitrine.n3colunas li.perfumes').each do |perfume|
      
      
      name = perfume.css('.product-name a').text.strip
      price = perfume.css('.best-price').text.gsub(/[^\d\.]/, '').to_f.round
      img_url = perfume.css('.product-image img').attr('src').value
      url = perfume.css('.product-image').attr('href').value
      brand = perfume.css('.marca-prod a').text.strip
      description = "#{name} by #{brand}" # Default description; can be customized further
      

      
      #availability = product['class'].include?('snize-product-in-stock')
      availability = true
  
      # Assuming static data for stock, genre_id, brand_id, group_id for demonstration
      stock = 10 # Placeholder value, adjust as necessary
      genre_id = 1 # Placeholder value for Men's fragrance genre
      brand_id = 1 # Placeholder, ideally match with brand info you may have
      group_id = 1 # Placeholder group, adjust as necessary

      $all_fragrances << {
        name: name,
        price: price,
        url_img: img_url,
        description: description,
        availability: true,
        stock: 100,
        genre: 1,
        brand: brand,
        group_id: 1
      }

      
  
      Fragrance.create!(
        name: name,
        price: price,
        url_img: img_url,
        description: description, # Placeholder description
        availability: availability,
        stock: stock,
        genre_id: genre_id,
        brand_id: brand_id,
        group_id: group_id
      )
    end
    puts "Seeded Men Fragrances"
  end



scrape_and_seed
puts $all_fragrances.inspect