$ ->
  len = undefined
  len = $(".remove_nested_fields:visible").length
  $(".remove_nested_fields").hide()  if len is 1
  $(".remove_nested_fields").click ->
    len = $(".remove_nested_fields:visible").length
    $(".remove_nested_fields").hide()  if len is 2
    return

  $("input:file").change ->
    $(".fileinput-new").html $(this).val()
    $("#invitee").hide()
    $(".add_nested_fields").hide()
    $("input.btn").tooltip("show")
    return
  return
