# app/admin/fragrances.rb
ActiveAdmin.register Fragrance do

  permit_params :name, :price, :description, :availability, :stock, :brand_id, :genre_id, :group_id, :image
  # Define filters explicitly to avoid conflicts with image attachments
  filter :name


  form do |f|
    f.inputs do
      f.input :name
      f.input :price
      f.input :description
      f.input :availability
      f.input :stock
      f.input :brand
      f.input :genre
      f.input :group
      f.input :image, as: :file # File upload for the image
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :price
    column :description
    column :availability
    column :stock
    column :brand
    column :genre
    column :group
    column "Image" do |fragrance|
      image_tag fragrance.image, size: "50x50" if fragrance.image.attached?
    end
    actions
  end

end
