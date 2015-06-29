require 'rails_helper'

RSpec.describe User, type: :model do
  def valid_attributes(new_attributes={})
    {first_name: "something", last_name: "something",
     email: "something@something.com",
     password: "abcd1234"}.merge(new_attributes)
  end

  # test group
  describe "validations" do

    it "has a first name" do
      user = User.new valid_attributes(first_name: nil)
      expect(user).to be_invalid
    end

    it "requires an email" do
      user = User.new valid_attributes(email: nil)
      user.save
      expect(user.errors.messages).to have_key(:email)
    end

    it "requires a password" do
      user = User.new valid_attributes(password: nil)
      user.save
      expect(user.errors.messages).to have_key(:password)
    end

    it "requires a valid email format" do
      user = User.new valid_attributes(email: "bad email")
      # expect(user).to_not be_valid
      expect(user).to be_invalid
    end
  end

  describe ".full_name" do
    it "returns the first_name and last name if they exist" do
      user = User.new valid_attributes(first_name: "Steve",
                                        last_name: "Galbraith")
      expect(user.full_name).to eq("Steve Galbraith")
    end

    it "returns first_name only if last_name is missing" do
      user = User.new valid_attributes(first_name: "Steve",
                                        last_name: nil)
      expect(user.full_name).to eq("Steve")
    end
  end

  # stretch
  describe "Hashing a password" do
    it "generates password_digest" do
      user = User.new valid_attributes
      # this will check the password_digest exists (meaning not nil)
      expect(user.password_digest).to be
    end
  end
end
