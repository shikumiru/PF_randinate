class Admin::CoordinatesController < ApplicationController
  def index
    @coordinates = Coordinate.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end
end
