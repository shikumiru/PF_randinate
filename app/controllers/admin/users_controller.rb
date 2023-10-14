class Admin::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @coordinates = @user.coordinates
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = "会員情報を変更しました。"
    redirect_to request.referer
  end

  private

  def user_params
    params.require(:user).permit(:is_deleted)
  end
end
