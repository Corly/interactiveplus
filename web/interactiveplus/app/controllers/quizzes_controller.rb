class QuizzesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :set_quiz, only: [:show, :edit, :update, :destroy] 

  # GET /quizzes
  # GET /quizzes.json
  def index
    @quizzes = Quiz.all
  end

  # GET /quizzes/1
  # GET /quizzes/1.json
  def show
    @quiz = Quiz.find(params[:id])
    @user = User.find(params[:user_id])
  end

  # GET /quizzes/new
  def new
    @user = User.find(params[:user_id])
    @quiz = @user.quizzes.build
    @quiz.questions.build
  end

  # GET /quizzes/1/edit
  def edit
    @quiz = Quiz.find(params[:id])
    @user = User.find(params[:user_id])
  end

  # POST /quizzes
  # POST /quizzes.json
  def create
    @quiz = current_user.quizzes.build(quiz_params)

    @quiz.questions.each do |q|
      if q.question_type == "free_answer"
        q.answers = []
      end
    end

    puts @quiz.questions

    respond_to do |format|
      if @quiz.save
        format.html { redirect_to current_user, notice: 'Quiz was successfully created.' }
        format.json { render :show, status: :created, location: @quiz }
      else
        format.html { render :new }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quizzes/1
  # PATCH/PUT /quizzes/1.json
  def update
    respond_to do |format|
      if @quiz.update(quiz_params)
        format.html { redirect_to current_user, notice: 'Quiz was successfully updated.' }
        format.json { render :show, status: :ok, location: @quiz }
      else
        format.html { render :edit }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1
  # DELETE /quizzes/1.json
  def destroy
    @quiz.destroy
    flash[:success] = "Quiz deleted"
    redirect_to request.referrer || root_url
  end

  def publish
    @quiz = Quiz.find(params[:quiz_id])
    @user = User.find(@quiz.user_id)

    if @quiz.publish_string.nil?
      url = SecureRandom.base64[0,5].gsub('/', 'a')
      @quiz.update(:publish_string => url)
    end
  end

  def take_quiz
      @quiz = Quiz.find_by(publish_string: params[:quiz_string])
      @user = User.find(@quiz.user_id)

      @questions = @quiz.questions

      respond_to do |format|
        format.html
        format.json { render json: {:quiz => @quiz,
                                    :questions => @questions }}
      end
  end

  def show_results
      @quiz = Quiz.find(params[:quiz_id])
      @user = User.find(@quiz.user_id)
      @all_results = @quiz.results
      @results = @quiz.results.paginate(page: params[:page])

      q_to_nr_of_correct_answers = {}
      @quiz.questions.each do |q|
        if q.question_type == "choosing_answer"
          nr = 0
          q.answers.each do |a|
            if a.answer_type == "correct"
              nr = nr + 1
            end
          end

          q_to_nr_of_correct_answers[q] = nr
        end
      end

      @q_to_nr_of_correct_solves = []
      @q_to_nr_of_incorrect_solves = []
      @categories = []
      @quiz.questions.each do |q|
        if q.question_type == "choosing_answer"
          counter = 0
          @all_results.each do |r|
            nr_of_correct_given_answers = GivenAnswer.where("result_id = ? AND question_id = ? AND correct_answer = ?", r.id, q.id, true).count
            if nr_of_correct_given_answers == q_to_nr_of_correct_answers[q]
              counter = counter + 1
            end
          end
          @q_to_nr_of_correct_solves << counter
          @q_to_nr_of_incorrect_solves << @all_results.count - counter
          @categories << q.id
        end
      end


      @kendo_series = []
      @kendo_series << {name: "Correct", data:  @q_to_nr_of_correct_solves}
      @kendo_series << {name: "Incorrect", data: @q_to_nr_of_incorrect_solves}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    def correct_user
      @quiz = current_user.quizzes.find_by(id: params[:id])
      redirect_to root_url if @quiz.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quiz_params
      params.require(:quiz).permit(:name, questions_attributes: [ :id, :content, :question_type, :_destroy,
                                                                answers_attributes: [:id, :content, :answer_type, :_destroy]])
    end
end
