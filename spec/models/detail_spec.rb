require 'rails_helper'

RSpec.describe Detail, type: :model do
  describe 'Association' do
    it { should belong_to(:person) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value(::Faker::Internet.email).for(:email) }
    it { should_not allow_value(::Faker::Name.name).for(:email) }
  end
end
