class UsersController < ApplicationController

  def index
    @users  = User.asc(:email).page(params[:page]).per(50)
  end

end
