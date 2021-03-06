function addFlashNotice(message) {
  var flash = $('<p>')
    .addClass('notice')
    .text(message);
  $('#notifications').html('').append(flash);
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
        var newSkill = "<li>"+ data.skill.name +" Rating: " +
          data.characterskill.rating + " Specialization: " +
          data.characterskill.specialization + "</li>";
        $('#skills-list').append(newSkill);
      },
      error: function() {
        addFlashNotice('Uh oh! Your skill could not be saved');
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
        var newQuality = "<li>"+ data.quality.name +": " +
          data.quality.description + " Rating: " +
          data.characterquality.affect_rating + "</li>";
        $('#qualities-list').append(newQuality);
      },
      error: function() {
        addFlashNotice('Uh oh! Your quality could not be saved');
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
        var newConnection = "<li>"+ data.characterconnection.name +": " +
          data.characterconnection.description + " Loyalty: " +
          data.characterconnection.loyalty + " Connection: " +
          data.characterconnection.connection + "</li>";
        $('#connections-list').append(newConnection);
      },
      error: function() {
        addFlashNotice('Uh oh! Your connection could not be saved');
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
        var newWeapon = "<li> New weapon quick-info: <br> &nbsp;&nbsp;" +
          data.weapon.name +": " +
          data.weapon.description + " Damage: " +
          data.weapon.damage + data.weapon.damage_type +
          // " Armor piercing: " + data.characterweapon.armor_piercing +
          " Rating: " + data.characterweapon.rating +
          // " Concealability modifier: " + data.characterweapon.concealability +
          // " Legality: " + data.weapon.legality +
          "</li>";
        $('#weapons').append(newWeapon);
      },
      error: function() {
        addFlashNotice('Uh oh! Your weapon could not be saved');
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
        var newTool = "<li>" +
          data.tool.name +", " +
          data.tool.description +
          "</li>";
        $('#general-gear').append(newTool);
      },
      error: function() {
        addFlashNotice('Uh oh! Your gear could not be saved');
      }
    });
  });

  $('#new_character_armor').on('submit', function(event) {
    event.preventDefault();
    var dataSubmit = $(this).serialize();

    $.ajax({
      type: "POST",
      url: $(this).attr('action'),
      dataType: "json",
      data: dataSubmit,
      success: function(data) {
        var newArmor = "<li>"
          data.armor.name +", " +
          data.armor.description + " " +
          data.armor.ballistic + "/" +
          data.armor.impact +
          "</li>";
        $('#armor').append(newArmor);
      },
      error: function() {
        addFlashNotice('Uh oh! Your armor could not be saved');
      }
    });
  });

  $('#new_character_craft').on('submit', function(event) {
    event.preventDefault();
    var dataSubmit = $(this).serialize();

    $.ajax({
      type: "POST",
      url: $(this).attr('action'),
      dataType: "json",
      data: dataSubmit,
      success: function(data) {
        var newCraft = "<li>" +
          data.craft.name +", " +
          data.craft.description +
          "Handling: "+ data.craft.handling + " " +
          "Acceleration: "+ data.craft.acceleration + " " +
          "Pilot: "+ data.craft.pilot + " " +
          "Speed: "+ data.craft.speed + " " +
          "Body: "+ data.craft.body + " " +
          "Armor: "+ data.craft.armor + " " +
          "Sensor: "+ data.craft.sensor + " " +
          "</li>";
        $('#crafts').append(newCraft);
      },
      error: function() {
        addFlashNotice('Uh oh! Your craft could not be saved');
      }
    });
  });

  $('#new_character_cyberbioware').on('submit', function(event) {
    event.preventDefault();
    var dataSubmit = $(this).serialize();

    $.ajax({
      type: "POST",
      url: $(this).attr('action'),
      dataType: "json",
      data: dataSubmit,
      success: function(data) {
        var newCyberbioware = "<li>" +
          data.cyberbioware.name +", " +
          data.cyberbioware.description +
          "Capacity: "+ data.cyberbioware.capacity + " " +
          "Rating: "+ data.charactercyberbioware.rating + " " +
          "Legality: "+ data.cyberbioware.legality + " " +
          "</li>";
        $('#cyberbioware').append(newCyberbioware);
      },
      error: function() {
        addFlashNotice('Uh oh! Your cyberware/bioware could not be saved');
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
      },
      error: function() {
        addFlashNotice('You are not logged in. You must be logged in to edit a character.');
      }
    });
  });
};


$(document).ready(ajaxer);
$(document).on('page:load', ajaxer);
