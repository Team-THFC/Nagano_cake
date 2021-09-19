class Public::GenresController < ApplicationController

  def search
    @search_genre = Product.search(params[:keyword]).page(params[:page])
    @keyword = params[:keyword]
    @genres = Genre.all
    render "search"
  end

  def search_genre
    @value = params[:genre_id]
    @search_genre = Product.where(genre_id: @value).page(params[:page])
    @genres = Genre.all
    render "search"
  end
end
