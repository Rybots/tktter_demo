// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .


// --- お気に入りボタン ----
$(document).on( 'turbolinks:load', function(){
    console.log('turbolinks:load');
    $(".fave").on("click", function(e) {
        e.preventDefault();
        if ($(this).hasClass("is-active")){ 
            $(this).removeClass("is-active");
            //console.log(idname);
            document.cookie = `data_${$(this).attr('id')}=0;path=/;`;
        }else{
            $(this).toggleClass("is-active");
            document.cookie = `data_${$(this).attr('id')}=1;path=/;`;                                     
            console.log(document.cookie);
        }
    });
});  
