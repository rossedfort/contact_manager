class EmailAddress < ActiveRecord::Base
  belongs_to :contact, polymorphic: true

  validates_presence_of :address, :contact_id, :contact_type
end
