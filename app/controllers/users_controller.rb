class UsersController < ApplicationController

  def create    
    user = User.new(user_params)
    if user.save
      render nothing: true
    else
      render nothing: true, status: :bad_request
    end
  end

  private
    def user_params
      params.require(:user).permit(:device_token)
    end
end
