var gear;
gear = function() {

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

var roll;
roll = function() {

$('#die').click(function() {
    var dicepoolValue = $('#dicepool').val();

    if(dicepoolValue > 0 && dicepoolValue < 60) {
      var results = [];
      for (i = 0; i < dicepoolValue; i++) {
        results.push(Math.floor(Math.random() * (6 - 1 + 1)) + 1);
      }

      var successes = [];
      var glitchThreat = [];

      results.sort
      for(i=0; i < results.length; i++) {
        if(results[i] >= 4) {
          successes.push(results[i]);
        } else if (results[i]===1) {
          glitchThreat.push(results[i]);
        }
      }

      var glitch = "";

      if(glitchThreat.length >= (dicepoolValue/2)) {
        if(successes.length === 0) {
          glitch = " Critical glitch!";
        } else {
          glitch = " Glitch!";
        }
      }

      var returned = results.join();

      var result = $("<li>");
      result.html("Results: " + returned + " Successes: " +
        successes.length + glitch).css("font-weight", "bold");
      $('#quick-actions').append(result);


    } else if (dicepoolValue <=0){
      alert("Please choose a positive number of dice!");
    } else {
      alert("Pretty sure you don't have that big a dice pool, champ.");
    }
  });
}


$( document ).ready(gear);
$(document).on('page:load', gear);

$( document ).ready(roll);
$(document).on('page:load', roll);
