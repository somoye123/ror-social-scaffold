require 'rails_helper'

RSpec.describe 'Users', type: :request do
  include Devise::Test::IntegrationHelpers

  it 'should redirect if not logged in ' do
    get users_path
    assert_response :redirect
  end

  it do
    get root_path
    should redirect_to(new_user_session_path)
  end

  describe 'Authenticated User Activities' do
    before do
      @user = User.create(name: 'User1', email: 'user1@gmail.com', password: 'password')
      sign_in @user
    end

    it 'Access users #index page successfully' do
      get users_path
      assert_response :success
    end

    it do
      get user_path(@user)
      should render_template('show')
    end

    it 'assigns all users to @users' do
      get users_path
      expect(assigns(:users)).to eq(User.all)
    end
  end
end
