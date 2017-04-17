FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "dummyEmail1#{n}@gmail.com"
    end
    sequence :username do |n|
      "hippoman1#{n}"
    end
    password 'secretPassword'
    password_confirmation 'secretPassword'
  end

  factory :game do
    game_title 'meat salad forever'
    #player_black_id -1
    #player_white_id -1
    #player_turn "black"
    #winner_id 0

    association :user
  end

  factory :piece do
    piece_type 'bishop'
    piece_color 'black'
    piece_status 'pretty chill'
    x_coordinate 5
    y_coordinate 5

    association :user
    association :game
  end
end