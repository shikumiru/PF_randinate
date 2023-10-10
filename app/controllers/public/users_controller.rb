class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @coordinates = @user.coordinates
    @bookmarks = @user.bookmarks
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "会員情報を変更しました。"
      redirect_to public_user_path
    else
      flash[:notice] = "変更内容が正しくありません。"
      redirect_to public_customer_edit_path
    end
  end

  def confirm
  end
end
