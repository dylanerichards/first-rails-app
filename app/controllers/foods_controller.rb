class FoodsController < ApplicationController
  def index
    @foods = Food.all
    @food = Food.last
  end

  def create
    @response = HTTParty.get("https://is-vegan.netlify.app/.netlify/functions/api?ingredients=#{params[:ingredient]}")
    parsed_response = JSON.parse(@response.parsed_response)

    Food.create(name: parsed_response["checkedIngredient"], is_vegan: parsed_response["isVeganSafe"])

    redirect_to :back
  end

  def destroy
    food = Food.find(params[:id])

    food.destroy

    redirect_to :back
  end
end
