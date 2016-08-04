json.array!(@given_answers) do |given_answer|
  json.extract! given_answer, :id, :correct_answer, :free_answer, :question_id, :answer_id, :result_id
  json.url given_answer_url(given_answer, format: :json)
end
