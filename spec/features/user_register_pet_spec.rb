require 'rails_helper'

feature 'user register pet' do
  scenario 'successfuly' do
    user = create(:user, email: 'renan@gmail.com', password: '12345678')

    login_as user
    visit root_path
    click_on 'Cadastrar Pet'
    fill_in 'Name', with: 'Myke'
    fill_in 'Bearing', with: 'Pequeno'
    fill_in 'Gender', with: 'Macho'
    fill_in 'Pet type', with: 'Cachorro'
    click_on 'Cadastrar'

    expect(page).to have_content('Myke')
    expect(page).to have_content('Pequeno')
    expect(page).to have_content('Macho')
    expect(page).to have_content('Cachorro')
    expect(page).to have_content('Pet cadastrado com sucesso!')
  end
  
  scenario 'without login' do
    visit root_path
    expect(page).not_to have_link('Cadastrar Pet')
  end
end
