# http://stackoverflow.com/questions/8950761/google-chart-redraw-scale-with-window-resize
# Lodash is available at _

#= require /Users/artemchernyak/dev/honorflight-rails/app/assets/javascripts/charts/loader.js
#= require /Users/artemchernyak/dev/honorflight-rails/app/assets/javascripts/charts/flight.js
#= require /Users/artemchernyak/dev/honorflight-rails/app/assets/javascripts/charts/system.js


google.load 'visualization', '1.0',  {
  'packages': ['corechart']
}

google.setOnLoadCallback Flights.drawChart

$(window).resize ->
  if this.resizeTO
    clearTimeout(this.resizeTO)
  this.resizeTO = setTimeout ->
    $(this).trigger('resizeEnd')
    return
  , 50
  return

$(window).on 'resizeEnd', ->
  drawChart()
  return

