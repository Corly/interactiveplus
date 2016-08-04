class AddNumberOfQuestionsToResults < ActiveRecord::Migration
  def change
    add_column :results, :number_of_questions, :integer
    add_column :results, :number_of_free_answer_questions, :integer
  end
end
