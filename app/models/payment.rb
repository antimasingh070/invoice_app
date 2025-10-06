class Payment < ApplicationRecord
  belongs_to :invoice

  METHODS = { cash: 1, check: 2, charge: 3 }.freeze

  validates :payment_method_id, inclusion: { in: METHODS.values }
  validates :amount, presence: true, numericality: { greater_than: 0 }

  # Returns symbol for payment method
  def payment_method
    METHODS.key(payment_method_id)
  end
end
