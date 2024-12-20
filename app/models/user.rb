# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many(
    :quizzes,
    class_name: 'Quiz',
    foreign_key: 'user_id',
    inverse_of: :creator
  )
end
