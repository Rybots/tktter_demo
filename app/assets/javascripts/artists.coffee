# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



### ヘッダーのドロワーメニュー

$(document).on 'turbolinks:load', ->
    $('#button-menu').on 'click', ->
#        alert("hoge")
        $('#drawer').toggleClass "drawer-open"
    
    $('#drawer-overlay').on 'click', ->
        $('#drawer').toggleClass "drawer-open"
        
        
###        
        
        
        
$(document).on 'turbolinks:load', ->
    $('#button-menu').on 'click', ->
        location.href = "/#"