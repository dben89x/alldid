$(document).ready ->
  if $('#client-radio-btn').is(':checked')
    $('#client-radio').css('background-color', 'rgba(25,88,108,0.4)')
    $('.brand-btn').removeClass('dark-brand-btn').addClass('light-brand-btn')
    $('.form').removeClass('dark-form').addClass('light-form')

  $('#client-radio, #barber-radio').on 'click', ->
    if $('#client-radio-btn').is(':checked')
      $('#client-radio').css('background-color', 'rgba(25,88,108,0.4)')
      $('.brand-btn').removeClass('dark-brand-btn').addClass('light-brand-btn')
      $('.form').removeClass('dark-form').addClass('light-form')
      $('#barbershop-info').css('display', 'none')
    else
      $('#client-radio').css('background-color', 'transparent')


    if $('#barber-radio-btn').is(':checked')
      $('#barber-radio').css('background-color', 'rgba(94, 21, 19, 0.4)')
      $('.brand-btn').removeClass('light-brand-btn').addClass('dark-brand-btn')
      $('.form').removeClass('light-form').addClass('dark-form')
      $('#barbershop-info').css('display', 'block')
    else
      $('#barber-radio').css('background-color', 'transparent')
