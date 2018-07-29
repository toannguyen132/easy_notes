class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    @user.email.downcase!

    if @user.save
      flash[:notice] = "Account created successfully!"
      redirect_to root_path
    else
      flash.now.alert = "Oops, coun't create account."
      render :new
    end
  end

  def profile
    if current_user
      json_response current_user
    else
      # json_response({ message: "Incorrect email or password."}, :unauthorized)
      json_response({ message: "Unauthorization" }, :unauthorized)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
        end
end
