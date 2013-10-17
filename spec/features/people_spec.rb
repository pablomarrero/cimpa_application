require 'spec_helper'

feature 'People management' do

  scenario "create new person" do
    sign_in create(:user)
    visit people_path

    expect{
      person = build(:person)
      click_link 'New'      
      fill_in 'First Name', with: person.first_name
      fill_in 'Last Name', with: person.last_name      
      fill_in 'Birth Date', with: person.birth_date.strftime("%F")
      click_button 'Create'
    }.to change(Person, :count).by(1)

    expect(current_path).to eq person_path(Person.last)
    expect(page).to have_content person.first_name
  end

  scenario "edit person" do
    person = create(:person)
    sign_in create(:user)

    visit person_path(person)
    click_link 'Edit'
    fill_in 'First Name', with: 'New Name'
    fill_in 'Last Name', with: 'New Lastname'
    click_button 'Save'

    expect(current_path).to eq person_path(person)
    expect(page).to have_content 'New Name'
    expect(page).to have_content 'New Lastname'
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
