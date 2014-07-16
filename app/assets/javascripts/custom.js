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

var statChangeForm;
statChangeForm = function() {

    $('#change').change(function() {
      var attributeValue = $('#change option:selected').val();

      var html = "<label for='character_" + attributeValue +  "' class = 'new-form-field'>"
      + attributeValue +"</label>" + "<input class = 'new-form-field' id='character_" + attributeValue
      + "' " + "name='character["
        + attributeValue + "] type='text'>"

      $('.edit-input').append(html);
  });

  $("#character-stat-edit").click(function() {
    $('.edit-input').toggle();
  });
}

var ajaxer;
ajaxer = function() {

  $('#new_character_skill').on('submit', function(event) {
    event.preventDefault();
    var dataSubmit = $(this).serialize();

    $.ajax({
      type: "POST",
      url: $(this).attr('action'),
      dataType: "json",
      data: dataSubmit,
      success: function(data) {
        var newSkill = "<li>"+ data.skill.name +" Rating: "
          + data.characterskill.rating + " Specialization: "
          + data.characterskill.specialization + "</li>"
        $('#skills-list').append(newSkill);
      }
    });
  });

  $('#new_character_quality').on('submit', function(event) {
    event.preventDefault();
    var dataSubmit = $(this).serialize();

    $.ajax({
      type: "POST",
      url: $(this).attr('action'),
      dataType: "json",
      data: dataSubmit,
      success: function(data) {
        var newQuality = "<li>"+ data.quality.name +": "
          + data.quality.description + " Rating: "
          + data.characterquality.affect_rating + "</li>"
        $('#qualities-list').append(newQuality);
      }
    });
  });

  $('#new_connection').on('submit', function(event) {
    event.preventDefault();
    var dataSubmit = $(this).serialize();

    $.ajax({
      type: "POST",
      url: $(this).attr('action'),
      dataType: "json",
      data: dataSubmit,
      success: function(data) {
        var newConnection = "<li>"+ data.connection.name +": "
          + data.connection.description + " Loyalty: "
          + data.connection.loyalty + " Connection: "
          + data.connection.connection + "</li>"
        $('#connections-list').append(newConnection);
      }
    });
  });

  $('#new_character_weapon').on('submit', function(event) {
    event.preventDefault();
    var dataSubmit = $(this).serialize();

    $.ajax({
      type: "POST",
      url: $(this).attr('action'),
      dataType: "json",
      data: dataSubmit,
      success: function(data) {
        var newWeapon = "<li> New weapon quick-info: <br> &nbsp;&nbsp;"
          + data.weapon.name +": "
          + data.weapon.description + " Damage: "
          + data.weapon.damage + data.weapon.damage_type
          // + " Armor piercing: " + data.characterweapon.armor_piercing
          // + " Rating: " + data.characterweapon.rating
          // + " Concealability modifier: " + data.characterweapon.concealability
          // + " Legality: " + data.weapon.legality
          + "</li>"
        $('#weapons').append(newWeapon);
      }
    });
  });

  $('#new_character_tool').on('submit', function(event) {
    event.preventDefault();
    var dataSubmit = $(this).serialize();

    $.ajax({
      type: "POST",
      url: $(this).attr('action'),
      dataType: "json",
      data: dataSubmit,
      success: function(data) {
        var newTool = "<li>"
          + data.tool.name +", "
          + data.tool.description
          + "</li>"
        $('#general-gear').append(newTool);
      }
    });
  });

    $('.deleter').click(function(event) {
    event.preventDefault();

    var id = "#" + this.id;

    $.ajax({
      type: "DELETE",
      url: $(this).attr('href'),
      dataType: "json",
      success: function() {
        $(id).hide();
      }
    });
  });
}

var toggleEditForms;
toggleEditForms = function() {
  $('.editing-characters').hide();
  $(".edit-character-hover").click(function() {
    $('.editing-characters').toggle();
  });
}

var toggleDeletion;
toggleDeletion = function() {
  $('#char-deletion').hide();
  $("#character-name").mouseover(function() {
    $('#char-deletion').toggle();
  });
}

$( document ).ready(gear);
$(document).on('page:load', gear);

$( document ).ready(roll);
$(document).on('page:load', roll);

$(document).ready(ajaxer);
$(document).on('page:load', ajaxer);

$( document ).ready(statChangeForm);
$(document).on('page:load', statChangeForm);

$( document ).ready(toggleEditForms);
$(document).on('page:load', toggleEditForms);

$( document ).ready(toggleDeletion);
$(document).on('page:load', toggleDeletion);
