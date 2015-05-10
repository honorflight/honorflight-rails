//= require charts/base

//hide add new button
$(function(){
  $(document).on("click", "a.has_many_add", function(){
    $('[id*=address_attributes_zipcode_input]').siblings().find('.button.has_many_remove').hide();
  });

  $(function(){
    $(document).on("change", "select.medical_condition_type_dd", filterMedicalConditions);
    $(document).on("change", "select.branch_dd,select.rank_type_dd", filterBranchRank);
    
    filterMedicalConditions("select.medical_condition_type_dd");
    filterBranchRank("select.branch_dd");
  });


  var filterMedicalConditions = function(selector){
    var $select = null;
    if (typeof selector === "object") {
      $select = $(this);
    } else {
      $select = $(selector);
    }

    var $nameSelect = $select.parent("li").siblings("li").find(".medical_condition_name_dd");

    $nameSelect.prop('disabled', true);

    $.get("/admin/medical_condition_names.json?utf8=%E2%9C%93&q%5Bmedical_condition_type_id_eq%5D=" + $select.val() + "&commit=Filter&order=id_desc", "", function(data){ narrowList(data, $nameSelect); }, "json");
  }


  var filterBranchRank = function(selector){
    var $select = null;
    if (typeof selector === "object") {
      $select = $(this);
    } else {
      $select = $(selector);
    }

    var $nameSelect = $select.parent("li").siblings("li").find(".rank_dd");

    if ($select.hasClass("branch_dd")){
      var branchId = $select.val();
      var rankTypeId = $select.parent("li").siblings("li").find(".rank_type_dd").val();
    } else {
      var branchId = $select.parent("li").siblings("li").find(".branch_dd").val();
      var rankTypeId = $select.val();
    }

    $nameSelect.prop('disabled', true);

    $.get("/admin/ranks.json?q%5Brank_type_id_eq%5D="+ rankTypeId +"&q%5Bbranch_id_eq%5D=" + branchId, "", function(data){  narrowList(data, $nameSelect); });
  };

  var narrowList = function(data, select){
    $names = $(select);
    var found = false;

    for (var i = 0; i < data.length; i++){
      var name = data[i];
      if (parseInt($names.val()) === name.id){
        found = true;
      } 
    }
    if (!found){
      $names.val("");
    }
    $names.children("option").attr("style", "display:none");
    $names.children("option").each(function(){
      // data and look through it for it's there, remove style
      for(var i = 0; i < data.length; i = i + 1){
        if (parseInt($(this).val()) == data[i].id){
          $(this).removeAttr("style")
        }
      }
    })
    $names.prop('disabled', false);
  };

  $(function(){
    $(document).on("change", "select.flight_responsibility_type_dd", function(){
      var $select = $(this);
      var $volunteerSelect = $select.parent("li").siblings("li").find(".volunteer_type_dd");

      var narrowVolunteersOnRole = function(roleId, volunteerSelect){
        // get volunteers by their role
        $.get("/admin/volunteers.json?utf8=✓&q%5Bvolunteers_roles_role_id_eq%5D=" + roleId + "&commit=Filter&order=id_desc", "", function(data){ 
          $names = $(volunteerSelect);
          $names.val("");
          $names.children("option").attr("style", "display:none");
          $names.children("option").each(function(){
            // data and look through it for it's there, remove style
            for(var i = 0; i < data.length; i = i + 1){
              if (parseInt($(this).val()) == data[i].id){
                $(this).removeAttr("style");
              }
            }
          });
        }, "json");
        $volunteerSelect.prop('disabled', false);
      };

      // GET ROLE ID FROM FLIGHT
      $volunteerSelect.prop('disabled', true);

      $.get("/admin/flight_responsibilities/"+ $select.val() +".json", "", function(data){ 
        var roleId = data.role_id;
        narrowVolunteersOnRole(roleId, $volunteerSelect);
      }, "json");

    });
  });
});

