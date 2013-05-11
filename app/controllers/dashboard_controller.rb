class DashboardController < ApplicationController
  
  # what message needs this?
  def index
    if is_msg?
      flash.now[:notice] = current_msg
      clear_msg
    end
     @users = User.all
  end

end
