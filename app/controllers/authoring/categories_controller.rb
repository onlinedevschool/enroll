class Authoring::CategoriesController < Authoring::ApplicationController
  def index
    categories
  end

  def new
    new_category
  end

  def edit
    category
  end

  def show
    category
  end

  def create
    if new_category(category_params).save
      redirect_to authoring_categories_path
    else
      render :new
    end
  end

  def update
    if category.update_attributes(category_params)
      redirect_to authoring_categories_path
    else
      render :edit
    end
  end

private

  def categories
    @categories ||= Category.all
  end

  def new_category(attrs={})
    @category ||= Category.new(attrs)
  end

  def category
    @category ||= Category.fuzzy(params[:id])
  end

  def category_params
    params.require(:category).
      permit(:name)
  end
end

