FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "user#{n}@pyxisportal.com"
    end    
    password "12345678"
    password_confirmation "12345678"
  end


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
