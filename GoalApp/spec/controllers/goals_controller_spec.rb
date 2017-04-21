require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  subject(:user){User.create(username: 'bob', password: 'password')}

  describe "GET #new" do
    it "returns http success and renders new template" do
      get :new, params: {user_id: 1}
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context 'with valid params' do
      it 'renders the goal page' do
      post :create, params: { goal: {user_id: user.id, title: "Football"} }
      expect(response).to render_template(:show)
      end
    end

    context 'with invalid params' do
      before(:each) do
        post :create, params: {goal: {user_id: user.id} }
      end
      it 'renders the new template' do
        expect(response).to render_template(:new)
      end
      it 'flashes errors' do
        expect(flash[:errors]).to be_present
      end
    end
  end

  describe "GET #edit" do
    it "renders edit template" do
      get :edit, params: {id: 1}
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    subject(:goal){Goal.create(user_id: user.id , title: "Get Good")}
    context 'with valid params' do
      it 'renders the goal page' do
      patch :update, params: { id: goal.id, goal: { title: "Football"} }
      expect(response).to render_template(:show)
      end
    end

    context 'with invalid params' do
      before(:each) do
        patch :update, params: {id: goal.id, goal: { title: nil } }
      end
      it 'renders the edit template' do
        expect(response).to render_template(:edit)
      end
      it 'flashes errors' do
        expect(flash[:errors]).to be_present
      end
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: {:id => 1}
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    subject(:goal){Goal.create(user_id: user.id , title: "Get Good")}
    it "redirects to user page" do
      delete :destroy, params: { id: goal.id }
      expect(response).to redirect_to(user_url(user))
    end
  end


end
