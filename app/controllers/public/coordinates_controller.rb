class Public::CoordinatesController < ApplicationController
  def new
    @coordinate = Coordinate.new
  end

  def index
  end

  def show
    @coordinate = Coordinate.find(params[:id])
    @tags = @coordinate.tag_counts_on(:tags)
  end

  def edit
  end

  private

  def coordinate_params
    params.require(:coordinate).permit(:coordinate_image, :style, :introduction, :tag_list)
  end
end
