require 'rails_helper'

describe 'the signin process', type: :feature do
  before :each do
    User.create(email: 'user1@gmail.com', password: 'password', name: 'User1')
    User.create(email: 'user2@gmail.com', password: 'password', name: 'User2')
    visit '/users/sign_in'
    fill_in 'Email', with: 'user1@gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end

  it 'visits all users page' do
    visit users_path
    expect(page).to have_text('User1')
    expect(page).to have_link('See Profile')
  end

  it 'sends an invite to friendship to user2' do
    visit users_path
    expect(page).to have_link('Invite to friendship')
    click_link 'Invite to friendship'
    expect(page).to have_link('pending friendship')
  end
end
