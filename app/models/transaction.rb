class Transaction < ApplicationRecord
    belongs_to: :category

    validates: :name, presense: true
    validates: :amount, presense: true
end
