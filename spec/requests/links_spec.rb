require 'spec_helper'

describe "Links" do
  before do
    @link = Link.create :content => "http://www.google.com"
  end
  describe "GET /links" do
    it "wyswietla linki" do
      visit links_path
      page.should have_content 'oogle'
    end
    it "tworzy nowy link" do
      visit links_path
      fill_in 'link_content', :with => 'test link'
      click_button 'Add'
      current_path.should == links_path
      page.should have_content 'test link'
    end
  end
  describe 'DELETE /links' do
    it 'usuwa link' do
      visit links_path
      find('.link').click_link '\''
      page.should have_no_content 'oogle'
    end
  end
  describe 'PUT /links' do
    it 'edycja linku' do
      visit links_path
      find('.link').click_link 'S'
      current_path.should == edit_link_path(@link)
      find_field('link_content').value.should == 'http://www.google.com'
      fill_in 'link_content', :with => 'test update'
      click_button 'Edit'
      current_path.should == links_path
      page.should have_content 'test update'
    end
  end
  describe 'GET /search' do
    it 'szukane linki' do
      @link2 = Link.create :content => 'http://apple.com'
      visit links_path
      page.should have_content 'pple'
      page.should have_content 'oogle'
      fill_in 'search', :with => 'oo'
      click_button 'search'
      page.should have_content 'oogle'
      page.should have_no_content 'pple'
    end
  end
end
