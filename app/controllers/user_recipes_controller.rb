class UserRecipesController < ApplicationController
  before_action :set_user_recipe, only: [:destroy]
  
  def index
    @user_recipes = current_user.user_recipes.includes(:recipe)
  end

  def create
    id = params[:user_recipe][:id]
    @user_recipe = current_user.user_recipes.new(recipe_id: id)
    @user_recipe.save
    # if @user_recipe.save
    #   flash[:notice] = "Recipe was successfully added to Cookbook"
    # else
    #   flash[:alert] = "Recipe already in your Cookbook."
    # end
    redirect_back fallback_location: root_path
  end

  def destroy
    @user_recipe.destroy
    redirect_back fallback_location: root_path, notice: 'Recipe was successfully removed from Cookbook.'
  end

  private
  def set_user_recipe
    @user_recipe = UserRecipe.find(params[:id])
  end

  def user_recipe_params
    params.require(:user_recipe).permit(:id, :recipe)
  end
end
