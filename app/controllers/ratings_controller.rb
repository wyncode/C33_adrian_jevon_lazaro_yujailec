class RatingsController < ApplicationController

  def index
    @recipe = current_user.recipe.find(params[:recipe_id])
  end

  def show
  end

  def create
    @rating = current_user.ratings.build(rating_params)
    @rating.recipe_id = params[:recipe_id]
    @recipe = Recipe.find(params[:recipe_id])
    
    if @rating.save
      @recipe.ratings_sum == nil ? @recipe.ratings_sum = @rating.score : @recipe.ratings_sum += @rating.score.to_i
      @recipe.ratings_total == nil ? @recipe.ratings_total = 1 : @recipe.ratings_total += 1
      @recipe.save

      redirect_back fallback_location: root_path, notice: 'Rating was successfuly posted.'
    else
      redirect_back fallback_location: root_path, alert: @rating.errors.full_messages.to_sentence
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:score, :user)
  end
end