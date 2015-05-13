'use strict';

var System = (function module(Loader) {

  var branches = null;

  function drawChart() {
    Loader.load('/admin/day_of_flights/veterans_branches.json', getActivity);
  }

  function getActivity() {
    branches = _.map(_.groupBy(JSON.parse(this.response)), function(branch) {
      return [branch[0], branch.length];
    });

    draw();
  }

  function draw() {
    var data = new google.visualization.DataTable();
    data.addColumn('string', 'Month');
    data.addColumn('number', 'Guardians');
    data.addColumn('number', 'Volunteers');
    data.addColumn('number', 'Veterans');
    data.addColumn('number', 'Average');
    data.addRows([
      ['March', 10, 20, 30, 20],
      ['April', 5, 10, 5, 7],
      ['May', 20, 5, 10, 12]
    ]);

    var options = {
      title: 'Applications By Month',
      width: document.querySelector('#chart_application_by_month').style.width,
      vAxis: {
        title: 'Applications'
      },
      hAxis: {
        title: 'Month'
      },
      seriesType: 'bars',
      series: {
        3: {
          type: "line"
        }
      }
    };
    var chart = new google.visualization.ComboChart(document.getElementById('chart_application_by_month'));
    return chart.draw(data, options);
  }


  return {
    drawChart: drawChart,
    redrawChart: draw
  };

})(Loader);