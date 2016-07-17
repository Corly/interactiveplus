class Quiz < ActiveRecord::Base
    has_many :questions
    accepts_nested_attributes_for :questions, allow_destroy: true

    def quiz_params
        params.require(:quiz).permit(:name, :questions_attributes)
    end
end
