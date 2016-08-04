class AddNumberOfFreeAnswersToResults < ActiveRecord::Migration
  def change
    add_column :results, :number_of_free_answers, :integer
  end
end
