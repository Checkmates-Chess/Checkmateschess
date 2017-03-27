require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
	describe 'static_pages#home action' do
  	it 'should succesfully show the home page' do
  		get :home
  		expect(response).to have_http_status(:success)
  	end
  end
  
	describe 'static_pages#lobby action' do
		it 'should successfully show the lobby page' do
			get :lobby
			expect(response).to have_http_status(:success)
		end
  end
end