FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      'dummyEmail#{n}@gmail.com'
    end
    sequence :username do |n|
      'hippoman#{n}'
    end
    password 'secretPassword'
    password_confirmation 'secretPassword'
  end

  factory :game do
    game_title 'meat salad forever'

    association :user
  end

  factory :piece do
    piece_type 'Bishop'
    piece_color 'black'
    x_coordinate 5
    y_coordinate 5

    association :user
    association :game
  end

end

