require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'will successfully save as a User' do
      @user = User.new(first_name: "Sid", last_name: "nat", email: "sidnat@gmail.com", password: "lighthouse", password_confirmation: "lighthouse")
      @user.save!
      expect(@user.id).to be_present
    end

    it 'is not valid without a first name' do
      @user = User.new(first_name: nil, last_name: "nat", email: "sidnat@gmail.com", password: "lighthouse", password_confirmation: "lighthouse")
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'is not valid without a last name' do
      @user = User.new(first_name: "Sid", last_name: nil, email: "sidnat@gmail.com", password: "lighthouse", password_confirmation: "lighthouse")
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'is not valid without an email' do
      @user = User.new(first_name: "Sid", last_name: "nat", email: nil, password: "lighthouse", password_confirmation: "lighthouse")
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'is not valid without a password' do
      @user = User.new(first_name: "Sid", last_name: "nat", email: "sidnat@gmail.com", password: nil, password_confirmation: "lighthouse")
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'is not valid without a password confirmation' do
      @user = User.new(first_name: "Sid", last_name: "nat", email: "sidnat@gmail.com", password: "lighthouse", password_confirmation: nil)
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'is not valid if password and password confirmation are different' do
      @user = User.new(first_name: "Sid", last_name: "nat", email: "sidnat@gmail.com", password: "lighthouse", password_confirmation: "lightyhousey")
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'is not valid if email is not unique' do
      @user = User.new(first_name: 'Sid', last_name: 'nat', email:'sidnat@gmail.com', password:'lighthouse', password_confirmation:'lighthouse')
      @user.save
      @testuser = User.new(first_name: 'Sidy', last_name: 'naty', email:'SIDNAT@gmail.com', password:'lighthousey', password_confirmation:'lighthousey')
      @testuser.save
      expect(@testuser).to be_invalid
      expect(@testuser.errors.full_messages).to include("Email has already been taken")
    end

    it "if not valid if password is short" do
      @user = User.new(first_name: 'Sid', last_name: 'nat', email:'sidnat@gmail.com', password:'s', password_confirmation:'s')
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it "returns valid user if authenticated" do
      @user = User.new(first_name: 'Sid', last_name: 'nat', email:'sidnat@gmail.com', password:'lighthouse', password_confirmation:'lighthouse')
      @user.save
      @authenticated_user = User.authenticate_with_credentials("sidnat@gmail.com", "lighthouse")
      expect(@authenticated_user.id).to be_present
      expect(@authenticated_user.first_name).to eq("Sid")
      expect(@authenticated_user.last_name).to eq("nat")
      expect(@authenticated_user.email).to eq("sidnat@gmail.com")
    end

    it "returns valid user with non case-sensitive email" do
      @user = User.new(first_name: 'Sid', last_name: 'nat', email:'sidnat@gmail.com', password:'lighthouse', password_confirmation:'lighthouse')
      @user.save
      @authenticated_user = User.authenticate_with_credentials('SIDNAT@gmail.com', "lighthouse")
      expect(@authenticated_user.id).to be_present
      expect(@authenticated_user.first_name).to eq("Sid")
      expect(@authenticated_user.last_name).to eq("nat")
      expect(@authenticated_user.email).to eq("sidnat@gmail.com")
    end

    it "returns valid user with extra spaces surrounding email" do
      @user = User.new(first_name: 'Sid', last_name: 'nat', email:'sidnat@gmail.com', password:'lighthouse', password_confirmation:'lighthouse')
      @user.save
      @authenticated_user = User.authenticate_with_credentials('    SIDNAT@gmail.com         ', "lighthouse")
      expect(@authenticated_user.id).to be_present
      expect(@authenticated_user.first_name).to eq("Sid")
      expect(@authenticated_user.last_name).to eq("nat")
      expect(@authenticated_user.email).to eq("sidnat@gmail.com")
    end

    it "returns nil if no email is entered" do
      @user = User.new(first_name: 'Sid', last_name: 'nat', email:'sidnat@gmail.com', password:'lighthouse', password_confirmation:'lighthouse')
      @user.save
      @authenticated_user = User.authenticate_with_credentials(nil, "lighthouse")
      expect(@authenticated_user).to be_nil
    end
    
    it "returns nil with wrong email" do
      @user = User.new(first_name: 'Sid', last_name: 'nat', email:'sidnat@gmail.com', password:'lighthouse', password_confirmation:'lighthouse')
      @user.save
      @authenticated_user = User.authenticate_with_credentials("sidmat@gmail.com", "lighthouse")
      expect(@authenticated_user).to be_nil
    end

    it "returns nil if no password is entered" do
      @user = User.new(first_name: 'Sid', last_name: 'nat', email:'sidnat@gmail.com', password:'lighthouse', password_confirmation:'lighthouse')
      @user.save
      @authenticated_user = User.authenticate_with_credentials("sidnat@gmail.com", nil)
      expect(@authenticated_user).to be_nil
    end

    it "returns nil with wrong password" do
      @user = User.new(first_name: 'Sid', last_name: 'nat', email:'sidnat@gmail.com', password:'lighthouse', password_confirmation:'lighthouse')
      @user.save
      @authenticated_user = User.authenticate_with_credentials("sidnat@gmail.com", "lighttthouse")
      expect(@authenticated_user).to be_nil
     end
  end
end