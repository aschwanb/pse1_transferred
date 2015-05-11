# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('.count').each ->
    $(this).prop('Counter', 0).animate({
      Counter: $(this).text()
    }, {
      duration: 3000,
      easing: 'swing',
      step: (now) ->
        $(this).text(Math.ceil(now));
    })
  $('.explode').css('visibility', 'hidden')
  $('.error h2').hide()
  $('.error button').hide()
  setTimeout ( ->
    $('.explode').css('visibility', 'visible').hide().fadeIn 'slow'
    $('.error h2').fadeIn 'slow'
    $('.error button').fadeIn 'slow'
  ), 3000
  setTimeout ( ->
    $('.count').each ->
      $(this).prop('Counter', $(this).text()).animate({
        Counter: 0
      }, {
        duration: 10000,
        easing: 'swing',
        step: (now) ->
          $(this).text(Math.ceil(now));
      })
      setTimeout ( ->
        window.location = '../../'
      ), 11000
  ), 4000


