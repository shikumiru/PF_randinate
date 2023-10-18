class Public::BookmarksController < ApplicationController
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
