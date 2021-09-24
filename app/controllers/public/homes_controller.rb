class Public::HomesController < ApplicationController

  def top
    @products = Product.order(created_at: :desc).page(params[:page]).per(6) #新着順・４項目のみ表示
    @genres = Genre.all
  end

  def about
  end

end
