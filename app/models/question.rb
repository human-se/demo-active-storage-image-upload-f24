# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id           :bigint           not null, primary key
#  answer       :string
#  distractor_1 :string
#  distractor_2 :string
#  question     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  quiz_id      :bigint
#
# Indexes
#
#  index_questions_on_quiz_id  (quiz_id)
#
# Foreign Keys
#
#  fk_rails_...  (quiz_id => quizzes.id)
#
class Question < ApplicationRecord
  has_one_attached :figure_image

  belongs_to(
    :quiz,
    class_name: 'Quiz',
    foreign_key: 'quiz_id',
    inverse_of: :questions
  )

  validates :question, presence: true
  validates :answer, presence: true
  validates :distractor_1, presence: true
  validates :distractor_2, presence: true
  validate :choices_cannot_be_duplicates

  def choices_cannot_be_duplicates
    if !answer.blank? && !distractor_1.blank? && answer == distractor_1
      errors.add(:distractor_1, "can't be the same as any other choice")
    end
    if !answer.blank? && !distractor_2.blank? && answer == distractor_2
      errors.add(:distractor_2, "can't be the same as any other choice")
    end
    return unless !distractor_1.blank? && !distractor_2.blank? && distractor_1 == distractor_2

    errors.add(:distractor_2, "can't be the same as any other choice")
  end
end
