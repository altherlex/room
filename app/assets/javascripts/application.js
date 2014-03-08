// This is a manifest file that'll be compiled into including all the files listed below.
// // Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// // be included in the compiled file accessible from http://example.com/assets/application.js
// // It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// // the compiled file.
// //
//= require jquery
//= require jquery_ujs

$(document).ajaxComplete(function(event, request){
  if (request.status==200){
    r = $.parseJSON(request.responseText);
    $('#'+r.id).html(r.label);
  }
	$('div.alert').remove();
  var flash = $.parseJSON(request.getResponseHeader('X-Flash-Messages'));
  if(flash.notice) { 
  	$('#yield').prepend("<div class='alert alert-success'><p>"+flash.notice+"</p></div>");
 	}
  if(flash.error) { 
  	$('#yield').prepend("<div class='alert bg-danger'><p>"+flash.error+"</p></div>");
  }
  if(flash.warn) { 
  	$('#yield').prepend("<div class='alert bg-warning'><p>"+flash.warn+"</p></div>");
  }
});
