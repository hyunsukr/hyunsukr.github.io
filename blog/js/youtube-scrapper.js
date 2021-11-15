function httpGet()
{
    var channels = ['UCDBAVzfX3yZ1hah0FHnOoaA', 'UC4q2QOe3Ht73lVO-31JnkQQ', 'UCS3_H_feQRm4QbXipKTvSrw', 'UCZW0yRW2HK7_fzgL9HQu9ZA', 'UCRpdlPk671uOMiBtf5HtB3Q', 'UCugNO83_V7xZLzCsjpABGeg'];
    var title = [];
    var embeds = [];
    for (i =0 ; i < channels.length; i++ ) {
        var xmlHttp = new XMLHttpRequest();
        xmlHttp.open( "GET", 'https://www.googleapis.com/youtube/v3/search?key=AIzaSyC9gghahjuzwathjU4GGIwlKE3_H2a57HE&channelId='+ channels[i] +'&part=snippet,id&order=date&maxResults=2', false );
        xmlHttp.send( null );
        var response = JSON.parse(xmlHttp.responseText).items;
        var title_1 = response[0].snippet.channelTitle + ' : ' + response[0].snippet.title
        var url = '<iframe src="https://www.youtube.com/embed/'+ response[0].id.videoId +'" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'
        var title_2 = response[0].snippet.channelTitle + ' : ' + response[1].snippet.title
        var url_2 = '<iframe src="https://www.youtube.com/embed/'+ response[1].id.videoId +'"frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'
        title.push(title_1, title_2);
        embeds.push(url, url_2);
    }
    table = '<div class="row">';
    for (i =0 ; i < title.length; i++) {
        table = table + '<div class="col-md-6" style="padding:0;"> ' + title[i] + '<br><br>' + embeds[i] + '</div>'
    }
    table = table + '</div>';

    document.getElementById('response').innerHTML = table;
}