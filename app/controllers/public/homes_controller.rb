class Public::HomesController < ApplicationController
  def top
    @coordinates = Coordinate.published.order(created_at: :desc).page(params[:page]).per(4)
  end
end
