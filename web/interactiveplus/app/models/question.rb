class Question < ActiveRecord::Base
    belongs_to :quiz
    has_many :answers
    accepts_nested_attributes_for :answers, allow_destroy: true

    def question_params
        params.require(:question).permit(:content, :answers, :answers_attributes, :quiz_id)
    end

    def as_json(options={})
    	{:content 		=> self.content,
         :answers   => self.answers}
    end
end
