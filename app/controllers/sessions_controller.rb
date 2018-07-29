class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:login][:email].downcase)

    if user && user.authenticate(params[:login][:password])
      session[:user_id] = user.id.to_s

      respond_to do |format|
        format.html {
          flash.now.notice= 'Successfully logged in'
          render :new
        }
        format.json {
          json_response user
        }
      end
    else
      respond_to do |format|
        format.html {
          flash.now.alert = "Incorrect email opr password."
          render :new
        }
        format.json {
          json_response({ message: "Incorrect email or password."}, :unauthorized)
        }
      end
    end
  end

  def destroy
      session.delete(:user_id)
      json_response({ message: "log out successfully" })
  end

end
