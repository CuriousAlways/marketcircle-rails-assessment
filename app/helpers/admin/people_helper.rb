module Admin::PeopleHelper
  def name_with_title(person)
    "#{person.detail&.title} #{person.name}".strip
  end
end
