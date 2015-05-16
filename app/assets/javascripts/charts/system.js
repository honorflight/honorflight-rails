'use strict';

var System = (function module(Loader) {

  var applications = null;

  function drawChart() {
    Loader.load('/admin/people/applications.json', getApplications);
  }

  function getApplications() {
    applications = _.map(JSON.parse(this.response),
      function parser(person, x) {
        var guardianCount = _.sum(_.pluck(person, 'Guardian'));
        var volunteerCount = _.sum(_.pluck(person, 'Volunteer'));
        var veteranCount = _.sum(_.pluck(person, 'Veteran'));
        var average = Math.round((guardianCount + volunteerCount + veteranCount) / 3);

        return [x, veteranCount, guardianCount, volunteerCount, average];
      });

    draw();
  }

  function draw() {
    var data = new google.visualization.DataTable();
    data.addColumn('string', 'Months');
    data.addColumn('number', 'Veterans');
    data.addColumn('number', 'Guardians');
    data.addColumn('number', 'Volunteers');
    data.addColumn('number', 'Average');
    data.addRows(applications);

    var options = {
      title: 'Applications By Month',
      width: document.querySelector('#chart_application_by_month').style.width,
      vAxis: {
        title: 'Applications'
      },
      hAxis: {
        title: 'Months'
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