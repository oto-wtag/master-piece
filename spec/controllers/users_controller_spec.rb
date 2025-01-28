require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  # Setup test users and any other data you need
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  # Mock the current user to simulate logged-in state
  before do
    sign_in user  # assuming you are using Devise for authentication
  end

  describe 'GET #show' do
    it 'assigns @user, @artist_detail, and @artworks' do
      get :show, params: { id: user.id }

      expect(assigns(:user)).to eq(user)
      expect(assigns(:artist_detail)).to eq(user.artist_detail)
      expect(assigns(:artworks)).to eq(user.artworks)
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit, params: { id: user.id }

      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:valid_params) { { user: { name: 'Updated Name', email: 'updated@example.com' } } }

      it 'updates the user and redirects to the user profile' do
        patch :update, params: { id: user.id }.merge(valid_params)

        user.reload
        expect(user.name).to eq('Updated Name')
        expect(user.email).to eq('updated@example.com')
        expect(response).to redirect_to(user_path(user))
        expect(flash[:notice]).to eq('Profile updated successfully.')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { user: { name: '', email: 'invalidemail' } } }

      it 'renders the edit template with errors' do
        patch :update, params: { id: user.id }.merge(invalid_params)

        expect(response).to render_template(:edit)
        expect(flash[:alert]).to be_nil
      end
    end
  end

  describe 'POST #follow' do
    context 'when following a valid user' do
      it 'adds the user to the followed_users and redirects to the user page' do
        expect {
          post :follow, params: { id: other_user.id }
        }.to change { user.followed_users.count }.by(1)

        expect(flash[:notice]).to eq("You are now following #{other_user.name}.")
        expect(response).to redirect_to(other_user)
      end
    end

    context 'when trying to follow oneself' do
      it 'does not allow following oneself' do
        post :follow, params: { id: user.id }

        expect(flash[:alert]).to eq('You cannot follow yourself.')
        expect(response).to redirect_to(user)
      end
    end

    context 'when already following the user' do
      before do
        user.followed_users << other_user
      end

      it 'does not allow following the user again' do
        post :follow, params: { id: other_user.id }

        expect(flash[:alert]).to eq('You are already following this user.')
        expect(response).to redirect_to(other_user)
      end
    end
  end
end
