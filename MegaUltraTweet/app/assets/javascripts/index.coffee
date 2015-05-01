# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require jquery
#= require wiselinks


#(($) ->
#  msnry_data = {
#    columnWidth: 200,
#    itemSelector: '.item'
#  }
#  msnry = new Masonry('#container', msnry_data)
#)jQuery


$(document).ready ->
  window.wiselinks = new Wiselinks('#content')

$(document).on 'page:loading', ->
  $('.se-pre-con').fadeIn 'fast'
$(document).on 'page:always', ->
  $('.se-pre-con').fadeOut 'fast'
$(document).ready ->
  $('.se-pre-con').fadeOut 'slow'


#$(window).on 'page:load', ->
#  $('.se-pre-con').fadeOut 'slow'
#
#$(window).on 'page:fetch', ->
#  $('.se-pre-con').fadeIn 'slow'
#
#$(window).on 'page:before-unload', ->
#  $('.se-pre-con').fadeOut 'slow'
#
#$(window).on 'page:change', ->
#  $('.se-pre-con').fadeOut 'slow'
#
#$(window).on 'page:restore', ->
#  $('.se-pre-con').fadeOut 'slow'
#
#$(window).on 'page:update', ->
#  $('.se-pre-con').fadeOut 'slow'
#
#$(window).on 'before-change', ->
#  $('.se-pre-con').fadeOut 'slow'


#$(window).addEventListener 'page:restore', ->
#  $('.se-pre-con').fadeOut 'slow'

#$(document).on 'page:fetch', -> $('.se-pre-con').fadeIn 'slow'
#$(document).on 'page:receive', -> $('.se-pre-con').fadeOut 'slow'