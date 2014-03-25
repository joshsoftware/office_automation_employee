$(document).ready ->

  $("#datepicker1").datepicker endDate: "Today", format: "yyyy-mm-dd"

  $("ul.nav-tabs > li > a").on "shown.bs.tab", (e) ->
    id = $(e.target).attr("href").substr(1)
    localStorage.setItem('lastTab', id)

  lastTab = localStorage.getItem('lastTab')

  if lastTab
    $('ul.nav-tabs').children().removeClass('active')
    $('#' + lastTab + '_tab').parents('li:first').addClass('active')
    $('div.tab-content').children().removeClass('active')
    $('#' + lastTab).addClass('active')
  
  list = ["address", "pincode", "city", "state", "country", "phone"]

  if $("#same_user_address").prop("checked") is true
    for value in list
      $("#user_personal_profile_attributes_current_address_"+value).attr("readonly", "readonly")

   $("#same_user_address").on "change", ->
    if $("#same_user_address").prop("checked") is true
      for value in list
        $("#user_personal_profile_attributes_current_address_"+value).val $("#user_personal_profile_attributes_permanent_address_"+value).val()
        $("#user_personal_profile_attributes_current_address_"+value).attr("readonly", "readonly")
    else
      for value in list
        $("#user_personal_profile_attributes_current_address_"+value).val ""
        $("#user_personal_profile_attributes_current_address_"+value).removeAttr("readonly")

