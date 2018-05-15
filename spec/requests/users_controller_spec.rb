require 'rails_helper'

describe 'User', type: :request do
  let(:password) { SecureRandom.alphanumeric(16) }
  let(:default_user) { User.create(email: 'default_user@example.com', password: password) }
  let(:user_1) { User.create(email: 'user_1@example.com', password: password) }

  describe 'GET index' do
    context 'User not signed in' do
      before { get users_path }

      it 'redirects to login page' do
        expect(response).to redirect_to(new_session_path)
        follow_redirect!
        expect(flash[:alert]).to include(I18n.t('controllers.application.failure.not_authenticated'))
      end
    end

    context 'User signed in' do
      before do
        post session_path, params: { user: { email: default_user.email, password: password } }
        get users_path
      end

      it 'renders index page' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET new' do
    context 'User already signed in' do
      before do
        post session_path, params: { user: { email: default_user.email, password: password } }
        get new_user_path
      end

      it 'redirects to users index path' do
        expect(response).to redirect_to(users_path)
        follow_redirect!
        expect(response.body).to include(I18n.t('controllers.users.failure.user_session_present'))
      end
    end

    context 'User not signed in' do
      before { get new_user_path }

      it 'renders login page' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST create' do
    context 'User already signed in' do
      before do
        post session_path, params: { user: { email: default_user.email, password: password } }
        post users_path, params: { user: { email: 'some_email@example.com', password: 'some_password' } }
      end

      it 'redirects to users index path' do
        expect(response).to redirect_to(users_path)
        follow_redirect!
        expect(response.body).to include(I18n.t('controllers.users.failure.user_session_present'))
      end
    end

    context 'User not signed in' do
      before do
        @user_count = User.count
        post users_path, params: { user: { email: 'some_email@example.com', password: 'some_password' } }
      end

      it 'creates new user' do
        expect(response).to redirect_to(new_session_path)
        follow_redirect!
        expect(response.body).to include(I18n.t('controllers.users.success.create'))
        expect(User.count).to eq(@user_count + 1)
      end
    end
  end

  describe 'GET edit' do
    context 'User not signed in' do
      before { get edit_user_path(default_user) }

      it 'redirects to login page' do
        expect(response).to redirect_to(new_session_path)
        follow_redirect!
        expect(flash[:alert]).to include(I18n.t('controllers.application.failure.not_authenticated'))
      end
    end

    context 'User signed in' do
      before do
        post session_path, params: { user: { email: default_user.email, password: password } }
        get edit_user_path(default_user)
      end

      it 'renders edit page' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'PATCH update' do
    context 'User not signed in' do
      before { patch user_path(default_user), params: { data: :does_not_matter } }

      it 'redirects to login page' do
        expect(response).to redirect_to(new_session_path)
        follow_redirect!
        expect(flash[:alert]).to include(I18n.t('controllers.application.failure.not_authenticated'))
      end
    end

    context 'User signed in' do
      let(:new_email) { 'new_email@example.com' }

      before do
        post session_path, params: { user: { email: default_user.email, password: password } }
        patch user_path(default_user), params: { user: { email: new_email } }
      end

      it 'updates user and redirects to index page' do
        expect(response).to redirect_to(user_path(default_user))
        follow_redirect!
        expect(response.body).to include(I18n.t('controllers.users.success.update'))
        expect(default_user.reload.email).to eq(new_email)
      end
    end
  end

  describe 'GET show' do
    context 'User not signed in' do
      before { get user_path(default_user) }

      it 'redirects to login page' do
        expect(response).to redirect_to(new_session_path)
        follow_redirect!
        expect(flash[:alert]).to include(I18n.t('controllers.application.failure.not_authenticated'))
      end
    end

    context 'User signed in' do
      before do
        post session_path, params: { user: { email: default_user.email, password: password } }
        get user_path(default_user)
      end

      it 'renders show page' do
        expect(response).to have_http_status(200)
      end
    end
  end

end
