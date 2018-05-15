class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(up)
    if @user.save
      login(@user)
      redirect_to user_url(@user)
    else 
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def up
    params.require(:user).permit(:username, :password)
  end
  
end
