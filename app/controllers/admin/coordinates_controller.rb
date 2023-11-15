class Admin::CoordinatesController < ApplicationController
  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @coordinates = @user.coordinates.order(created_at: :desc).page(params[:page]).per(6)
    else
      @coordinates = Coordinate.order(created_at: :desc).page(params[:page]).per(6)
    end
  end

  def show
    @coordinate = Coordinate.find(params[:id])
    @tags = @coordinate.tag_counts_on(:tags)
    @actions = @coordinate.actions.joins(:user)
  end

  def destroy
    coordinate = Coordinate.find(params[:id])
    coordinate.destroy
    redirect_to admin_coordinates_path
  end
end
