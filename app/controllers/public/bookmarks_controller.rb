class Public::BookmarksController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @coordinate = Coordinate.find(params[:coordinate_id])
    bookmark = current_user.bookmarks.new(coordinate_id: @coordinate.id)
    bookmark.save
  end

  def destroy
    @coordinate = Coordinate.find(params[:coordinate_id])
    bookmark = current_user.bookmarks.find_by(coordinate_id: @coordinate.id)
    bookmark.destroy
  end
end
