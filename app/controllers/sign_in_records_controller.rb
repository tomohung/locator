class SignInRecordsController < ApplicationController

  before_filter { @user = User.find_by_token(params[:device_token]) }

  def create    
    if @user.nil?
      @user = User.create(device_token: params[:device_token])
      record = @user.sign_in_records.new(sign_in_record_param)
      if record.save
        render nothing: true
        return
      end
    end
    render nothing: true, status: :bad_status
  end

  def show
    if @user
      render nothing: true
    else
      render nothing: true, status: :bad_status
    end
  end

  def update
    if @user
      record = SignInRecord.find(params[:id])
      if record.user_id == @user.id
        if record.update(sign_in_record_param)
          render nothing: true
          return
        end
      end
    end
    render nothing: true, status: :bad_status    
  end

  def destroy
    if @user
      record = SignInRecord.find(params[:id])
      if record.user_id == @user.id
        if record.delete
          render nothing: true
          return
        end
      end
    end
    render nothing: true, status: :bad_status
  end

  private
    def sign_in_record_param
      params.require(:sign_in_record).permit!
    end
end