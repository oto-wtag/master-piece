require 'rails_helper'

RSpec.describe ArtistDetailsController, type: :controller do
  # Setup test users and associated artist details
  let(:user) { create(:user) }
  let(:artist_detail) { create(:artist_detail, user: user) }

  # Mock the current user to simulate logged-in state
  before do
    sign_in user  # assuming you are using Devise for authentication
  end

  describe 'GET #new' do
    it 'assigns a new ArtistDetail to @artist_detail' do
      get :new

      expect(assigns(:artist_detail)).to be_a_new(ArtistDetail)
    end

    it 'renders the new template' do
      get :new

      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) { { artist_detail: { instagram_link: 'https://instagram.com/user', pinterest_link: 'https://pinterest.com/user' } } }

      it 'creates a new artist detail' do
        expect {
          post :create, params: valid_params
        }.to change(ArtistDetail, :count).by(1)
      end

      it 'redirects to the user profile with a success message' do
        post :create, params: valid_params

        expect(response).to redirect_to(user_path(user))
        expect(flash[:notice]).to eq('Artist detail was successfully created.')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { artist_detail: { instagram_link: '', pinterest_link: '' } } }

      it 'does not create an artist detail' do
        expect {
          post :create, params: invalid_params
        }.not_to change(ArtistDetail, :count)
      end

      it 'renders the new template with errors' do
        post :create, params: invalid_params

        expect(response).to render_template(:new)
        expect(flash[:alert]).to be_nil
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested artist_detail to @artist_detail' do
      get :edit, params: { id: artist_detail.id }

      expect(assigns(:artist_detail)).to eq(artist_detail)
    end

    it 'renders the edit template' do
      get :edit, params: { id: artist_detail.id }

      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:valid_params) { { artist_detail: { instagram_link: 'https://instagram.com/updateduser', pinterest_link: 'https://pinterest.com/updateduser' } } }

      it 'updates the artist detail and redirects to the user profile with a success message' do
        patch :update, params: { id: artist_detail.id }.merge(valid_params)

        artist_detail.reload
        expect(artist_detail.instagram_link).to eq('https://instagram.com/updateduser')
        expect(artist_detail.pinterest_link).to eq('https://pinterest.com/updateduser')
        expect(response).to redirect_to(user_path(user))
        expect(flash[:notice]).to eq('Artist detail was successfully updated.')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { artist_detail: { instagram_link: '', pinterest_link: '' } } }

      it 'does not update the artist detail and renders the edit template with errors' do
        patch :update, params: { id: artist_detail.id }.merge(invalid_params)

        artist_detail.reload
        expect(artist_detail.instagram_link).not_to eq('')
        expect(artist_detail.pinterest_link).not_to eq('')
        expect(response).to render_template(:edit)
        expect(flash[:alert]).to be_nil
      end
    end
  end
end
