class BankRegistration < ApplicationRecord
  enum status: {pending: 0, success: 1, failure: 2, inactive: 3}

  validates_uniqueness_of :type
end
