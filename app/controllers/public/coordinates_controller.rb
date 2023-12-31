class Public::CoordinatesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :edit]
  before_action :is_matching_login_user, only: [:edit, :update, :desteoy]
  before_action :authorize_coordinate, only: [:show]

  def new
    @coordinate = Coordinate.new
  end

  def create
    @coordinate = Coordinate.new(coordinate_params)
    @coordinate.user_id = current_user.id
    # 投稿の公開・非公開の確認
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
    # ユーザー・スタイル・タグでの検索
    if params[:user_id]
      @user = User.find(params[:user_id])
      user_posts = @user.coordinates
      @coordinates = user_posts.published.order(created_at: :desc).page(params[:page]).per(8)
    elsif params[:style] == "メンズ" || params[:style] == "mens"
      @coordinates = Coordinate.mens.published.order(created_at: :desc).page(params[:page]).per(8)
    elsif params[:style] == "レディース" || params[:style] == "ladies"
      @coordinates = Coordinate.ladies.published.order(created_at: :desc).page(params[:page]).per(8)
    elsif params[:style] == "ユニセックス" || params[:style] == "unisex"
      @coordinates = Coordinate.unisex.published.order(created_at: :desc).page(params[:page]).per(8)
    elsif params[:tag_name]
      @coordinates = Coordinate.tagged_with(params[:tag_name]).published.order(created_at: :desc).page(params[:page]).per(8)
    else
      @coordinates = Coordinate.published.order(created_at: :desc).page(params[:page]).per(8)
    end
  end

  def show
    @coordinate = Coordinate.find(params[:id])
    @tags = @coordinate.tag_counts_on(:tags)
    # 類似画像の検索機能
    if params[:similar].present?
      @coordinate.coordinate_image.blob.open do |file|
        @similar = Vision.get_image_data(file)
      end
    end
    @actions = @coordinate.actions.joins(:user)
  end

  def edit
  end

  def update
    # 投稿の公開・非公開の確認
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
    redirect_to posts_user_path(current_user)
  end

  def random
    @random = Coordinate.find(1)
    # スタイル・マイコーデ・ブックマークからの検索
    if params[:style] == "メンズ"
      @random = Coordinate.find(Coordinate.mens.published.pluck(:id).shuffle[0])
    elsif params[:style] == "レディース"
      @random = Coordinate.find(Coordinate.ladies.published.pluck(:id).shuffle[0])
    elsif params[:style] == "ユニセックス"
      @random = Coordinate.find(Coordinate.unisex.published.pluck(:id).shuffle[0])
    elsif params[:my] == "posts"
      user = current_user
      @random = Coordinate.find(user.coordinates.pluck(:id).shuffle[0])
    elsif params[:my] == "bookmarks"
      bookmarks = Bookmark.where(user_id: current_user.id).pluck(:coordinate_id)
      @random = Coordinate.find(bookmarks.shuffle[0])
    end
    @tags = @random.tag_counts_on(:tags)
    @actions = @random.actions.joins(:user)
  end

  private

  def coordinate_params
    params.require(:coordinate).permit(:coordinate_image, :style, :introduction, :tag_list)
  end

  def is_matching_login_user
    @coordinate = Coordinate.find(params[:id])
    unless @coordinate.user == current_user
      redirect_to coordinates_path
    end
  end

  def authorize_coordinate
    @coordinate = Coordinate.find(params[:id])
    if user_signed_in?
      unless @coordinate && (@coordinate.user == current_user || @coordinate.is_published?)
        redirect_to root_path, notice: "非公開の投稿にはアクセスできません。"
      end
    else
      unless @coordinate && @coordinate.is_published?
        redirect_to root_path, notice: "非公開の投稿にはアクセスできません。"
      end
    end
  end
end
