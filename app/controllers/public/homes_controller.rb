class Public::HomesController < ApplicationController
  def top
    @coordinates = Coordinate.all
  end
end
