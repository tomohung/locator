class UsersController < ApplicationController

  before_action :authenticate

  def create    
    user = User.new(user_params)
    if user.save
      render nothing: true
    else
      render nothing: true, status: :bad_request
    end
  end

  private
    def authenticate
      @user = User.find_by(device_token: params[:device_token])
    end

    def user_params
      params.require(:user).permit(:device_token)
    end

end