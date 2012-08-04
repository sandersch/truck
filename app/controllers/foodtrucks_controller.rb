class FoodtrucksController < ApplicationController
  respond_to :json

  def index
    respond_with Foodtruck.all
  end
end
