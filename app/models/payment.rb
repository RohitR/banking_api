class Payment < ApplicationRecord
  enum status: {pending: 0, success: 1, failure: 2, suspect: 3, cancelled: 4, processing: 5, pending_for_processing: 6}

end
