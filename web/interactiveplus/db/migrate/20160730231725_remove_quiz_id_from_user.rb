class RemoveQuizIdFromUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
        t.remove :quiz_id
    end
  end
end
