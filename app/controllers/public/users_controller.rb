class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @coordinates = @user.coordinates.order(created_at: :desc).page(params[:page]).per(2)
    @bookmarks = @user.bookmarks.order(created_at: :desc).page(params[:page]).per(2)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "会員情報を変更しました。"
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  def deactivate
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を完了しました。ご利用ありがとうございました。"
    redirect_to root_path
  end

  def posts
    user = current_user
    @coordinates = user.coordinates.order(created_at: :desc).page(params[:page]).per(10)
    @published_coordinates = user.coordinates.published.order(created_at: :desc).page(params[:page]).per(10)
    @draft_coordinates = user.coordinates.draft.order(created_at: :desc).page(params[:page]).per(10)
  end

  def bookmarks
    bookmarks = Bookmark.where(user_id: current_user.id).pluck(:coordinate_id)
    @bookmark_coordinates = Coordinate.find(bookmarks)
    @bookmark_coordinates = Kaminari.paginate_array(@bookmark_coordinates.reverse).page(params[:page]).per(10)
  end

  private

  def user_params
    params.require(:user).permit(:name, :gender, :email, :is_deleted)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end
