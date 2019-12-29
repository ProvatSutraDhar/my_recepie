class ChangeColumnInRecipes < ActiveRecord::Migration[5.2]
  def change
rename_column :receips, :email, :description
change_column :receips, :description, :text 

  end
end
