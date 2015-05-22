# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require jquery
#= require wiselinks

# initialize wiselinks
$(document).ready ->
  window.wiselinks = new Wiselinks('#content')

# toggle loading animation on and off
$(document).on 'page:loading', ->
  $('.se-pre-con').fadeIn 'fast'
$(document).on 'page:always', ->
  $('.se-pre-con').fadeOut 'fast'
$(document).ready ->
  $('.se-pre-con').fadeOut 'slow'

# switch radio button functionality
$(document).on 'page:done', ->
  $('.switch-label').on 'click', ->
    opt = $(this).attr 'data-opt'
    target = $(this).attr 'data-target'
    $('.'+target).fadeOut 'fast'
    setTimeout ( ->
      $('.'+opt+'.'+target).css('visibility', 'visible').hide().fadeIn 'slow'
    ), 300


# this is needed so that the switch works after a page reload
$(document).ready ->
  $('.switch-label').on 'click', ->
    opt = $(this).attr 'data-opt'
    target = $(this).attr 'data-target'
    $('.'+target).fadeOut 'fast'
    setTimeout ( ->
      $('.'+opt+'.'+target).css('visibility', 'visible').hide().fadeIn 'slow'
    ), 300

