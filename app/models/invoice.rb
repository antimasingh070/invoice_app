class Invoice < ApplicationRecord
  has_many :payments, dependent: :destroy

  # Convert human-friendly dollars to cents before validation
  before_validation :convert_total_to_cents, on: :create

  validates :invoice_total, numericality: { greater_than_or_equal_to: 0 }

  # Returns true if invoice is fully paid
  def fully_paid?
    amount_owed.zero?
  end

  # Returns remaining amount owed in dollars
  def amount_owed
    remaining_cents = (invoice_total - payments.sum(:amount)).clamp(0, Float::INFINITY)
    (remaining_cents / 100.0)
  end

  # Records a payment
  # @param amount_paid [Float] in dollars
  # @param payment_method [Symbol] :cash, :check, :charge
  def record_payment(amount_paid, payment_method)
    raise ArgumentError, "Invalid payment method" unless Payment::METHODS.key?(payment_method)
    raise ArgumentError, "Amount must be positive" unless amount_paid.positive?

    payments.create!(
      amount: (amount_paid * 100).round,
      payment_method_id: Payment::METHODS[payment_method]
    )
  end

  private

  def convert_total_to_cents
    self.invoice_total = (invoice_total * 100).round if invoice_total.present?
  end
end
