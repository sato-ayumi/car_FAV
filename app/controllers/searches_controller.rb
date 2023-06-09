class SearchesController < ApplicationController
  
  def search
    @keyword = params[:keyword]
    if (params[:keyword])[0] == '#'
      @reviews = Tag.search(params[:keyword]).page(params[:page]).reverse_order
    else
      @reviews = Review.search(params[:keyword]).page(params[:page]).reverse_order
    end
  end
  
end
