class Detail < ApplicationRecord
  TITLE = ['Dr.', 'Mr.', 'Mrs.', 'Prof.'].freeze
  #-------------------------------------------------------------------------------------
  # Associations
  #-------------------------------------------------------------------------------------
  belongs_to :person

  #-------------------------------------------------------------------------------------
  # Validations
  #-------------------------------------------------------------------------------------
  validates :email, presence: true
  validates :email, uniqueness: true, format: { with: ::URI::MailTo::EMAIL_REGEXP }, allow_blank: true
end
