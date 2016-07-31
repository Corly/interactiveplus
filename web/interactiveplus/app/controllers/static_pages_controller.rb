class StaticPagesController < ApplicationController
  def about
  end

  def contact
  end

  def help
  end

  def home
  	if logged_in?
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
end
