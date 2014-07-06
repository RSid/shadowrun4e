$( document ).ready(function() {
  $('#weapons-input').hide();
  $('#general-gear-input').hide();

  $('#PickGear').change(function() {

    var optionValue = $('#PickGear option:selected').val();

    if ( optionValue==1 ) {

      $('#weapons-input').show();
      $('#general-gear-input').hide();
      $('#under-constructon').show();

    } else if ( optionValue==4 ){
        $('#weapons-input').hide();
        $('#general-gear-input').show();
    }

    else {
      $('#weapons-input').hide();
      $('#general-gear-input').hide();
      $('#under-constructon').show();
    }
  });
});
