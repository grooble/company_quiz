namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "example@yanmar.com",
					   language: "ja",
					   question_language: "en",
                       password: "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@yanmar.com"
    password  = "password"
	language = "en"
	question_language = ["en", "ja", "cn"].sample
    User.create!(name:     name,
                 email:    email,
                 language: language,
				 question_language: language,
				 password: password,
                 password_confirmation: password
				 )
  end
end

def make_microposts
  users = User.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

def make_takens
  users = User.all
  users.each do |taker| 
    tests_taken = rand(1..99)
	for i in 1..tests_taken
	  test_num = rand(1..25)
	  correct = [true, false].sample
	  taker.mark(test_num, correct)
	end
  end
end