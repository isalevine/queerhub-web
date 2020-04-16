class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]

  def create
    puts "hello from create!"
    user = User.new(user_params)
    if user.save
      puts "new user saved!!!"
    end
  end

  def destroy
    puts "hello from destroy!"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end