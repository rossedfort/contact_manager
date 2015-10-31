require 'rails_helper'

RSpec.describe Person, :type => :model do
  let(:person) do
    Person.new(first_name: 'Alice', last_name: 'Smith')
  end
  it 'is invalid without a first name' do
    person.first_name = nil
    expect(person).not_to be_valid
  end
  it 'is invalid without a last name' do
    person.last_name = nil
    expect(person).to_not be_valid
  end
  it 'is valid' do
    expect(person).to be_valid
  end
  it 'responds with its created phone numbers' do
    person.phone_numbers.build(number: '0912374764')
    expect(person.phone_numbers.map(&:number)).to eq(['0912374764'])
  end
  it 'responds with its created email addresses' do
    person.email_addresses.build(address: 'hello@me.com')
    expect(person.email_addresses.map(&:address)).to eq(['hello@me.com'])
  end
end
