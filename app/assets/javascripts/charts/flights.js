'use strict';

var Flights = (function(Loader) {

  var branches = null;

  var drawChart = function() {
    Loader.load('/admin/day_of_flights/veterans_branches.json',
      function(chart) {
        branches = _.map(_.groupBy(JSON.parse(this.response)), function(branch) {
          return [branch[0], branch.length];
        });

        chart();
      }, chart);
  };

  var chart = function() {
    var chart1, data, options;
    data = new google.visualization.DataTable();
    data.addColumn('string', 'Branch');
    data.addColumn('number', 'Veterans');
    data.addRows(branches);
    options = {
      'title': 'Veteran Branches on next Flight',
      'width': document.querySelector('#chart_div').style.width
    };
    chart1 = new google.visualization.PieChart(document.getElementById('chart_div'));
    return chart1.draw(data, options);
  };


  return {
    drawChart: drawChart,
    redrawChart: chart
  };

})(Loader);