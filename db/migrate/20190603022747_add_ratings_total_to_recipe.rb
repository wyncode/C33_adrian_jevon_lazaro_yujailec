class AddRatingsTotalToRecipe < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :ratings_total, :integer
  end
end
