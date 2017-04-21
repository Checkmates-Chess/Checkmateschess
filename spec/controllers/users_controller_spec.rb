require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	describe 'users#show action' do
		it "should successfully show the users show page" do
			user = FactoryGirl.create(:user)
			sign_in user
			
			get :show, params: { id: user.id }
			expect(response).to have_http_status(:success)
		end
	end
end