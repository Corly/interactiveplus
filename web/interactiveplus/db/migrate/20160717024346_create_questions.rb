class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :content
      t.string :question_type
      t.belongs_to :quiz, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
