class SearchesController < ApplicationController

  def search
    query = params[:query] # キーワードの取得
    tags = params[:tags].split(/[[:space:]]+/) # タグの取得（スペース区切りの文字列）

    # クエリとタグを使って検索処理を行う
    @results = if tags.present?
                 Review.joins(:tags)
                       .where('tags.tag_name IN (?)', tags).page(params[:page]).reverse_order
                       .where('title LIKE ? OR body LIKE ?', "%#{query}%", "%#{query}%").page(params[:page]).reverse_order
                       .where(status: :published)
               else
                 Review.where('title LIKE ? OR body LIKE ?', "%#{query}%", "%#{query}%").page(params[:page]).reverse_order
                       .where(status: :published)
               end
    @results_counts = @results.total_count
  end

end
