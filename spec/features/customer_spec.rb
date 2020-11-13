require 'rails_helper'

feature 'Customers', type: :feature do
  scenario 'Check Customer Register link' do
    visit root_path

    expect(page).to have_link('Customer Register')
  end

  scenario 'Check New Customer link' do
    visit root_path
    click_on 'Customer Register'

    expect(page).to have_content('Customer Index')
    expect(page).to have_link('New Customer' )
  end

  scenario 'Check new customer form' do
    visit customers_path
    click_on 'New Customer'

    expect(page).to have_content('New Customer')
  end
end
