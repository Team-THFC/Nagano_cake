class Public::ProductsController < ApplicationController

  def index 
    @genres = Genre.all 
    # 商品一覧は販売中の商品のみ表示します。
    @all_products = Product.where(is_active: true).all #DB内の全ての商品（全？件の部分で必要なため）
    @products = Product.where(is_active: true).page(params[:page]) #1ページに10項目ずつ取得
  end

  def show
     @genres = Genre.all
    @product = Product.find(params[:id])
  end

end
