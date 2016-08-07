class AddColumnTotalNumberOfCorrectAnswersToResults < ActiveRecord::Migration
  def change
    add_column :results, :total_number_of_correct_answers, :integer
  end
end
