class SearchesController < ApplicationController

  def search
    query = params[:query] # キーワードの取得
    tags = params[:tags].split(/[[:space:]]+/) # タグの取得（スペース区切りの文字列）

    # クエリとタグを使って検索処理を行う
    @results = if tags.present?
                 Review.joins(:tags)
                       .where('tags.tag_name IN (?)', tags).page(params[:page]).reverse_order
                       .where('title LIKE ?', "%#{query}%").page(params[:page]).reverse_order
               else
                 Review.where('title LIKE ?', "%#{query}%").page(params[:page]).reverse_order
               end
  end

end