require 'rails_helper'

describe 'the company view', type: :feature do
  describe 'the phone numbers', type: :feature do
    let(:company) { Company.create(name: 'Turing') }

    before(:each) do
      company.phone_numbers.create(number: "555-1234")
      company.phone_numbers.create(number: "555-5678")
      visit company_path(company)
    end

    it 'shows the phone numbers of the company' do
      company.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end

    it 'has a link to add a new phone number for the company' do
      expect(page).to have_link('Add phone number', href: new_phone_number_path(contact_id: company.id, contact_type: 'Company'))
    end

    it 'adds a new phone number to the company' do
      page.click_link('Add phone number')
      page.fill_in('Number', with: '555-8888')
      page.click_button('Create Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-8888')
    end

    it 'has links to edit phone numbers for the company' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone.id))
      end
    end

    it 'edits a phone number of the company' do
      phone = company.phone_numbers.first
      old_number = phone.number

      first(:link, 'edit').click
      page.fill_in('Number', with: '555-9191')
      page.click_button('Update Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-9191')
      expect(page).to_not have_content(old_number)
    end
    it "has the link to delete a phone number for the company" do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('delete', href: phone_number_path(phone))
      end
    end
    it "deletes a phone number of the company" do
      company.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
        first(:link, 'delete').click
        expect(current_path).to eq(company_path(company))
        expect(page).to_not have_content(phone.number)
      end
    end
  end

  describe 'the email addresses', type: :feature do

    let(:company) { Company.create(name: 'Turing') }

    before(:each) do
      company.email_addresses.create(address: 'example@example.com')
      company.email_addresses.create(address: 'example_two@example.com')
      company.email_addresses.create(address: 'example_three@example.com')
      visit company_path(company)
    end

    it 'displays the addresses in a list' do
      expect(page).to have_selector('li', text: 'example@example.com')
      expect(page).to have_selector('li', text: 'example_two@example.com')
      expect(page).to have_selector('li', text: 'example_three@example.com')
    end

    it "has an add email address link" do
      expect(page).to have_link('Add email address', href: new_email_address_path(contact_id: company.id, contact_type: 'Company'))
      page.click_link('Add email address')
      expect(current_path).to eq(new_email_address_path)
    end
    it 'adds a new email address' do
      page.click_link('Add email address')
      page.fill_in('Address', with: 'another_example@example.com')
      page.click_button('Create Email address')
      expect(current_path).to eq(company_path(company))
    end
    it 'has links to edit email addresses' do
      company.email_addresses.each do |address|
        expect(page).to have_link('edit', href: edit_email_address_path(address.id))
      end
    end
    it 'edits an email address' do
      email_address = company.email_addresses.first
      old_address = email_address.address

      first(:link, 'edit').click
      page.fill_in('Address', with: 'bob@example.com')
      page.click_button('Update Email address')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('bob@example.com')
      expect(page).to_not have_content(old_address)
    end
    it 'has the links to delete an email address' do
      company.email_addresses.each do |address|
        expect(page).to have_link('delete', href: email_address_path(address))
      end
    end
    it 'deletes an email address' do
      company.email_addresses.each do |address|
        expect(page).to have_content(address.address)
        first(:link, 'delete').click
        expect(current_path).to eq(company_path(company))
        expect(page).to_not have_content(address.address)
      end
    end
  end
end
