require 'test_helper'

class RecipesTestTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "provat", email: "s.provatcsd01@gmil.com",
                         password: "provat", password_confirmation: "provat")
    @recipe= Recipe.create(name: "italian vegitables", description: "amezing italian food coockd for 20 minutes", chef: @chef)
  end

  test "reject invalid recipe update" do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: {recipe: {name: " ", description: " some description"}}
    assert_template 'recipes/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'

  end

  test "successfully edit a recipe" do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    update_name = "update recipe name"
    update_description = " update recipe description"
    patch recipe_path(@recipe), params: {recipe: {name: update_name, description: update_description}}
    assert_redirect_to @recipe
    assert_not flash.empty?
    @recipe.reload
    assert_match update_name, @recipe.name
    assert_match update_description, @recipe.description
  end
end
