# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :confirmable,
         :validatable

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :courses, dependent: :delete_all

  def moderator?
    is_a?(Moderator)
  end
end
