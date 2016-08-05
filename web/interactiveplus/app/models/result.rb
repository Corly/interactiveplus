class Result < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :user
  has_many :given_answers
end
