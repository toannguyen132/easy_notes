class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token, if: :json_request?

  include Response
  include ExceptionHandler

  def json_request?
    request.format.json?
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

end
