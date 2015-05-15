'use strict';

var System = (function module(Loader) {

  var applications = null;

  function drawChart() {
    Loader.load('/admin/people.json', getApplications);
  }

  function getApplications() {
    applications = _.groupBy(JSON.parse(this.response),
      function(person) {
        return [person.first_name];
      });

    console.log(applications);

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