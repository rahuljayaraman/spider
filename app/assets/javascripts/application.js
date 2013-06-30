// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){
  $('body').on('click', '.form_action', function() {
    render_form_fields();
  });

  $('body').on('click', '.click_action', function() {
    render_click_fields();
  });
});

function render_click_fields() {
  date = new Date();
  time = date.getTime();
  click =  "<input name='clicks[" + time +"][click]' id='click' placeholder='Click on' type='text'>"
  $("div.click_on").prepend(click);
};

function render_form_fields() {
  date = new Date();
  time = date.getTime();
  field_name =  "<input name='forms[" + time +"][field_name]' id='field_name' placeholder='Field Name' type='text'>"
  field_content =  "<input name='forms[" + time +"][field_content]' id='field_content' placeholder='Field Content' type='text'><br>"
  $("div.fill_form").prepend(field_name + field_content);
};
