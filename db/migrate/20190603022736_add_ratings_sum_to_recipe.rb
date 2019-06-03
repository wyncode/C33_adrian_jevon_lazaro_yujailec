class AddRatingsSumToRecipe < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :ratings_sum, :integer
  end
end
