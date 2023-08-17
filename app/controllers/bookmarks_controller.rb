class BookmarksController < ApplicationController
  before_action :set_bookmark, only: %i[show destroy]

  def show
  end

  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmarks_params)
    @bookmark.list_id = @list.id
    if @bookmark.save
      redirect_to list_path(@list.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark.destroy
    redirect_to lists_path, status: :see_other
  end

  private

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmarks_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end
end
