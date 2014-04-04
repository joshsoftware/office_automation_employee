ready = ->
  list = ["address", "pincode", "city", "state", "country", "phone"]
 
  $("#datepicker").datepicker endDate: "Today", format: "yyyy-mm-dd"

  if $("#same").prop("checked") is true
    for value in list
      $("#company_current_address_"+value).attr("disabled","disabled")

      $("#company_current_address_"+value).val $("#company_registered_address_"+value).val()

  $("#same").on "change", ->
    if $("#same").prop("checked") is true
      for value in list
        $("#company_current_address_"+value).val $("#company_registered_address_"+value).val()
        $("#company_current_address_"+value).attr("disabled", "disabled")
    else
      for value in list
        $("#company_current_address_"+value).val ""
        $("#company_current_address_"+value).removeAttr("disabled")
    return
  return

$(document).ready(ready)
$(document).on 'page:load', ready
