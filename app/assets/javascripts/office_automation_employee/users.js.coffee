window.ready = ->

  $(".customdatepicker").datepicker endDate: "Today", format: "yyyy-mm-dd"
  
  list = ["address", "pincode", "city", "state", "country", "phone"]

  if $("#same_user_address").prop("checked") is true
    for value in list
      $("#user_personal_profile_attributes_current_address_"+value).attr("disabled", "disabled")
      $("#user_personal_profile_attributes_current_address_"+value).val $("#user_personal_profile_attributes_permanent_address_"+value).val()

   $("#same_user_address").on "change", ->
    if $("#same_user_address").prop("checked") is true
      for value in list
        $("#user_personal_profile_attributes_current_address_"+value).val $("#user_personal_profile_attributes_permanent_address_"+value).val()
        $("#user_personal_profile_attributes_current_address_"+value).attr("disabled", "disabled")
    else
      for value in list
        $("#user_personal_profile_attributes_current_address_"+value).val ""
        $("#user_personal_profile_attributes_current_address_"+value).removeAttr("disabled")

$(document).ready(ready)
$(document).on 'page:load', ready
