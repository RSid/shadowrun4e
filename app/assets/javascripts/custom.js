var ready;
ready = function() {

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

}

$( document ).ready(ready);
$(document).on('page:load', ready);

$( document ).ready(function() {
  $('#die').click(function() {
    var dicepoolValue = $('#dicepool').val();

    if(dicepoolValue > 0) {
      var results = [];
      for (i = 0; i < dicepoolValue; i++) {
        results.push(Math.floor(Math.random() * (6 - 1 + 1)) + 1);
      }

      var returned = results.join();
      alert("Results: " + returned);
    } else {
      alert("Please choose a positive number of dice!");
    }
  });
});
