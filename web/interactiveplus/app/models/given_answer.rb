class GivenAnswer < ActiveRecord::Base
  belongs_to :question
  belongs_to :answer
  belongs_to :result
end
