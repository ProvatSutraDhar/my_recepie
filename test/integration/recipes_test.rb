require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "provat", email: "s.provatcsd01@gmail.com")
    @recipe = Recipe.create(name: " ", description: " ", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "Deshi food", description: "spicy deshi food cooked for 35 minutes")
    @recipe2.save
  end

    test "should get recipes index" do
      get recipes_path
      assert_response :success
    end

    test "should get recipes listeing " do
      get recipes_path
      assert_template 'recipes/index'
      assert_match @recipe.name, response.body
      assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
      assert_match @recipe2.name, response.body
      assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.description
    end

    test "should get recipe show" do
      get recipes_path
      assert_template 'recipes/show'
      assert_response @recipe.name, response.body
      assert_response @recipe.description, response.body
      assert_template @chef.chefname, response.body
    end

    test "create new valid recipes" do
      get new_recipe_path
      assert_template 'recipes/new'
      name_of_recipe = "chicken saute"
      description_of_recipe = "add chicken, add vegitables, cooked for 20 minutes, serve delicious meal"
      assert_difference 'Recipe.count', 1 do
        post recipes_path, params: {recipe: {name: name_of_recipe, description: description_of_recipe}}
      end
      assert_match name_of_recipe.capitalize, response.body
      assert_match description_of_recipe, response.body
    end

    test "reject invalid submission" do

    get  new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: {recipe: {name: " ", description: " "} }
    end
    assert_template 'recipes/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
    end


end
