require 'rails_helper'

describe 'the person view', type: :feature do
  describe 'the phone numbers', type: :feature do

    let(:person) { Person.create(first_name: 'John', last_name: 'Doe') }

    before(:each) do
      person.phone_numbers.create(number: "555-1234")
      person.phone_numbers.create(number: "555-5678")
      visit person_path(person)
    end

    it 'shows the phone numbers' do
      person.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end

    it 'has a link to add a new phone number' do
      expect(page).to have_link('Add phone number', href: new_phone_number_path(person_id: person.id))
    end

    it 'adds a new phone number' do
      page.click_link('Add phone number')
      page.fill_in('Number', with: '555-8888')
      page.click_button('Create Phone number')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('555-8888')
    end

    it 'has links to edit phone numbers' do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone.id))
      end
    end
    it 'edits a phone number' do
      phone = person.phone_numbers.first
      old_number = phone.number

      first(:link, 'edit').click
      page.fill_in('Number', with: '555-9191')
      page.click_button('Update Phone number')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('555-9191')
      expect(page).to_not have_content(old_number)
    end
    it "has the link to delete a phone number" do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('delete', href: phone_number_path(phone))
      end
    end
    it "deletes a phone number" do
      person.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
        first(:link, 'delete').click
        expect(current_path).to eq(person_path(person))
        expect(page).to_not have_content(phone.number)
      end
    end
  end

  describe 'the email addresses', type: :feature do

    let(:person) { Person.create(first_name: 'Example', last_name: 'Smith') }

    before(:each) do
      person.email_addresses.create(address: 'example@example.com')
      person.email_addresses.create(address: 'example_two@example.com')
      person.email_addresses.create(address: 'example_three@example.com')
      visit person_path(person)
    end

    it 'displays the addresses in a list' do
      expect(page).to have_selector('li', text: 'example@example.com')
      expect(page).to have_selector('li', text: 'example_two@example.com')
      expect(page).to have_selector('li', text: 'example_three@example.com')
    end

    it "has an add email address link" do
      expect(page).to have_link('Add email address', href: new_email_address_path(person_id: person.id))
      page.click_link('Add email address')
      expect(current_path).to eq(new_email_address_path)
    end
    it 'adds a new email address' do
      page.click_link('Add email address')
      page.fill_in('Address', with: 'another_example@example.com')
      page.click_button('Create Email address')
      expect(current_path).to eq(person_path(person))
    end
    it 'has links to edit email addresses' do
      person.email_addresses.each do |address|
        expect(page).to have_link('edit', href: edit_email_address_path(address.id))
      end
    end
    it 'edits an email address' do
      email_address = person.email_addresses.first
      old_address = email_address.address

      first(:link, 'edit').click
      page.fill_in('Address', with: 'bob@example.com')
      page.click_button('Update Email address')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('bob@example.com')
      expect(page).to_not have_content(old_address)
    end
    it 'has the links to delete an email address' do
      person.email_addresses.each do |address|
        expect(page).to have_link('delete', href: email_address_path(address))
      end
    end
    it 'deletes an email address' do
      person.email_addresses.each do |address|
        expect(page).to have_content(address.address)
        first(:link, 'delete').click
        expect(current_path).to eq(person_path(person))
        expect(page).to_not have_content(address.address)
      end
    end
  end
end
