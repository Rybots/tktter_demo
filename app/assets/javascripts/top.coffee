# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# アーティスト一覧の索引

$(document).on 'turbolinks:load', ->
    

    $('.sakuin_gyou').on 'click', ->
         location.href = ("/?row=" + $(this).data("gyou"))
#        $('.sakuin_gyou_container').hide()
#        
#        
#        gyou = $(this).data("gyou")
#        selector = ".sakuin_kana_container[data-gyou=\"#{ gyou }\"]"
#        $(selector).show()
#        $("#header-title").text("アーティスト(" + "あかさたなはまやらわ".substr(gyou, 1) + "行)")

    $('.sakuin_kana').on 'click', ->
        location.href = ("/?index=" + $(this).data("kana"))
#        $('.sakuin_kana_container').hide()
#        
#        kana = $(this).data("kana")
#        selector = ".artists_group[data-kana=\"#{ kana }\"]"
#        $(selector).show()
#        $("#header-title").text("アーティスト(#{ kana })")
#        
        
        
        
        
        
        
        
        
    
#    $('.sakuin_gyou').on 'click', ->
#        gyou = $(this).data("gyou")
#
#        $('.sakuin_gyou').fadeOut(100)
#        
##        alert(gyou)
#        selector = ".sakuin_kana_container[data-gyou=\"#{ gyou }\"]"
#        
##        alert(selector)
##        $(selector).delay(100).fadeIn()
#        $(selector).show()
#        $(selector+" .sakuin_kana").each (i) ->
##            $(this).delay(50*i).fadeIn(250).animate({"left": "+=50px", "opacity: 100%"})
#            $(this).delay(1000*i).toggleClass("_hidden")
#        return 
#        
#    $('.sakuin_kana').on 'click', ->
#        $('.sakuin_kana').fadeOut(100)
#        
#        
#        kana = $(this).data("kana")
#        selector = ".artists_group[data-kana=\"#{ kana }\"]"
#        
#        $(selector).show()
#        
#        
#        $(selector+" .artist").each (i) ->
#            $(this).delay(50*i).removeClass("_hidden")
#            return 
    






