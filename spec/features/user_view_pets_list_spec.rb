require 'rails_helper'

feature 'list pets owner' do
  scenario 'successfully' do
    user = create(:user, email: 'renan@gmail.com', password: '12345678')
    dog_brisa = user.pets.create(name: 'Brisa', pet_type: 'Cachorro', bearing: 'Médio', gender: 'Fêmea')

    login_as user
    visit root_path

    expect(page).to have_link('Meus Pets')
    click_on 'Meus Pets'

    expect(page).to have_link('Brisa')
  end

  scenario 'without login' do
    visit root_path

    expect(page).to_not have_link('Meus Pets')
  end
end