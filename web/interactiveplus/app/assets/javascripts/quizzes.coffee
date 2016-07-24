# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
    $('form').on 'click', '.remove_fields', (event) ->
        $(this).prev('input[type=hidden]').val('1')
        $(this).closest('fieldset').hide()
        event.preventDefault()

    $('form').on 'click', '.add_fields', (event) ->
        time = new Date().getTime()
        regexp = new RegExp($(this).data('id'), 'g')
        $(this).before($(this).data('fields').replace(regexp, time))
        counter = give_me_counter()

        $('#answer_button').attr('id', 'answer_button_' + counter)

        $('#question_type_single_answer').click ->
        	$('#answer_button_' + counter).removeClass('disabled')
        	return

        $('#question_type_multiple_answer').click ->
        	$('#answer_button_' + counter).removeClass('disabled')
        	return

        $('#question_type_free_answer').click ->
        	$('#answer_button_' + counter).addClass('disabled')
        	return

        $('#question_type_single_answer').attr('name', 'question_type_' + counter)
        $('#question_type_multiple_answer').attr('name', 'question_type_' + counter)
        $('#question_type_free_answer').attr('name', 'question_type_' + counter)

        $('#question_type_single_answer').attr('id', 'question_type_single_answer_' + counter)
        $('#question_type_multiple_answer').attr('id', 'question_type_multiple_answer_' + counter)
        $('#question_type_free_answer').attr('id', 'question_type_free_answer_' + counter)

        event.preventDefault()
