$(document).on('turbolinks:load', function(){
    $('#button_back').on('click', function(){
        
        var href;
        href = location.href.replace(/\/[^\/]+$/, '');
        
        
        if (location.pathname == "/fav"){
            window.history.back(-1);
        }

        else if (location.pathname === "/"){
            
            var sakuin = [
                "アイウエオ",
                "カキクケコ",
                "サシスセソ",
                "タチツテト",
                "ナニヌネノ",
                "ハヒフヘホ",
                "マミムメモ",
                "ヤユヨ",
                "ラリルレロ",
                "ワオン"
            ];
            
            
            
            
            var row = location.search.substr(1).split("&")[0].match(/^row=(\d+)/);
            var index = location.search.substr(1).split("&")[0].match(/^index=(\d+)/);
            

            
            if ( index!== null){
                var kana = sakuin.join("").substr(index[1],1);
                
                for (var j = 0; j<sakuin.length;j++){
                    
                    if (sakuin[j].indexOf(kana) >= 0){
                        href += "/?row=" + j;
                    }
                }
                
            }else if( row !== null){
//                href = location.href.replace(/\/[^\/]+$/, '');
            }
        }else {
//            href = location.href.replace(/\/[^\/]+$/, '');
        }
        
        location.href= href;
//        console.log(`href=${href}`);
    });
});
