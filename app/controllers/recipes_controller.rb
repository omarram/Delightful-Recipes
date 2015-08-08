class RecipesController < ApplicationController
  before_action(:pass_recipe, :only => [:show, :edit, :update, :destroy])
  before_action(:authenticate_user!, :except => [:index, :show])

  def index
    @recipes = Recipe.newest_first
  end

  def show
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to(@recipe, :notice => "Congrats, your recipe is within reach of other hands! ")
    else
      render('new')
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to(@recipe, :notice => "Recipe has been changed successfully")
    else
      render('edit')
    end
  end

  def destroy
    @recipe.destroy
    redirect_to(root_path, :notice => "Recipe has been successfully removed")
  end

  private 
    def recipe_params
      params.require(:recipe).permit(:title, :description, :pic, :ingredients_attributes => [:id, :name, :_destroy], :directions_attributes => [:id, :step, :_destroy])
    end

    def pass_recipe
      @recipe = Recipe.find(params[:id])
    end
end