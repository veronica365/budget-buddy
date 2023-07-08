require 'rails_helper'
require_relative '../test_helper'

RSpec.describe 'Category', type: :request do
  before do
    visit('/')
    user = User.create(name: 'test', email: "tests@mail.com", password: '0000000')
    @category = Category.new(user_id: user.id, name: 'Utilities', icon: 'https://img.icons8.com/?size=512&id=61699&format=png')
    @category.save
    login_user(user)
  end

    it 'Shows the category name' do
      expect(page).to have_content(@category.name)
    end

    it 'Shows the Transaction Icon' do
      visit('/categories')
      expect(page).to have_content('ADD')
      expect(page).to have_content('Categories')
      expect(page).to have_content('Utilities')
    end
    
    it 'Shows transactions for the category clicked on' do
      visit('/categories')
      Transaction.create!(category_id: @category.id, name: 'Water', amount: 100)
      click_on "Utilities"
      visit("/categories/#{@category.id}/transactions")
      expect(page).to have_content('Transactions')
      expect(page).to have_content('ADD')
      expect(page).to have_content('Water')
    end
end