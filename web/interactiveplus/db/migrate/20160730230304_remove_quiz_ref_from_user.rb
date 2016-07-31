class RemoveQuizRefFromUser < ActiveRecord::Migration
    def change
        remove_foreign_key :quizzes, :users
    end
end
