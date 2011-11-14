require 'spec_helper'

describe UsersController do

  describe 'GET index' do
    it 'should be seccessful' do
      get :index
      response.should be_success
    end
  end

  describe 'GET new' do
    it 'should be successful' do
      get :new
      response.should be_success
    end
  end
  
end
