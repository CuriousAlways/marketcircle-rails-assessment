require 'rails_helper'

RSpec.describe Person, type: :model do
  describe 'Associations' do
    it { should have_one(:detail) }
  end

  describe 'Validations and nested_attributes' do
    it { should validate_presence_of(:name) }
    it { should accept_nested_attributes_for(:detail) }
  end
end
