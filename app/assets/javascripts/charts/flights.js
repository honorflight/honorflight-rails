'use strict';

var Flights = (function module(Loader) {

  var branches = null;

  function drawChart() {
    Loader.load('/admin/day_of_flights/veterans_branches.json', getBranches);
  }

  function getBranches() {
    branches = _.map(_.groupBy(JSON.parse(this.response)), function(branch) {
      return [branch[0], branch.length];
    });

    draw();
  }

  function draw() {
    var chart, data, options;
    data = new google.visualization.DataTable();
    data.addColumn('string', 'Branch');
    data.addColumn('number', 'Veterans');
    data.addRows(branches);
    options = {
      'title': 'Veteran Branches on next Flight',
      'width': document.querySelector('#chart_flight_branches').style.width
    };
    chart = new google.visualization.PieChart(document.getElementById('chart_flight_branches'));
    return chart.draw(data, options);
  }


  return {
    drawChart: drawChart,
    redrawChart: draw
  };

})(Loader);