
$ ->
  
  # to hide remove link when text field is one
  len = $(".remove_nested_fields:visible").length
  $(".remove_nested_fields").hide()  if len is 1
  $(".remove_nested_fields").click ->
    len = $(".remove_nested_fields:visible").length
    $(".remove_nested_fields").hide()  if len is 2
    return

  
  # to notify about file upload
  $("input:file").change ->
    val = $("input:file").val()
    $("#helpCSV").modal "hide"
    $(".csvlink").text val
    return

  return

