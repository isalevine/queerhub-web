require 'rails_helper'

RSpec.describe Commands::User::Destroy, type: :model do
  context "on success" do
    describe "user_params are valid" do
      it "destroys the User" do
        user_params = {name: "ongo_gablogian", email: "ongo@gablogian.com", password: "danny_devito"}
        Commands::User::Create.call(payload: user_params)
        user = User.first
        expect(user.deleted?).to be false
        user_params = {id: user.id}
        Commands::User::Destroy.call(payload: user_params)
        user = User.first
        expect(user.deleted?).to be true
      end
    end
  end
  
  context "on failure" do
    describe "User with id does not exist" do
      it "raises an error" do
        user_params = {name: "ongo_gablogian", email: "ongo@gablogian.com", password: "danny_devito"}
        Commands::User::Create.call(payload: user_params)
        user_id = User.first.id
        user_params = {id: user_id + 1}
        expect { Commands::User::Destroy.call(payload: user_params) }.to raise_error(ActiveModel::ValidationError)
      end
    end
    # TODO: how granular should unit tests get with testing types and nil?
    # i.e. should the string/non-integer and nil tests below be combined?
    describe "id is not an integer" do
      it "raises an error" do
        user_params = {id: "not an integer"}
        expect { Commands::User::Destroy.call(payload: user_params) }.to raise_error(ActiveModel::ValidationError)
      end
    end
    describe "id is nil" do
      it "raises an error" do
        user_params = {id: nil}
        expect { Commands::User::Destroy.call(payload: user_params) }.to raise_error(ActiveModel::ValidationError)
      end
    end
  end
end