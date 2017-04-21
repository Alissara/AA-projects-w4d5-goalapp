class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    uname = params[:user][:username]
    upass = params[:user][:password]
    @user = User.find_by_credentials(uname, upass)
    if @user
      login(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Invalid username or password"]
      render :new
    end
  end

  def destroy
    logout
    redirect_to users_url
  end
end
