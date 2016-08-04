class CreateGivenAnswers < ActiveRecord::Migration
  def change
    create_table :given_answers do |t|
      t.boolean :correct_answer
      t.text :free_answer
      t.references :question, index: true, foreign_key: true
      t.references :answer, index: true, foreign_key: true
      t.references :result, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
