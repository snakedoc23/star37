require 'spec_helper'

describe User do
  it 'wymaga email' do
    user = User.new(:email => '', :password => 'test')
    user.should_not be_valid
  end
  it 'poprawnosc formatu email' do
    correct_email = "diamond@example.com"
    wrong_email = "test@com"
    user1 = User.new(:email => correct_email, :password => 'test')
    user2 = User.new(:email => wrong_email, :password => 'test')
    user1.should be_valid
    user2.should_not be_valid
  end
  it "email nie moze sie powtarzac" do
    correct_email = "diamond@example.com"
    user1 = User.create!(:email => correct_email, :password => 'test')
    user2 = User.new(:email => correct_email, :password => 'test')
    user1.should be_valid
    user2.should_not be_valid
  end

  describe 'password' do
    before do
      @user = User.new(:email => 'test@test.com')
    end
    it 'user posiada atrybut password' do
      @user.should respond_to(:password)
    end
    it 'user posiada atrybut password_confirmation' do
      @user.should respond_to(:password_confirmation)
    end
    it 'password i password_confiramtion nie sa takie same' do
      @user.password = 'test'
      @user.password_confirmation = 'test1'
      @user.should_not be_valid
    end
    it 'password i password_confiramtion sa takie same' do
      @user.password = 'test'
      @user.password_confirmation = 'test'
      @user.should be_valid
    end
  end

  describe 'authentication' do
    before do
      @pass = 'test'
      @email = 'test@test.com'
      @user = User.create!(:email => @email, :password => @pass)
    end
    it 'znajduje przez email' do
      user = User.find_by_email(@email)
      user.should_not be_false
    end
    it 'nie znajduje przez email' do
      user = User.find_by_email('test2@gmail.com')
      user.should be_false
    end
    it 'posiada password_digest' do
      @user.should respond_to(:password_digest)
    end
    it 'prawidlowe haslo' do
      user = @user.authenticate(@pass)
      user.should_not be_false
    end
    it 'bledne haslo' do
      user = @user.authenticate('password')
      user.should be_false
    end
    it 'email i haslo' do
      user = User.find_by_email(@email).authenticate(@pass)
      user.should_not be_false
    end
  end
end
