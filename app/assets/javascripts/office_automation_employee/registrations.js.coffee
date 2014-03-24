$(document).ready ->
  list = ["address", "pincode", "city", "state", "country", "phone"]
 
  $("#datepicker").datepicker endDate: "Today", format: "yyyy-mm-dd"

  if $("#same").prop("checked") is true
    for value in list
      $("#company_current_address_"+value).attr("readonly","readonly")

  $("#same").on "change", ->
    if $("#same").prop("checked") is true
      for value in list
        $("#company_current_address_"+value).val $("#company_registered_address_"+value).val()
        $("#company_current_address_"+value).attr("readonly", "readonly")
    else
      for value in list
        $("#company_current_address_"+value).val ""
        $("#company_current_address_"+value).removeAttr("readonly")
    return
  return
