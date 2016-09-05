class Answer < ActiveRecord::Base
  belongs_to :question
  has_one :given_answer
end
