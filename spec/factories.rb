FactoryGirl.define do
  factory :person do
    sequence :first_name do |n|
      "First Name #{n}"
    end
    sequence :last_name do |n|
      "Last Name #{n}"
    end
    birth_date Date.today()
  end
  
end
