class Public::CoordinatesController < ApplicationController
  def new
    @coordinate = Coordinate.new
  end

  def create
    @coordinate = Coordinate.new(coordinate_params)
    @coordinate.user_id = current_user.id

    if params[:published].present?
      @coordinate.is_published = :true
    else
      @coordinate.is_published = :false
    end

    if @coordinate.save
      redirect_to coordinate_path(@coordinate)
    else
      render "new"
    end
  end

  def index
    if params[:style] == "メンズ" || params[:style] == "mens"
      @coordinates = Coordinate.mens.published.order(created_at: :desc).page(params[:page]).per(8)
    elsif params[:style] == "レディース" || params[:style] == "ladies"
      @coordinates = Coordinate.ladies.published.order(created_at: :desc).page(params[:page]).per(8)
    elsif params[:style] == "ユニセックス" || params[:style] == "unisex"
      @coordinates = Coordinate.unisex.published.order(created_at: :desc).page(params[:page]).per(8)
    else
      @coordinates = Coordinate.published.order(created_at: :desc).page(params[:page]).per(8)
    end
  end

  def show
    @coordinate = Coordinate.find(params[:id])
    @tags = @coordinate.tag_counts_on(:tags)
  end

  def edit
    @coordinate = Coordinate.find(params[:id])
  end

  def update
    @coordinate = Coordinate.find(params[:id])

    if params[:published].present?
      @coordinate.is_published = :true
    else
      @coordinate.is_published = :false
    end

    if @coordinate.update(coordinate_params)
      redirect_to coordinate_path(@coordinate)
    else
      render "edit"
    end
  end

  def destroy
    coordinate = Coordinate.find(params[:id])
    coordinate.destroy
    redirect_to coordinates_path
  end

  private

  def coordinate_params
    params.require(:coordinate).permit(:coordinate_image, :style, :introduction, :tag_list)
  end
end
