require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  # status codes
  # responses
  # valid / invalid

  describe 'GET #index' do
    it 'renders all users' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #new' do
    it "renders the new page" do
      get :new
      expect(response).to be_success
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    context "with invalid params" do
      it "renders the new page again" do
        pass_params = { user: { username: 'tom', password: 'cat' } }
        post :create, params: pass_params
        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      it 'redirects to the users page' do
        pass_params = { user: { username: 'bob', password: 'password' } }
        post :create, params: pass_params
        expect(response).to redirect_to(user_url(User.last))
      end
    end
  end

  describe 'GET #show' do
    subject(:user) { FactoryGirl.create(:user) }

    context 'with valid user id' do
      it 'renders the user page' do
        get :show, params: {id: user.id}
        expect(response).to be_success
        expect(response).to render_template("show")
      end
    end

    context 'with invalid user id' do
      it 'goes back to the user index' do
        get :show, params: {id: -1}
        expect(response).to redirect_to(users_url)
      end
    end
  end

end
