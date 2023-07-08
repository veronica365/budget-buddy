require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'test', email: 'test@mail.com') }

  before { subject.save }

  it 'name should be present' do
    expect(subject.name).to eq('test')
  end

  it 'email should be present' do
    expect(subject.email).to eq('test@mail.com')
  end
end
