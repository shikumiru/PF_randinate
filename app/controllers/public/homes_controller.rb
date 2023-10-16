class Public::HomesController < ApplicationController
  def top
    @coordinates = Coordinate.order(created_at: :desc)
  end
end
