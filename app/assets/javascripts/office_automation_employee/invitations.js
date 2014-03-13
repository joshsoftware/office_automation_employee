$(function() {
    var len = $(".remove_nested_fields:visible").length
    if(len == 1)
        $(".remove_nested_fields").hide();

    $(".remove_nested_fields").click(function() {
        var len = $(".remove_nested_fields:visible").length
        if(len == 2)
            $(".remove_nested_fields").hide();
    });
});
