'use strict';

var Loader = function() {

  var _xhrSuccess = function() {
    this.callback.apply(this, this.arguments);
  };

  var _xhrError = function() {
    console.error(this.statusText);
  };

  var loadFile = function(sURL, fCallback /*, argumentToPass1, argumentToPass2, etc. */ ) {
    var oReq = new XMLHttpRequest();
    oReq.callback = fCallback;
    oReq.arguments = Array.prototype.slice.call(arguments, 2);
    oReq.onload = _xhrSuccess;
    oReq.onerror = _xhrError;
    oReq.open('get', sURL, true);
    oReq.send(null);
  };

  return {
    load: loadFile
  };

};

var loader = new Loader();
'use strict';

var System = function module(loader) {

  var applications = null;

  function drawChart() {
    loader.load('/admin/people/applications.json', getApplications);
  };

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
  };

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
  };

  return {
    drawChart: drawChart,
    redrawChart: draw
  };

};

var system = new System(loader);
'use strict';

var Flights = function module(loader) {

  var branches = null;

  function drawChart() {
    loader.load('/admin/day_of_flights/veterans_branches.json', getBranches);
  };

  function getBranches() {
    branches = _.map(_.groupBy(JSON.parse(this.response)), function(branch) {
      return [branch[0], branch.length];
    });

    draw();
  };

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
  };


  return {
    drawChart: drawChart,
    redrawChart: draw
  };

};

var flights = new Flights(loader);
(function() {
  google.load('visualization', '1.0', {
    'packages': ['corechart']
  });

  $(window).resize(function() {
    if (this.resizeTO) {
      clearTimeout(this.resizeTO);
    }
    this.resizeTO = setTimeout(function() {
      $(this).trigger('resizeEnd');
    }, 50);
  });

  $(function() {
    if ($('#chart_flight_branches').length >= 1) {
      google.setOnLoadCallback(flights.drawChart);
      $(window).on('resizeEnd', function() {
        return flights.redrawChart();
      });
    }
    if ($('#chart_application_by_month').length >= 1) {
      google.setOnLoadCallback(system.drawChart);
      return $(window).on('resizeEnd', function() {
        return system.redrawChart();
      });
    }
  });

}).call(this);


//hide add new button
$(function() {
  $(document).on("click", "a.has_many_add", function() {
    $('[id*=address_attributes_zipcode_input]').siblings().find('.button.has_many_remove').hide();
  });

  $(function() {
    $(document).on("change", "select.medical_condition_type_dd", filterMedicalConditions);
    $(document).on("change", "select.branch_dd,select.rank_type_dd", filterBranchRank);

    filterMedicalConditions("select.medical_condition_type_dd");
    filterBranchRank("select.branch_dd");
  });


  var filterMedicalConditions = function(selector) {
    var $select = null;
    if (typeof selector === "object") {
      $select = $(this);
    } else {
      $select = $(selector);
    }

    var $nameSelect = $select.parent("li").siblings("li").find(".medical_condition_name_dd");

    $nameSelect.prop('disabled', true);

    $.get("/admin/medical_condition_names.json?utf8=%E2%9C%93&q%5Bmedical_condition_type_id_eq%5D=" + $select.val() + "&commit=Filter&order=id_desc", "", function(data) {
      narrowList(data, $nameSelect);
    }, "json");
  };


  var filterBranchRank = function(selector) {
    var $select = null;
    if (typeof selector === "object") {
      $select = $(this);
    } else {
      $select = $(selector);
    }

    var $nameSelect = $select.parent("li").siblings("li").find(".rank_dd");

    if ($select.hasClass("branch_dd")) {
      var branchId = $select.val();
      var rankTypeId = $select.parent("li").siblings("li").find(".rank_type_dd").val();
    } else {
      var branchId = $select.parent("li").siblings("li").find(".branch_dd").val();
      var rankTypeId = $select.val();
    }

    $nameSelect.prop('disabled', true);

    $.get("/admin/ranks.json?q%5Brank_type_id_eq%5D=" + rankTypeId + "&q%5Bbranch_id_eq%5D=" + branchId, "", function(data) {
      narrowList(data, $nameSelect);
    });
  };

  var narrowList = function(data, select) {
    console.log("Data: " + typeof(data));
    console.log("Data: " + select);
    var $names = $(select);
    var found = false;

    for (var i = 0; i < data.length; i++) {
      var name = data[i];
      if (parseInt($names.val()) === name.id) {
        found = true;
      }
    };
    if (!found) {
      $names.val("");
    };
    $names.children("option").attr("style", "display:none");
    $names.children("option").each(function() {
      // data and look through it for it's there, remove style
      for (var i = 0; i < data.length; i = i + 1) {
        if (parseInt($(this).val()) == data[i].id) {
          $(this).removeAttr("style")
        }
      };
    });
    $names.prop('disabled', false);
  };

  $(function() {
    $(document).on("change", "select.flight_responsibility_type_dd", function() {
      var $select = $(this);
      var $volunteerSelect = $select.parent("li").siblings("li").find(".volunteer_type_dd");

      var narrowVolunteersOnRole = function(roleId, volunteerSelect) {
        // get volunteers by their role
        $.get("/admin/volunteers/by_role.json?role_id=" + roleId, "", function(data) {
          var $names = $(volunteerSelect);
          $names.val("");
          $names.children("option").attr("style", "display:none");
          $names.children("option").each(function() {
            // data and look through it for it's there, remove style
            for (var i = 0; i < data.length; i = i + 1) {
              if (parseInt($(this).val()) == data[i].id) {
                $(this).removeAttr("style");
              }
            };
          });
        }, "json");
        $volunteerSelect.prop('disabled', false);
      };

      // GET ROLE ID FROM FLIGHT
      $volunteerSelect.prop('disabled', true);

      $.get("/admin/flight_responsibilities/" + $select.val() + ".json", "", function(data) {
        var roleId = data.role_id;
        narrowVolunteersOnRole(roleId, $volunteerSelect);
      }, "json");
    });
  });
});
