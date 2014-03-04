$(document).ready ->
  
  list = ["address", "pincode", "city", "state", "country", "phone"]
 
  console.log($("#same").prop("checked"))
  if $("#same").prop("checked") is true
    for value in list
      $("#user_company_attributes_current_address_"+value).attr("readonly","readonly")

  $("#same").on "change", ->
    if $("#same").prop("checked") is true
      for value in list
        $("#user_company_attributes_current_address_"+value).val $("#user_company_attributes_registered_address_"+value).val()
        $("#user_company_attributes_current_address_"+value).attr("readonly", "readonly")
    else
      for value in list
        $("#user_company_attributes_current_address_"+value).val ""
        $("#user_company_attributes_current_address_"+value).removeAttr("readonly")
    return
  
  return




