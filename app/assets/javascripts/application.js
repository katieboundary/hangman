// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


$(document).ready(function() {
  $('#game-form').on('submit', updateGame);

});

function updateGame(event){

    var form = $(this)
    var data = form.serialize();
    var url = form.attr('action');
    var method = form.attr('method');

    $.ajax({
      url: url,
      method: method,
      data: data
    }).done(function(response){

      console.log(response)

      $('#guess').val('');
      $('#guess').focus();
      $('#guesses-left').text(response.guesses_left)
      $('#word-display').text(response.word_display)
      $('#display-incorrect-guesses').text(response.display_incorrect_guesses)
      if (response.playing){
        $('#playing').show()
      }
      else{
        $('#playing').hide()
      }

      if (response.won){
        $('#won').show()
      }
      else{
        $('#won').hide()
      }

      if (response.lost){
        $('#lost').show()
      }
      else{
        $('#lost').hide()
      }
    });
};



