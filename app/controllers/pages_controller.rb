class PagesController < ApplicationController
  def home
    if current_user
      redirect_to(user_path(current_user))
    end
    @title = "Home"
  end
end
