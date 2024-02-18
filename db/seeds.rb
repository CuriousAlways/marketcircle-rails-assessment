people_info = JSON.parse(File.read(Rails.root.join('db/data.json')))

people_info.each do |person_info|
  person_attributes = { name: person_info['name'], detail_attributes: person_info['info'] }

  Person.create!(person_attributes)
end
