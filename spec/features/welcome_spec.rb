require 'rails_helper'

feature 'Welcome', type: :feature do
  scenario 'Shows welcoming message' do
    visit root_path

    expect(page).to have_content('Welcome')
  end

  scenario 'Check link Customer Register' do
    visit root_path

    expect(find('ul li')).to have_link('Customer Register')
  end
end
