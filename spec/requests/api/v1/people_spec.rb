require 'rails_helper'

RSpec.describe 'People', type: :request do
  let(:person) { FactoryBot.create(:person) }

  context 'when fetching list of person' do
    let!(:people) { FactoryBot.create_list(:person, 5) }

    before do
      get api_v1_people_path
    end

    it 'should fetch list of people' do
      data = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(data.length).to eq ::Person.count
      expect(data.pluck('id')).to match_array(::Person.ids)
    end
  end

  context 'when fetching specific person' do
    it 'should fetch person' do
      get api_v1_person_path(id: person.id)

      data = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(data['id']).to eq person.id
      expect(data['name']).to eq person.name
    end

    it 'should return 404 when person does not exists' do
      get api_v1_person_path(id: -1)

      data = JSON.parse(response.body)

      expect(response).to have_http_status(:not_found)
      expect(data['error']).to eq (I18n.t('api.v1.people.not_found', id: -1))
    end
  end
  
  context 'when creating a person' do
    it 'should create person with valid data' do
      name = ::Faker::Name.name
      expect { post  api_v1_people_path({ name: name })}.to change{::Person.count}.by(1)

      data = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(data['name']).to eq name
      expect(::Person.exists?(id: data['id'])).to be_truthy
    end

    it 'should not create person with invalid data' do
      expect { post api_v1_people_path }.not_to change{ ::Person.count }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
