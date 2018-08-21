class Payment < ApplicationRecord
  enum status: {processing: 0, paid: 1, failed: 2}
  
end
