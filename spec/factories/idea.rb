FactoryBot.define do 
    factory :idea do 
        title { Faker::TvShows::DrWho.quote }
        description { Faker::Hacker.say_something_smart }
        association(:user, factory: :user)
    end
end