class FragrancesController < ApplicationController
  def index
    @fragrances = Fragrance.all
  end

  def show
    @fragrance = Fragrance.find(params[:id])
  end
end
