Review.delete_all 
Idea.delete_all
User.delete_all

NUM_IDEA = 100
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

users = User.all

NUM_IDEA.times do 
    created_at = Faker::Date.backward(days: 365 * 5)
    i = Idea.create(
        title: Faker::TvShows::DrWho.quote,
        description: Faker::Hacker.say_something_smart,
        user: users.sample, # array method that randomly picks something from an array
        created_at: created_at,
        updated_at: created_at
    )
    if i.valid? 
        i.reviews = rand(0..15).times.map do 
          Review.new(body: Faker::GreekPhilosophers.quote, rating: Faker::Number.within(range: 1..5), user: users.sample)
        end
    end

end

idea = Idea.all 
review = Review.all

puts Cowsay.say("Generated #{idea.count} ideas", :frogs)
puts Cowsay.say("Generated #{review.count} reviews", :tux)
puts Cowsay.say("Generated #{users.count} users", :sheep)