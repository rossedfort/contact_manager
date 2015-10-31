class Company < ActiveRecord::Base
  validates_presence_of :name

  has_many :phone_numbers, as: :contact
  has_many :email_addresses, as: :contact
end
