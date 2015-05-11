'use strict';

var Flights = (function(Loader) {

  var nearestFlight = function() {
    var flights = Loader.load('/admin/day_of_flights.json',
      function() {
        return JSON.parse(this.response);
      });

  };

  // var wars = function() {

  // };

  var drawChart = function() {
    var chart, data, options;
    data = new google.visualization.DataTable();
    data.addColumn('string', 'Branch');
    data.addColumn('number', 'Veterans');
    data.addRows([
      ['Army', 3],
      ['Marines', 1],
      ['Navy', 1],
      ['Air Force', 1],
      ['Coast Guard', 2]
    ]);
    options = {
      'title': '(DEMO:Fake) Veteran Branches on next Flight',
      'width': document.querySelector('#chart_div').style.width
    };
    chart = new google.visualization.PieChart(document.getElementById('chart_div'));
    return chart.draw(data, options);
  };

  return {
    flightData: nearestFlight,
    drawChart: drawChart
  };

})(Loader);

Flights.flightData();