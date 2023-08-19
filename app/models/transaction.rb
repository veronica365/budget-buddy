class Transaction < ApplicationRecord
  belongs_to :category

  validates :name, :amount, presence: true
end
