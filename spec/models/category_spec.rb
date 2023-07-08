require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { Category.new(name: 'Utilities', icon: 'https://img.icons8.com/?size=512&id=61699&format=png') }

  before { subject.save }

  it 'name should be present' do
    expect(subject.name).to eq('Utilities')
  end

  it 'icon url shold be present' do
    expect(subject.icon).to eq('https://img.icons8.com/?size=512&id=61699&format=png')
  end
end