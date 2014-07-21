function DiceRoller(element) {
  this.$element = $(element);
  this.$form = this.$element.find('form');
  this.$dicePool = this.$element.find('.dice-pool').val();
}

DiceRoller.prototype = {
  roll: function(dicePool) {

    if (dicePool < 0 || dicePool > 60) { return; }

    var results = this.getResults(dicePool).join();

    var glitchThreatCount = $.grep(results, function(result) {
      return result === 1;
    }).length;

    var successCount = $.grep(results, function(result) {
      return result >= 4;
    }).length;


    var glitch = this.checkForGlitch(dicePool, successCount, glitchThreatCount);

    return 'Results: ' + results + ' Successes: ' + successCount + glitch;

  },

  rollFromForm: function(event) {
    event.preventDefault();
    var dicePool = this.$dicePool.val();
    this.roll(dicePool);
  },

  getResults: function(dicePool) {
    var results = [];

    for (i = 0; i < dicePool; i++) {
      results.push(Math.floor(Math.random() * (6 - 1 + 1)) + 1);
    }

    return results;
  },

  checkForGlitch: function(dicePool, successCount, glitchThreatCount) {
    var glitch;

    if (glitchThreatCount > 0 && glitchThreatCount >= (Math.round(dicePool/2))) {

      if (successCount === 0) {
        glitch = " Critical glitch!";
      } else {
        glitch = " Glitch!";
      }
    } else {
      glitch = ""
    }

    return glitch;
  }
};

var rollDice;
var rollDice = function() {

  $('.dice-roller').on('click','#die', function() {

    var diceRoller = new DiceRoller('.dice-roller');

  var firstResults = diceRoller.roll(diceRoller.$dicePool);

  var roller = "<div class='modal-dice-roller'><form>Roll dice: <input type='number' class='dice-pool' value = '0'" +
    "min = '0'><i class='fa fa-cube' id='modal-die'></i></form></div><br>";

  $.modal(roller + "<ul class = results><li>" + firstResults
    + "</li></ul>");

    $('.modal-dice-roller').on('click','#modal-die', function() {

      var modalDiceRoller = new DiceRoller('.modal-dice-roller');
      var ongoingResults = modalDiceRoller.roll(modalDiceRoller.$dicePool);
      $('.results').append("<li>" + ongoingResults+"</li>")

    });

  });

}



$( document ).ready(rollDice);
$(document).on('page:load', rollDice);
