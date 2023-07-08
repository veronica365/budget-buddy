require 'rails_helper'
require_relative '../test_helper'

RSpec.describe 'Transactions', type: :request do
  before do
    visit('/')
    user = User.create(name: 'test', email: 'tests@mail.com', password: '0000000')
    @category = Category.create(user_id: user.id, name: 'Utilities', icon: 'https://img.icons8.com/?size=512&id=61699&format=png')
    Transaction.create(category_id: @category.id, name: 'Water', amount: 100)
    Transaction.create(category_id: @category.id, name: 'Food', amount: 400)
    Transaction.create(category_id: @category.id, name: 'Trash', amount: 100)
    login_user(user)
  end

  it 'Should have the total of the transactions displayed' do
    visit("/categories/#{@category.id}/transactions")
    Transaction.create(category_id: @category.id, name: 'Water', amount: 100)
    Transaction.create(category_id: @category.id, name: 'Food', amount: 400)
    Transaction.create(category_id: @category.id, name: 'Trash', amount: 100)
    expect(page).to have_content('Transactions')
    expect(page).to have_content('ADD')
    expect(page).to have_content('Water')
    expect(page).to have_content(600)
  end
end
