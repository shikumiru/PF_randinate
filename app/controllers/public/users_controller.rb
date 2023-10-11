class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @coordinates = @user.coordinates
    @bookmarks = @user.bookmarks
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
      flash[:notice] = "変更内容が正しくありません。"
      redirect_to "edit"
    end
  end

  def deactivate
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を完了しました。ご利用ありがとうございました。"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :gender, :email)
  end
end
