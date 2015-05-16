# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# effects for the error pages
$(document).ready ->
  count_up_dur = 3000
  wait_dur = 1000
  count_down_dur = 10000

  # count up to the error number
  $('.count').each ->
    $(this).prop('Counter', 0).animate({
      Counter: $(this).text()
    }, {
      duration: count_up_dur,
      easing: 'swing',
      step: (now) ->
        $(this).text(Math.ceil(now));
    })
  # set visibility of elements to hidden, after the counter reaches the error number, these fade in
  $('.explode').css('visibility', 'hidden')
  $('.error h2').hide()
  $('.error button').hide()
  setTimeout ( ->
    $('.explode').css('visibility', 'visible').hide().fadeIn 'slow'
    $('.error h2').fadeIn 'slow'
    $('.error button').fadeIn 'slow'
  ), count_up_dur
  setTimeout ( ->
    # count down after a delay
    $('.count').each ->
      $(this).prop('Counter', $(this).text()).animate({
        Counter: 0
      }, {
        duration: count_down_dur,
        easing: 'swing',
        step: (now) ->
          $(this).text(Math.ceil(now));
      })
      # redirect to front page
      setTimeout ( ->
        window.location = '../../'
      ), (count_down_dur+wait_dur)
  ), (count_up_dur+wait_dur)


