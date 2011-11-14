require 'spec_helper'

describe "Users" do
  # describe "GET /users" do
  #   it "works! (now write some real specs)" do
  #     # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
  #     get users_path
  #     response.status.should be(200)
  #   end
  # end

  describe "rejestracja" do
    it 'powinno dodac nowego usera' do
      visit root_path
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
end
