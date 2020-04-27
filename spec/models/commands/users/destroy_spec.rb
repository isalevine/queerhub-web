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
end