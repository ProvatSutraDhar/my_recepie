class AddTimestampsToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :recipes, null: true
  end
end
