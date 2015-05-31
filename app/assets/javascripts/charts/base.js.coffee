# http://stackoverflow.com/questions/8950761/google-chart-redraw-scale-with-window-resize
# Lodash is available at _

#= require charts/loader
#= require charts/system


google.load 'visualization', '1.0',  {
  'packages': ['corechart']
}

$(window).resize ->
  if this.resizeTO
    clearTimeout(this.resizeTO)
  this.resizeTO = setTimeout ->
    $(this).trigger('resizeEnd')
    return
  , 50
  return


# Only load these when something is requesting one of them
$ ->
  if $('#chart_flight_branches').length >= 1
    google.setOnLoadCallback Flights.drawChart
    $(window).on 'resizeEnd', ->
      Flights.redrawChart()
  
  if $('#chart_application_by_month').length >=1
    google.setOnLoadCallback system.drawChart
    $(window).on 'resizeEnd', ->
      system.redrawChart()


