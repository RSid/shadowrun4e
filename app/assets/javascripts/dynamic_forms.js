var isMelee;
isMelee = function () {
  $('#guns-only').hide();

  $('#character_weapon_weapon_melee').change(function() {
    var melee = $('#character_weapon_weapon_melee option:selected').val();
    if(melee==='false') {
      $('#guns-only').show();
    } else {
      $('#guns-only').hide();
    }
  });
}

var gear;
gear = function() {
    $('#weapons-input').hide();
    $('#general-gear-input').hide();
    $('#armor-input').hide();
    $('#crafts-input').hide();

    $('#PickGear').change(function() {

      var optionValue = $('#PickGear option:selected').val();
      if ( optionValue==1 ) {
        $('#general-gear-input').hide();
        $('#armor-input').hide();
        $('#crafts-input').hide();

        $('#weapons-input').show();
      } else if ( optionValue==2 ){
          $('#weapons-input').hide();
          $('#general-gear-input').hide();
          $('#crafts-input').hide();

          $('#armor-input').show();
      } else if ( optionValue==3 ){
          $('#weapons-input').hide();
          $('#general-gear-input').hide();
          $('#armor-input').hide();

          $('#crafts-input').show();
      } else if ( optionValue==4 ){
          $('#weapons-input').hide();
          $('#armor-input').hide();
          $('#crafts-input').hide();

          $('#general-gear-input').show();
      } else if ( optionValue==0 ){
          $('#weapons-input').hide();
          $('#general-gear-input').hide();
          $('#armor-input').hide();
          $('#crafts-input').hide();
      } else {
          $('#weapons-input').hide();
          $('#general-gear-input').hide();
          $('#armor-input').hide();
          $('#crafts-input').hide();
      }
  });
};


var statChangeForm;
statChangeForm = function() {

    $('#change').change(function() {
      var attributeValue = $('#change option:selected').val();
      var attributeShow = $('#change option:selected').text();

      var html = "<label for='character_" + attributeValue +  "' class = 'new-form-field'>"
      + attributeShow +"</label>" + "<input class = 'new-form-field' id='character_" + attributeValue
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

$( document ).ready(isMelee);
$(document).on('page:load', isMelee);

$( document ).ready(statChangeForm);
$(document).on('page:load', statChangeForm);
