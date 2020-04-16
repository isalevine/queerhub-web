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
    user = User.find(user_params[:id])
    if user.destroy
      puts "user id #{user_params[:id]} deleted!!!"
    end
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation)
  end
end