# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :answer
      t.string :distractor_1
      t.string :distractor_2
      t.string :question

      t.timestamps
    end
  end
end
