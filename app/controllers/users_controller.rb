class UsersController < ApplicationController


  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = "Welcome, #{@user.email} "
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = @current_user
  end

  private

  def user_params
    params.require(:user)
          .permit(:email, :password, :password_confirmation)
  end
end