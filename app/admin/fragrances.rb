ActiveAdmin.register Fragrance do
  permit_params :name, :price, :url_img, :description, :availability, :stock, :genre_id, :group_id, :brand_id

  form do |f|
    f.inputs do
      f.input :name
      f.input :price
      f.input :description
      f.input :availability
      f.input :stock
      f.input :genre
      f.input :group
      f.input :brand
      f.input :url_img, as: :file
    end
    f.actions
  end
end
