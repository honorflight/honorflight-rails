# http://stackoverflow.com/questions/8950761/google-chart-redraw-scale-with-window-resize
# Lodash is available at _

#= require charts/loader
#= require charts/flights
#= require charts/system


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
  Flights.redrawChart()
  return

