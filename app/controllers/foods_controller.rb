class FoodsController < ApplicationController
  def index
    @foods = Food.all
    @food = Food.last
  end

  def create
    @response = HTTParty.get("https://is-vegan.netlify.app/.netlify/functions/api?ingredients=#{params[:ingredient]}")
    parsed_response = JSON.parse(@response.parsed_response)

    food = Food.create(name: parsed_response["checkedIngredient"], is_vegan: parsed_response["isVeganSafe"], calories: rand(8) * 10.0)


    redirect_to root_path
  end

  def destroy
    food = Food.find(params[:id])

    food.destroy

    redirect_to :back
  end

  def show
    @food = Food.find(params[:id])
  end

  def edit
    @food = Food.find(params[:id])
  end

  def update
    food = Food.find(params[:id])
    food.update(food_params)

    redirect_to root_path
  end

  private

  def food_params
    params.require(:food).permit(:name, :calories, :is_vegan)
  end
end
