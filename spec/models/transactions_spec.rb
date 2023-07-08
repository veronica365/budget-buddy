require 'rails_helper'

RSpec.describe Transaction, type: :model do
  subject { Transaction.new(name: 'Electricity', amount: 150) }

  before { subject.save }

  it 'name should be present' do
    expect(subject.name).to eq('Electricity')
  end

  it 'amount should be present' do
    expect(subject.amount).to eq(150)
  end
end
