FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
	language ["en", "ja", "zh-CN"].sample 
	#language "en"
	question_language ["English", "Japanese", "Chinese"].sample
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end
  
  factory :micropost do
    content "lorem ipsum"
	user
  end
  
  factory :question do
    sequence(:qn) { |n| "Question content #{n}?" }
	language "English"
	option1 "Option 1"
	option2 "Option 2"
	option3 "Option 3"
	correct "correct"
  end
end