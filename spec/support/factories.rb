FactoryGirl.define do
  factory :bean do
    token
    used_on ['raffle', 'gift', 'none'].sample
    redeemed false
  end
  
  factory :merchant do
    name Faker::Name.name 
    email Faker::Internet.email
    password 'password'
    password_confirmation 'password'
  end
  
  tier_hash = {:first => 100, :second => 50, :third => 20}
  factory :raffle do
    name Faker::Lorem.words(2).join(" ")
    num_of_winner 3
    description Faker::Lorem.words(10).join(",")
    drawing_time Time.now + 10
    repeat  false
    factory :prize do
      p_type Prize::TYPE.sample
      tier tier_hash
    end
  end
  
  factory :token do
    merchant
    beans_count 10
  end
  
  factory :user do
    email Faker::Internet.email
    password 'password'
    password_confirmation 'password'
  end
  
end
