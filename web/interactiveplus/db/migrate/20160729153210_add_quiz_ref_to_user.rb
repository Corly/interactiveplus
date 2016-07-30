class AddQuizRefToUser < ActiveRecord::Migration
  def change
    add_reference :users, :quiz, index: true, foreign_key: true
  end
end
