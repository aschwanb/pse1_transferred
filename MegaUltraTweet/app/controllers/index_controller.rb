class IndexController < ApplicationController

  def start
  end

  def about
  end

  def db_search
    q = params[:q]
    if !q.blank?
      dbsearch = DbSearch.new
      @sobj = dbsearch.parse_query(q)
    else
      redirect_to(root_path)
    end

  end
end



