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

  factory :game do
    game_title 'meat salad forever'
    player_turn "black"
    winner_id 0
  end

  factory :piece do
    game_id 123456
    piece_type 'bishop'
    piece_color 'black'
    piece_status 'pretty chill'
    x_coordinate 5
    y_coordinate 5
  end

end