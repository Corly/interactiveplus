json.array!(@results) do |result|
  json.extract! result, :id, :number_of_answers, :number_of_correct_answers, :quiz_id, :user_id
  json.url result_url(result, format: :json)
end
