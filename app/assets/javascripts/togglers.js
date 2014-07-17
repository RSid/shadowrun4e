var toggleEditForms;
toggleEditForms = function() {
  $('.editing-characters').hide();
  $(".edit-character-hover").click(function() {
    $('.editing-characters').toggle();
  });
};

var toggleDeletion;
toggleDeletion = function() {
  $('#char-deletion').hide();
  $("#character-name").mouseover(function() {
    $('#char-deletion').toggle();
  });
};

var toggleResults;
toggleResults = function() {
  $("#roll-dice").click(function() {
    $('.result').toggle();
  });
};

$( document ).ready(toggleEditForms);
$(document).on('page:load', toggleEditForms);

$( document ).ready(toggleDeletion);
$(document).on('page:load', toggleDeletion);

$( document ).ready(toggleResults);
$(document).on('page:load', toggleResults);
