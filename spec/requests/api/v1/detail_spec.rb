require 'rails_helper'

RSpec.describe 'Detail', type: :request do
  let(:person) { ::FactoryBot.create(:person, :with_detail) }
  let(:person_id) { person.id }

  shared_examples 'for successfull person detail response' do
    it 'should have person details' do
      data = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(data.slice('id', 'title', 'age', 'phone', 'email')).to  include(person.reload_detail.slice(:id, :title, :age, :phone, :email))
    end
  end

  describe 'fetch details' do
    before do
      get api_v1_person_detail_path(person_id)
    end

    context 'when person exists' do
      include_examples 'for successfull person detail response'
    end

    context 'when person does not exists' do
      let(:person_id) { -::Faker::Number.number }

      it 'should not fetch person details' do
        data = JSON.parse(response.body)

        expect(response).to have_http_status(:not_found)
        expect(data['error']).to  eq(I18n.t('api.v1.people.not_found', id: person_id))
      end
    end
  end

  describe 'create details' do
    before do
      @detail = person.detail
      post api_v1_person_detail_path(person.id), params: params
    end

    let(:params) do
      {
        title: ::Detail::TITLE.sample,
        email: ::Faker::Internet.email,
        age: ::Faker::Number.number(digits: 2),
        phone: ::Faker::PhoneNumber.phone_number
      }
    end

    context 'when request have valid parameters' do
      include_examples 'for successfull person detail response'
    end

    context 'when request have invalid parameters' do
      let(:params) do
        {
          title: ::Detail::TITLE.sample,
          age: ::Faker::Number.number(digits: 2),
          phone: ::Faker::PhoneNumber.phone_number
        }
      end

      it 'should not update person detail' do
        data = JSON.parse(response.body)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(data['error']).to be_present
        expect(person.reload_detail).to eq @detail
      end
    end
  end
end
