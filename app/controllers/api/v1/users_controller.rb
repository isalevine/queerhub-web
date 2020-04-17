class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]

  def create
    Commands::User::Create.call(payload: user_params)
  end

  def destroy
    # TODO: Replace with Commands::User::Delete.call(payload: user_params)
    Events::User::Destroyed.create!(user_id: user_params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :email, :password)
  end
end