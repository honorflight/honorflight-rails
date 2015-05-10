# http://stackoverflow.com/questions/8950761/google-chart-redraw-scale-with-window-resize
# Lodash is available at _


google.load 'visualization', '1.0',  {
  'packages': ['corechart']
}

drawChart = ->
  data = new google.visualization.DataTable()
  data.addColumn 'string', 'Branch'
  data.addColumn 'number', 'Veterans'
  data.addRows [
    ['Army', 3],
    ['Marines', 1],
    ['Navy', 1],
    ['Air Force', 1],
    ['Coast Guard', 2]
  ]

  options = {
    'title':'(DEMO:Fake) Veteran Branches on next Flight',
    'width': $('#chart_div').width()
  }

  chart = new google.visualization.PieChart document.getElementById('chart_div')

  chart.draw(data, options)

google.setOnLoadCallback drawChart

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

