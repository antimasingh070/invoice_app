require "rails_helper"

RSpec.describe Payment, type: :model do
  let(:invoice) { Invoice.create(invoice_total: 100.0) }

  it "is valid with correct payment_method_id and positive amount" do
    payment = invoice.payments.build(amount: 1000, payment_method_id: Payment::METHODS[:cash])
    expect(payment).to be_valid
  end

  it "is invalid with wrong payment_method_id" do
    payment = invoice.payments.build(amount: 1000, payment_method_id: 999)
    expect(payment).not_to be_valid
  end

  it "is invalid with negative or zero amount" do
    payment = invoice.payments.build(amount: -100, payment_method_id: Payment::METHODS[:cash])
    expect(payment).not_to be_valid

    payment = invoice.payments.build(amount: 0, payment_method_id: Payment::METHODS[:cash])
    expect(payment).not_to be_valid
  end

  it "returns correct symbol for payment_method" do
    payment = invoice.payments.create!(amount: 1000, payment_method_id: Payment::METHODS[:check])
    expect(payment.payment_method).to eq(:check)
  end
end
