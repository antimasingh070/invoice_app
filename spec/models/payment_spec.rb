require "rails_helper"

RSpec.describe Payment, type: :model do
  let(:invoice) { Invoice.create(invoice_total: 50.0) }

  it "is valid with correct payment method and amount" do
    payment = invoice.payments.build(amount: 1000, payment_method_id: 1)
    expect(payment).to be_valid
  end
end
