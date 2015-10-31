require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:company) {Company.create(name: 'Turing')}

  it "is valid" do
    expect(company).to be_valid
  end

  it "is not valid without a name" do
    company.name = nil
    expect(company).to_not be_valid
  end

  it 'has an array of phone numbers' do
    expect(company.phone_numbers).to eq([])
  end

  it "responds with its phone numbers after they're created" do
    phone_number = company.phone_numbers.build(number: '9087634211')
    expect(phone_number.number).to eq('9087634211')
  end

  it "responds with its email addresses after they're created" do
    email_address = company.email_addresses.build(address: 'whatever@company.com')
    expect(email_address.address).to eq('whatever@company.com')
  end
end
