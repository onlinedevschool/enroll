class Authoring::SeriesController < ApplicationController
  before_action :authenticate_author!

  layout 'authoring'

  def index
    all_series
  end

  def new
    new_series
  end

  def edit
    series
  end

  def show
    series
  end

  def create
    if new_series(series_params).save
      redirect_to authoring_series_index_path
    else
      render :new
    end
  end

  def update
    if series.update_attributes(series_params)
      redirect_to authoring_series_path
    else
      render :edit
    end
  end

private

  def all_series
    @series ||= Series.all
  end

  def new_series(attrs={})
    @series ||= Series.new(attrs)
  end

  def series
    @series ||= Series.fuzzy(params[:id])
  end

  def series_params
    params.require(:series).
      permit(:name)
  end
end

