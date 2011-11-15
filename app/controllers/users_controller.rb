class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Signed Up!"
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    User.find(params[:id]).destroy
      flash[:success] = "User Deleted"
      redirect_to root_url
  end
end
