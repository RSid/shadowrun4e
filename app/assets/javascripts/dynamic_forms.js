var gear;
gear = function() {
    $('#weapons-input').hide();
    $('#general-gear-input').hide();

    $('#PickGear').change(function() {

      var optionValue = $('#PickGear option:selected').val();

      if ( optionValue==1 ) {
        $('#weapons-input').show();
        $('#general-gear-input').hide();
      } else if ( optionValue==4 ){
          $('#weapons-input').hide();
          $('#general-gear-input').show();
      } else if ( optionValue==0 ){
          $('#weapons-input').hide();
          $('#general-gear-input').hide();
      } else {
        $('#weapons-input').hide();
        $('#general-gear-input').hide();
      }
  });
};

var statChangeForm;
statChangeForm = function() {

    $('#change').change(function() {
      var attributeValue = $('#change option:selected').val();

      var html = "<label for='character_" + attributeValue +  "' class = 'new-form-field'>"
      + attributeValue +"</label>" + "<input class = 'new-form-field' id='character_" + attributeValue
      + "' " + "name='character["
        + attributeValue + "] type='text'>";

      $('.edit-input').append(html);
  });

  $("#character-stat-edit").click(function() {
    $('.edit-input').toggle();
  });
};

$( document ).ready(gear);
$(document).on('page:load', gear);

$( document ).ready(statChangeForm);
$(document).on('page:load', statChangeForm);
