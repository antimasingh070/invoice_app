require "rails_helper"

RSpec.describe Invoice, type: :model do
  describe "invoice creation" do
    it "converts invoice_total from dollars to cents" do
      invoice = Invoice.create(invoice_total: 100.0)
      expect(invoice.invoice_total).to eq(10000)
    end
  end

  describe "#record_payment" do
    let(:invoice) { Invoice.create(invoice_total: 200.0) }

    it "records a valid payment" do
      invoice.record_payment(50.0, :cash)
      expect(invoice.amount_owed).to eq(150.0)
    end

    it "raises error for invalid payment method" do
      expect { invoice.record_payment(20.0, :bitcoin) }.to raise_error(ArgumentError)
    end

    it "raises error for negative amount" do
      expect { invoice.record_payment(-10.0, :cash) }.to raise_error(ArgumentError)
    end
  end

  describe "#amount_owed and #fully_paid?" do
    let(:invoice) { Invoice.create(invoice_total: 150.0) }

    it "calculates remaining amount correctly" do
      invoice.record_payment(50.0, :cash)
      expect(invoice.amount_owed).to eq(100.0)
      expect(invoice.fully_paid?).to eq(false)
    end

    it "returns 0 if fully paid" do
      invoice.record_payment(150.0, :charge)
      expect(invoice.amount_owed).to eq(0.0)
      expect(invoice.fully_paid?).to eq(true)
    end

    it "does not go negative if overpaid" do
      invoice.record_payment(200.0, :cash)
      expect(invoice.amount_owed).to eq(0.0)
    end
  end
end
