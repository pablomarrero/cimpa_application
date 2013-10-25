require 'spec_helper'

feature 'People management' do

  scenario "create new person" do
    sign_in create(:user)
    person = build(:person)
    visit people_path

    expect{
      
      click_link 'New'      
      fill_in 'First name', with: person.first_name
      fill_in 'Last name', with: person.last_name      
      fill_in 'Birth date', with: person.birth_date.strftime("%F")
      click_button 'Create Person'
    }.to change(Person, :count).by(1)

    expect(current_path).to eq person_path(Person.last)
    expect(page).to have_content person.first_name
  end

  scenario "edit person" do
    person = create(:person)
    sign_in create(:user)

    visit person_path(person)
    click_link 'Edit'
    fill_in 'First name', with: 'New Name'
    fill_in 'Last name', with: 'New Lastname'
    click_button 'Update Person'

    expect(current_path).to eq person_path(person)
    expect(page).to have_content 'New Name'
    expect(page).to have_content 'New Lastname'
  end

  scenario "add friends", js: true do
    person = create(:person)
    friend_one = create(:person)
    friend_two = create(:person)

    sign_in create(:user)    

    visit person_path(person)
    click_link 'Edit'
    click_link 'Add Friend'
    
    within "fieldset.friends" do      
      find("option[value='#{friend_one.id}']").click            
    end

    click_button 'Update Person'
    expect(current_path).to eq person_path(person)
    expect(page).to have_content friend_one.first_name
  end

  scenario "delete person" do
    person = create(:person)
    sign_in create(:user)

    visit person_path(person)

    expect{
      click_link 'Delete'
    }.to change(Person, :count).by(-1)
    expect(current_path).to eq people_path
  end  

end
