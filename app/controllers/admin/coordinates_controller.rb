class Admin::CoordinatesController < ApplicationController
  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @coordinates = @user.coordinates.order(created_at: :desc).page(params[:page]).per(8)
    else
      @coordinates = Coordinate.order(created_at: :desc).page(params[:page]).per(8)
    end
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
