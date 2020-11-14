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

    expect(page).to have_content 'Customer Successfully Stored'
    expect(Customer.last.name).to eq(name)
  end

  scenario 'Prevent invalid custmer' do
    visit new_customer_path
    click_on 'Create Customer'

    expect(page).to have_content("não pode ficar em branco") 
  end

  scenario 'Show new Customer' do
    customer = create :customer

    visit customer_path(customer)
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content(customer.phone)
  end

  scenario 'Customer index' do
    customer1 = create :customer
    customer2 = create :customer

    visit customers_path
    expect(page).to have_content(customer1.name).and have_content(customer2.name)
  end

  scenario 'Update Customer' do
    customer = create :customer

    new_name = Faker::Name.name
    visit edit_customer_path(customer)
    fill_in 'Name', with: new_name
    click_on 'Update Customer'

    expect(page).to have_content('Customer Successfully Updated') 
    expect(page).to have_content(new_name)
  end

  scenario 'Click on show link' do
    customer = create :customer

    visit customers_path
    find(:xpath, '/html/body/table/tbody/tr[1]/td[2]/a').click
    expect(page).to have_content('Customer Show')
  end

  scenario 'Click on edit link' do
    customer = create :customer

    visit customers_path
    find(:xpath, '/html/body/table/tbody/tr[1]/td[3]/a').click
    expect(page).to have_content('Edit Customer')
  end

  scenario 'Click on destroy link', js: true do
    customer = create :customer

    visit customers_path
    accept_alert do
      find(:xpath, '/html/body/table/tbody/tr[1]/td[4]/a').click
    end

    expect(page).to have_content('Customer Successfully Destroyed')
  end
end

