class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :number_of_answers
      t.integer :number_of_correct_answers
      t.references :quiz, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
