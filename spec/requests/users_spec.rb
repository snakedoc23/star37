require 'spec_helper'

describe "Users" do
  # describe "GET /users" do
  #   it "works! (now write some real specs)" do
  #     # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
  #     get users_path
  #     response.status.should be(200)
  #   end
  # end

  describe "GET /users" do
    it 'powinien wyswietlic usera test' do
      user = User.create!(:email => 'test@test.pl', :password => 'test')
      visit users_path
      page.should have_content user.email
    end
  end

  describe "POST /users" do
    it 'powinno dodac nowego usera' do
      visit root_path
      click_link 'login'
      click_link 'signup'
      page.should have_content 'Sign Up'
      fill_in 'user_email', :with => 'test@test.com'
      fill_in 'user_password', :with => 'password'
      fill_in 'user_password_confirmation', :with => 'password'
      click_button 'Sign Up'
      current_path.should == root_path
      page.should have_content 'Signed Up!'
    end
    it 'nie powinno dodanc usera' do
      visit signup_path
      fill_in 'user_email', :with => 'test@test.com'
      fill_in 'user_password', :with => 'password'
      fill_in 'user_password_confirmation', :with => ''
      click_button 'Sign Up'
      page.should have_selector 'div.errors_messages'
    end
  end

  describe 'DELETE /users' do
    it 'powinno usunac usera' do
      user = User.create!(:email => 'test@test.pl', :password => 'test')
      visit users_path
      page.should have_content user.email
      find('.user').click_link 'Delete'
      page.should have_no_content user.email
      page.should have_content 'User Deleted'
    end
  end

  describe 'log in user' do
    before do 
      @user = User.create!(:email => 'test@test.pl', :password => 'test')
    end
    it 'should log in user' do
      visit log_in_path
      fill_in 'email', :with => 'test@test.pl'
      fill_in 'password', :with => 'test'
      click_button 'Log in'
      current_path.should == root_path
      page.should have_content 'Logged in!'
      # page.should have_content @user.email
    end
    it 'should not log in user' do
      visit log_in_path
      fill_in 'email', :with => 'test@test.pl'
      fill_in 'password', :with => 'wrong'
      click_button 'Log in'
      page.should have_content 'Invalid'
      current_path.should == sessions_path
      # page.should have_content @user.email
    end
    it 'should log in and log out user' do
      visit root_path
      click_link 'Login'
      fill_in 'email', :with => 'test@test.pl'
      fill_in 'password', :with => 'test'
      click_button 'Log in'
      page.should have_content 'Logged in!'
      current_path.should == root_path

      click_link 'Log out'
      page.should have_content 'Logged out!'
      page.should have_content 'Login'
    end
  end

end
