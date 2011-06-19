// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {
    $('.witness_button').bind('ajax:success', function() {  
        $(this).closest('div').fadeOut();  
    });
});  


