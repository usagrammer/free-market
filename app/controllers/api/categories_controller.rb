class Api::CategoriesController < ApplicationController

  def index
    category = Category.find(params[:category_id])
    @categories = category.children
  end

end
