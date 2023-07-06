class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :name, null: false
      t.integer :amount, null: false
      t.belongs_to :category

      t.timestamps
    end
  end
end
