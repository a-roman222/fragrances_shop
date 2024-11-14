class FragrancesController < ApplicationController
  def fragrance_params
    params.require(:fragrance).permit(:name, :price, :description, :availability, :stock, :image)
    # Add other permitted fields as necessary.
  end
  
  def index
    @q = Fragrance.ransack(params[:q])
    @fragrances = @q.result.includes(:brand, :genre, :group).page(params[:page]).per(10)
    @brands = Brand.all
    @genres = Genre.all
    @groups = Group.all
  end

  def show
    @fragrance = Fragrance.find(params[:id])
  end
end
