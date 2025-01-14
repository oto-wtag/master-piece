require 'rails_helper'

RSpec.describe ArtworksController, type: :controller do
  let(:user) { create(:user) }
  let(:artwork) { create(:artwork, user:) }

  before { sign_in user }

  describe "GET #index" do
    it "assigns all artworks and renders the index template" do
      get :index
      expect(assigns(:artworks)).to eq(Artwork.all.order(created_at: :desc))
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "renders the show template" do
      get :show, params: { id: artwork.id }
      expect(assigns(:artwork)).to eq(artwork)
      expect(response).to render_template(:show)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new artwork and redirects to index" do
        post :create, params: { artwork: attributes_for(:artwork) }
        expect(Artwork.count).to eq(1)
        expect(response).to redirect_to(artworks_path)
      end
    end

    context "with invalid attributes" do
      it "does not create an artwork and renders index" do
        post :create, params: { artwork: attributes_for(:artwork, title: nil) }
        expect(Artwork.count).to eq(0)
        expect(response).to render_template(:index)
      end
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      it "updates the artwork and redirects to index" do
        put :update, params: { id: artwork.id, artwork: { title: "Updated Title" } }
        artwork.reload
        expect(artwork.title).to eq("Updated Title")
        expect(response).to redirect_to(artworks_path)
      end
    end

    context "with invalid attributes" do
      it "does not update the artwork and renders edit" do
        put :update, params: { id: artwork.id, artwork: { title: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the artwork and redirects to index" do
      artwork
      expect { delete :destroy, params: { id: artwork.id } }.to change(Artwork, :count).by(-1)
      expect(response).to redirect_to(artworks_path)
    end
  end

  describe "POST #like" do
    it "likes or unlikes an artwork and redirects back" do
      post :like, params: { id: artwork.id }
      expect(user.liked_artworks).to include(artwork)
      post :like, params: { id: artwork.id }
      expect(user.liked_artworks).not_to include(artwork)
    end
  end
end
