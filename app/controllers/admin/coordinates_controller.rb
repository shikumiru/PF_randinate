class Admin::CoordinatesController < ApplicationController
  def index
    @coordinates = Coordinate.order(created_at: :desc).page(params[:page]).per(12)
  end

  def show
    @coordinate = Coordinate.find(params[:id])
    @tags = @coordinate.tag_counts_on(:tags)
  end

  def destroy
    coordinate = Coordinate.find(params[:id])
    coordinate.destroy
    redirect_to admin_coordinates_path
  end
end
