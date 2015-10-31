class EmailAddress < ActiveRecord::Base
  belongs_to :person

  validates_presence_of :address
end
