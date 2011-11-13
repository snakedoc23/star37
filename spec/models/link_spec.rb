require 'spec_helper'

describe "Link" do
  it 'powinno stworzyc link' do
    link = Link.create!(:content => 'test link')
  end
  it 'content nie moze byc pusty' do
    link = Link.new()
    link.should_not be_valid
  end

  it 'content nie moze przkraczac 240 znakow' do
    content = "x" * 241
    link = Link.new(:content => content)
    link.should_not be_valid
  end

  it 'tworzy title' do
    link = Link.create!(:content => 'http://www.google.com')
    link.should respond_to(:title)
    link.title.should == "Google"
  end

  it 'dodaje http do content' do
    link = Link.create!(:content => 'google.com')
    link.should respond_to(:title)
    link.content.should == "http://google.com"
  end
end