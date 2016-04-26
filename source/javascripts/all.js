//= require jquery.min
//= require bootstrap.min
//= require clean-blog.min

// $(".song_text").text().split("\n").map(function(o){return o.length})

// Math.max.apply(Math,array.map(function(o){return o.y;}))

$(document).ready(function() {

    var max_length = Math.max.apply(Math,
                                    $(".song_text")
                                    .text()
                                    .split("\n")
                                    .map(function(o){return o.length}));

    var font_size = 180/max_length + "vw";
    if ($(window).width() < 400 ) {
        $(".song_text").css("font-size", font_size );
    } else {
        $(".song_text").css("font-size", "1em" );
    }
});
