# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'nokogiri'
require 'open-uri'

ActiveRecord::Base.connection.execute('PRAGMA foreign_keys = OFF;')

# Clean up any existing records
AdminUser.destroy_all
ActiveRecord::Base.connection.execute("UPDATE sqlite_sequence SET seq = 0 WHERE name = 'admin_users'")
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

Genre.destroy_all
Group.destroy_all
Brand.destroy_all
Fragrance.find_each do |fragrance|
  fragrance.image.purge_later if fragrance.image.attached?
  fragrance.destroy
end

ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='fragrances'")
ActiveRecord::Base.connection.execute("UPDATE sqlite_sequence SET seq = 0 WHERE name = 'genres'")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='groups'")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='brands'")

# Seed Genres
genres_list = ['Men', 'Women', 'Unisex']
genres_list.each do |genre|
  Genre.create(name: genre)
end
puts "Seeded Genres: Men, Women, Unisex"

# Seed Groups
groups_list = ['On Sale', 'New', 'Rare Gem']
groups_list.each do |gr|
  Group.create(name: gr)
end
puts "Seeded Groups: On Sale, New, Rare Gem"

# Scraping fragrances and brands
$all_fragrances = []
$all_brands = []

def scrape_and_seed
  # URLs for men's and women's fragrances
  urls = [
    'https://www.lasfragancias.com/perfumes/perfumes-de-hombre-premium?PS=12',
    'https://www.lasfragancias.com/perfumes/perfumes-de-mujer-premium?PS=12'
  ]

  urls.each do |url|
    html = URI.open(url)
    doc = Nokogiri::HTML(html)
  
    doc.css('.prateleira.vitrine.n3colunas li.perfumes').each do |perfume|
      name = perfume.css('.product-name a').text.strip
      price = perfume.css('.best-price').text.gsub(/[^\d\.]/, '').to_f.round
      img_url = perfume.css('.product-image img').attr('src').value
      brand = perfume.css('.marca-prod a').text.strip
      description = "#{name.split.map(&:capitalize).join(' ')} by #{brand}" # Default description; can be customized further
      puts(url)
      availability = true
      stock = 10
      genre_id = url.include?('hombre') ? 1 : 2  # Set genre based on URL
      brand_id = 1 # Placeholder; you should ideally match with brand information
      group_id = 1 # Placeholder group, adjust as necessary
  
      # Add the fragrance to the global array
      $all_fragrances << {
        name: name.split.map(&:capitalize).join(' '),
        price: price,
        url_img: img_url,
        description: description,
        availability: true,
        stock: 100,
        genre: genre_id,  # Use genre_id dynamically based on the URL
        brand: brand
      }
    end
  end
  puts "Scrapped all Fragrances from both Men and Women"
end

# Call the function to scrape and seed
scrape_and_seed

# Create or find Brands
unique_brands = $all_fragrances.map { |product| product[:brand] }.uniq
brand_records = unique_brands.map { |name| Brand.find_or_create_by(name: name) }
puts "Brands created: #{unique_brands.join(', ')}"

# Create Fragrances
unique_products = $all_fragrances.uniq { |product| [product[:name], product[:genre]] }

unique_products.each do |fragrance_data|
  brand = brand_records.find { |b| b.name.casecmp(fragrance_data[:brand]) == 0 }
  if brand
    fragrance = Fragrance.create(
      name: fragrance_data[:name],
      price: fragrance_data[:price],
      description: fragrance_data[:description],
      availability: fragrance_data[:availability],
      stock: fragrance_data[:stock],
      genre_id: fragrance_data[:genre], 
      group_id: rand(1..3),  # Random group (1-3)
      brand_id: brand.id
    )

    # Download the image from the provided URL and attach it to the fragrance
    if fragrance_data[:url_img].present?
      begin
        # Using open-uri to open the image URL
        image = URI.open(fragrance_data[:url_img])

        # Attach the image to the fragrance
        fragrance.image.attach(io: image, filename: "#{fragrance.name.parameterize}.jpg", content_type: 'image/jpeg')

        puts "Image downloaded and attached for #{fragrance.name}"

      rescue => e
        puts "Error downloading or attaching image for #{fragrance.name}: #{e.message}"
      end
    end
  else
    puts "Brand not found for #{fragrance_data[:name]}"
  end
end
ActiveRecord::Base.connection.execute('PRAGMA foreign_keys = ON;')
