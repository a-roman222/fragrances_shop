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
    # URLs for men's and women's fragrances
    urls = [
      'https://www.lasfragancias.com/perfumes/perfumes-de-hombre-premium?PS=48',
      'https://www.lasfragancias.com/perfumes/perfumes-de-mujer-premium?PS=48'
    ]
  
    urls.each do |url|
      html = URI.open(url)
      doc = Nokogiri::HTML(html)
    
      doc.css('.prateleira.vitrine.n3colunas li.perfumes').each do |perfume|
        name = perfume.css('.product-name a').text.strip
        price = perfume.css('.best-price').text.gsub(/[^\d\.]/, '').to_f.round
        img_url = perfume.css('.product-image img').attr('src').value
        url = perfume.css('.product-image').attr('href').value
        brand = perfume.css('.marca-prod a').text.strip
        description = "#{name} by #{brand}" # Default description; can be customized further
    
        availability = true
        stock = 10
        genre_id = url.include?('hombre') ? 1 : 2  # Set genre based on URL
        brand_id = 1 # Placeholder; you should ideally match with brand information
        group_id = 1 # Placeholder group, adjust as necessary
    
        # Add the fragrance to the global array
        $all_fragrances << {
          name: name,
          price: price,
          url_img: img_url,
          description: description,
          availability: true,
          stock: 100,
          genre: genre_id,  # Use genre_id dynamically based on the URL
          brand: brand,
          group_id: group_id
        }
    
        # Create the fragrance record in the database
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
    end
  
    puts "Seeded Fragrances from both Men and Women"
  end
  
  # Call the function to scrape and seed
  scrape_and_seed
  
  # Inspect the global fragrances array
  puts $all_fragrances.inspect



scrape_and_seed
puts $all_fragrances.inspect