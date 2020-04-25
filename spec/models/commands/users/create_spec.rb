require 'rails_helper'

RSpec.describe Commands::User::Create, type: :model do
  describe "on success" do
    it "creates a new User" do
      user_params = {name: "ongo_gablogian", email: "ongo@gablogian.com", password: "danny_devito"}
      Commands::User::Create.call(payload: user_params)
      user = User.first
      expect(user.present?).to be true
    end
  end
end
