// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require bootstrap
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .
$( document ).ready(function() {
 $('input[id^="question_type_single_answer_"]').on('click', function() {  
    console.log("Hello!");
 });
});

function enable_answer_button(id_answer_button) {
	$(id_answer_button).removeClass('disabled');
}

function disable_answer_button(id_answer_button) {
	$(id_answer_button).addClass('disabled');
}

function show_free_answer_message(el) {
	$(el).parent().children('.alert').show();
	$(el).parent().children('.add_fields_answer').addClass('disabled');
}

function hide_free_answer_message(el) {
	$(el).parent().children('.alert').hide();
	$(el).parent().children('.add_fields_answer').removeClass('disabled');
}
 
var counter = 0;

function give_me_counter() {
	var v = counter;
	counter += 1;
	return v;
}

$('.question_type_choosing_answer').each(function(index) {
    $(this).on("click", function (){ 
        console.log("click 1");
        $(this).parent().children('.alert').hide();
     	});
    });


$('.question_type_free_answer').each(function() {
    $(this).on("click", function (){
        console.log("click 2");
        $(this).parent().children('.alert').show();
    });
});

function send_result(path, quiz_id, user_id, random_link) {
    var data = { "result": {"quiz_id": quiz_id, "user_id": user_id}};
    var answer_ids = [];
    var free_answers_question_id = [];

    $(".answer_checkbox").each(function() {
        if ($(this).is(":checked")) {
            var arr = $(this).attr('id').split('_');
            answer_ids.push(arr[2]);
        }
    });

    $(".free_answer").each(function() {
        var arr = $(this).attr('id').split('_');
        var obj = {};
        obj[arr[2]] = $(this).val();
        console.log(obj);
        free_answers_question_id.push(obj);
    });

    data.answer_ids = answer_ids;
    data.free_answers_question_id = free_answers_question_id;
    data.random_link = random_link;

    $.post(path, data);
    window.location.replace('/result/' + random_link);
}

function update_answers(path) {
    var answer_ids_correct = [];
    var answer_ids_wrong = [];

    $(".radio_button_correct").each(function() {
        if ($(this).is(":checked")) {
            var arr = $(this).attr('id').split('_');
            answer_ids_correct.push(arr[2]);
        }
    });

    $(".radio_button_wrong").each(function() {
        if ($(this).is(":checked")) {
            var arr = $(this).attr('id').split('_');
            answer_ids_wrong.push(arr[2]);
        }
    });

    for (var i = 0; i < answer_ids_correct.length; i++) {
       var data = { "given_answer": {"correct_answer" : true}};
       $.post(path + answer_ids_correct[i], data); 
    }

    for (var i = 0; i < answer_ids_wrong.length; i++) {
       var data = { "given_answer": {"correct_answer" : false}};
       $.post(path + answer_ids_wrong[i], data); 
    }
}