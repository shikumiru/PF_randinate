class Public::ActionsController < ApplicationController
  before_action :authenticate_user!

  def create
    @coordinate = Coordinate.find(params[:coordinate_id])
    action = current_user.actions.new(coordinate_id: @coordinate.id, stamp: params[:stamp])
    action.save
    redirect_to coordinate_path(@coordinate)
  end

  def destroy
    @coordinate = Coordinate.find(params[:coordinate_id])
    action = current_user.actions.find_by(coordinate_id: @coordinate.id, stamp: params[:stamp])
    action.destroy
    redirect_to coordinate_path(@coordinate)
  end
end
