require 'test_helper'

class GivenAnswersControllerTest < ActionController::TestCase
  setup do
    @given_answer = given_answers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:given_answers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create given_answer" do
    assert_difference('GivenAnswer.count') do
      post :create, given_answer: { answer_id: @given_answer.answer_id, correct_answer: @given_answer.correct_answer, free_answer: @given_answer.free_answer, question_id: @given_answer.question_id, result_id: @given_answer.result_id }
    end

    assert_redirected_to given_answer_path(assigns(:given_answer))
  end

  test "should show given_answer" do
    get :show, id: @given_answer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @given_answer
    assert_response :success
  end

  test "should update given_answer" do
    patch :update, id: @given_answer, given_answer: { answer_id: @given_answer.answer_id, correct_answer: @given_answer.correct_answer, free_answer: @given_answer.free_answer, question_id: @given_answer.question_id, result_id: @given_answer.result_id }
    assert_redirected_to given_answer_path(assigns(:given_answer))
  end

  test "should destroy given_answer" do
    assert_difference('GivenAnswer.count', -1) do
      delete :destroy, id: @given_answer
    end

    assert_redirected_to given_answers_path
  end
end
