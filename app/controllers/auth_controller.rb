class AuthController < ApplicationController
  #protect_from_forgery
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(user_params[:email])
    return redirect_to auth_path, alert: 'Wrong credentials' unless @user
    if @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to auth_path, alert: @user.errors.full_messages.join
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end