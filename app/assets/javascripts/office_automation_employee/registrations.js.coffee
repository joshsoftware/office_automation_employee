$(document).ready ->
  $("#same").on "change", ->
    list = ["address", "pincode", "city", "state", "country", "phone"]
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

