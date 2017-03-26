# Factories go here

FactoryGirl.define do
	factory :user do
		sequence :email do |n|
			'dummyEmail#{n}@gmail.com'
		end
		username 'hippoman'
		password 'secretPassword'
		password_confirmation 'secretPassword'
	end
end