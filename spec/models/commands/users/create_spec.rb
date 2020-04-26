require 'rails_helper'

RSpec.describe Commands::User::Create, type: :model do
  context "on success" do
    describe "user_params are valid" do
      it "creates a new User" do
        user_params = {name: "ongo_gablogian", email: "ongo@gablogian.com", password: "danny_devito"}
        Commands::User::Create.call(payload: user_params)
        user = User.first
        expect(user.present?).to be true
      end
    end
  end

  context "on failure" do
    describe "user_params are empty" do
      it "does not create a User" do
        user_params = {}
        expect { Commands::User::Create.call(payload: user_params) }.to raise_error(ActiveModel::ValidationError)
      end
    end
    describe "user_params name is not unique" do
      it "does not create a User" do
        user_params = {name: "ongo_gablogian", email: "ongo@gablogian.com", password: "danny_devito"}
        Commands::User::Create.call(payload: user_params)
        user_params[:email] = "new@email.com"
        expect { Commands::User::Create.call(payload: user_params) }.to raise_error(ActiveModel::ValidationError)
      end
    end
    describe "user_params email is not unique" do
      it "does not create a User" do
        user_params = {name: "ongo_gablogian", email: "ongo@gablogian.com", password: "danny_devito"}
        Commands::User::Create.call(payload: user_params)
        user_params[:name] = "new_name"
        expect { Commands::User::Create.call(payload: user_params) }.to raise_error(ActiveModel::ValidationError)
      end
    end
  end

end
