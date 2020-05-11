Review.delete_all 
Idea.delete_all
User.delete_all

NUM_QUESTION = 100
NUM_USER = 10
PASSWORD = 'supersecret'

NUM_USER.times do
    first_name = Faker::Games::ElderScrolls.first_name
    last_name = Faker::Games::ElderScrolls.last_name
    User.create(
        first_name: first_name,
        last_name: last_name,
        email: Faker::Internet.email,
        password: PASSWORD
    )
end