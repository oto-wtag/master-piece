require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:artwork) { create(:artwork) }
  let(:comment) { create(:comment, artwork:, user:) }

  before { sign_in user }

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a comment and redirects back" do
        expect {
          post :create, params: { artwork_id: artwork.id, comment: attributes_for(:comment) }
        }.to change(Comment, :count).by(1)
        expect(response).to redirect_to(artworks_path)
      end
    end

    context "with invalid attributes" do
      it "does not create a comment and redirects back with an alert" do
        post :create, params: { artwork_id: artwork.id, comment: attributes_for(:comment, content: nil) }
        expect(Comment.count).to eq(0)
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "PUT #update" do
    it "updates the comment and redirects to the artwork" do
      put :update, params: { artwork_id: artwork.id, id: comment.id, comment: { content: "Updated content" } }
      comment.reload
      expect(comment.content).to eq("Updated content")
      expect(response).to redirect_to(artwork_path(artwork))
    end
  end

  describe "DELETE #destroy" do
    it "deletes the comment and redirects back" do
      comment
      expect { delete :destroy, params: { artwork_id: artwork.id, id: comment.id } }.to change(Comment, :count).by(-1)
      expect(response).to redirect_to(artworks_path)
    end
  end
end
