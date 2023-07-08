class Category < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy

  validates :name, :icon, presence: true, length: { maximum: 250 }
end
