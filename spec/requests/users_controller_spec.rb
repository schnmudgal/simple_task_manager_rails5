require 'rails_helper'

describe 'User', type: :request do
  let(:default_user) { User.create(email: 'default_user@example.com', password: 'password') }
  let(:user_1) { User.create(email: 'user_1@example.com', password: 'password') }

  describe 'GET index' do
    context 'User not signed in' do
      before { get '/users' }
      it { expect(response).to redirect_to(new_session_path) }
    end

    context 'User signed in' do
      before do
        post session_path, params: { user: { email: default_user.email, password: default_user.password } }
        get users_path
      end

      it 'renders index template' do
        expect(response).to have_http_status(200)
        expect()
      end
    end

  end
end
