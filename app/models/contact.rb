class Contact < ApplicationRecord
  belongs_to :user

  REGEX_FOR_NAME = /\A[a-zA-Z\s-]+\z/
  REGEX_FOR_BIRTHDATE = /\A(\d{4}\d{2}\d{2}|\d{4}-\d{2}-\d{2})\z/
  REGEX_FOR_PHONE = /\A\(\+\d{2}\)\s(\d{3}\s\d{3}\s\d{2}\s\d{2}|\d{3}-\d{3}-\d{2}-\d{2})\z/
  REGEX_FOR_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  REGEX_FOR_CARD = /\A[0-9]+\z/

  validates :name, format: { with: REGEX_FOR_NAME, message: "No special characters are allowed" }
  validates :birthdate, format: { with: REGEX_FOR_BIRTHDATE, message: "Invalid format, only %Y%m%d and %Y-%m-%d are allowed" }
  validates :phone, format: { with: REGEX_FOR_PHONE, message: "Invalid format, only (+01) 234 567 89 00 or (+01) 234-567-89-00 are allowed" }
  validates :address, presence: true
  validates :email, format: { with: REGEX_FOR_EMAIL, message: "Invalid email" }, presence: true, uniqueness: { case_sensitive: false, scope: :user_id }
  validates :credit_card, format: { with: REGEX_FOR_CARD, message: " Only numbers in this field " }, presence: true

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Contact.create! row.to_hash
    end
  end
end
