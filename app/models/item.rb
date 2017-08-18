class Item < ApplicationRecord
    validates_presence_of :name, :description
    has_many :invoice_items
    has_many :invoices, -> { distinct }, through: :invoice_items
    belongs_to :merchant

    belongs_to :merchant

    def best_day
      invoices
        .select('invoices.*, sum(invoice_items.quantity) AS purchases')
        .joins(:transactions, :invoice_items)
        .merge(Transaction.successful)
        .group(:id)
        .order('purchases DESC, invoices.created_at DESC')
        .first
    end
end
