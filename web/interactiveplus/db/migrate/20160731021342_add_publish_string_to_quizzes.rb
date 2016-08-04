class AddPublishStringToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :publish_string, :string
  end
end
