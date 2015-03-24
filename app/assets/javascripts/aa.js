
$(function(){
  $(document).on("click", "a.has_many_add", function(){
    $('[id*=address_attributes_zipcode_input]').siblings().find('.button.has_many_remove').hide();
  });
});
