require "rails_helper"

RSpec.describe Invoice, type: :model do
  let(:invoice) { Invoice.create(invoice_total: 100.0) }

  it "converts total to cents" do
    expect(invoice.invoice_total).to eq(10000)
  end

  it "records a valid payment" do
    invoice.record_payment(50.0, :cash)
    expect(invoice.amount_owed).to eq(50.0)
    expect(invoice.fully_paid?).to eq(false)
  end

  it "raises error for invalid payment method" do
    expect { invoice.record_payment(20.0, :bitcoin) }.to raise_error(ArgumentError)
  end

  it "raises error for negative amount" do
    expect { invoice.record_payment(-10.0, :cash) }.to raise_error(ArgumentError)
  end
end
