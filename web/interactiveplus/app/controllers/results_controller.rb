class ResultsController < ApplicationController
  before_action :set_result, only: [:show, :edit, :update, :destroy]

  # GET /results
  # GET /results.json
  def index
    @results = Result.all
  end

  # GET /results/1
  # GET /results/1.json
  def show
    @result = Result.find(params[:id])
    @quiz = Quiz.find(@result.quiz_id)
    @user = User.find(@result.user_id)
    @answers = @result.given_answers
  end

  # GET /results/new
  def new
    @result = Result.new
  end

  def info
    @result = Result.find_by('link = ?', params[:link])
  end

  # GET /results/1/edit
  def edit
  end

  # POST /results
  # POST /results.json
  def create
    @result = Result.new(result_params)
    puts result_params

    answer_ids = params["answer_ids"]
    free_answers_question_id = params["free_answers_question_id"]
    quiz = Quiz.find(@result.quiz_id)

    @result.number_of_questions = quiz.questions.length

    number_of_free_answer_questions = 0
    quiz.questions.each do |question|
      if question.question_type == "free_answer"
        number_of_free_answer_questions += 1
      end
    end

    @result.number_of_free_answer_questions = number_of_free_answer_questions

    number_of_correct_answers = 0

    answer_ids.each do |id|
      answer = Answer.find(id.to_i)
      unless answer.answer_type.nil?
        number_of_correct_answers += 1
      end
    end

    @result.number_of_correct_answers = number_of_correct_answers
    @result.number_of_answers = answer_ids.length
    @result.number_of_free_answers = free_answers_question_id.nil? ? 0 : free_answers_question_id.length
    @result.link = params["random_link"]
    @result.total_number_of_correct_answers = number_of_correct_answers

    respond_to do |format|
        if @result.save
          number_of_correct_answers = 0
          answer_ids.each do |id|
            answer = Answer.find(id.to_i)
            @given_answer = GivenAnswer.new()
            @given_answer.answer_id = id.to_i
            @given_answer.question_id = answer.question_id
            @given_answer.result_id = @result.id
            unless answer.answer_type.nil?
              number_of_correct_answers += 1
              @given_answer.correct_answer = true
            else
              @given_answer.correct_answer = false
            end
            @given_answer.save
          end

          free_answers_question_id.each do |key1, element|
            element.each do |key, value|
              @given_answer = GivenAnswer.new()
              @given_answer.result_id = @result.id
              @given_answer.question_id = key.to_i
              @given_answer.free_answer = value

              @given_answer.save
            end
          end

        format.html { redirect_to @result, notice: 'Result was successfully created.' }
        format.json { render :show, status: :created, location: @result }
      else
        format.html { render :new }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /results/1
  # PATCH/PUT /results/1.json
  def update
    respond_to do |format|
      if @result.update(result_params)
        format.html { redirect_to @result, notice: 'Result was successfully updated.' }
        format.json { render :show, status: :ok, location: @result }
      else
        format.html { render :edit }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1
  # DELETE /results/1.json
  def destroy
    @result.destroy
    respond_to do |format|
      format.html { redirect_to results_url, notice: 'Result was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def result_params
      params.require(:result).permit(:number_of_answers, :number_of_correct_answers, :quiz_id, :user_id)
    end
end
