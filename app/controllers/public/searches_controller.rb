class Public::SearchesController < ApplicationController
  def search
    @tag = params[:tag_name]
    @coordinates = Coordinate.tagged_with(@tag).published.order(created_at: :desc).page(params[:page]).per(8)
  end
end
