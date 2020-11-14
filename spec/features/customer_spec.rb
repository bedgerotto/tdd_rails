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

  scenario 'Store valid custmer' do
    visit new_customer_path

    name = Faker::Name.name
    fill_in 'Name',	with: name
    fill_in 'Email',	with: Faker::Internet.email
    fill_in 'Phone',	with: Faker::PhoneNumber.phone_number
    attach_file('Avatar', "#{Rails.root}/spec/fixtures/avatar.jpeg")
    choose option: ['Y', 'N'].sample
    click_on 'Create Customer'

    expect(page).to have_content 'Customer Succesfully Stored'
    expect(Customer.last.name).to eq(name)
  end
end
