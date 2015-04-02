
$(function(){
  $(document).on("click", "a.has_many_add", function(){
    $('[id*=address_attributes_zipcode_input]').siblings().find('.button.has_many_remove').hide();
  });
});


$(function(){
  $(document).on("change", "select.medical_condition_type_dd", function(){
    var $select = $(this);
    var $nameSelect = $select.parent("li").siblings("li").find(".medical_condition_name_dd");
    var type_id = $select.val();

    var narrowMedicalNameList = function(data, select, nameSelect){
      $names = $(nameSelect);
      $names.val("");
      $names.children("option").attr("style", "display:none");
      $names.children("option").each(function(){
        // data and look through it for it's there, remove style
        for(var i = 0; i < data.length; i = i + 1){
          if (parseInt($(this).val()) == data[i].id){
            $(this).removeAttr("style")
          }
        }
      });
    };

    $.get("/admin/medical_condition_names.json?utf8=%E2%9C%93&q%5Bmedical_condition_type_id_eq%5D=" + type_id + "&commit=Filter&order=id_desc", "", function(data){ narrowMedicalNameList(data, $select, $nameSelect); }, "json");
  });
});