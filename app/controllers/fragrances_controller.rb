class FragrancesController < ApplicationController
  def fragrance_params
    params.require(:fragrance).permit(:name, :price, :description, :availability, :stock, :image)
    # Add other permitted fields as necessary.
  end
  
  def index
    @fragrances = Fragrance.page(params[:page]).per(10)
  end

  def show
    @fragrance = Fragrance.find(params[:id])
  end
end
