var xmlhttp = new XMLHttpRequest();
xmlhttp.onreadystatechange = function() {
  if (this.readyState == 4 && this.status == 200) {
    var myObj = JSON.parse(this.responseText);
    var makemap = 0;
    var locations = []
    for (var i = 0; i < myObj[0]["location"]["names"].length; i++) {
      if (i == myObj[0]["location"]["names"].length - 1) {
        locations.push([myObj[0]["location"]["names"][i], 
                      myObj[0]["location"]["latitude"][i], 
                      myObj[0]["location"]["longitude"][i],
                      myObj[0]["location"]["order"][i]])
        makemap++;
      }
      else {
        locations.push([myObj[0]["location"]["names"][i], 
                      myObj[0]["location"]["latitude"][i], 
                      myObj[0]["location"]["longitude"][i],
                      myObj[0]["location"]["order"][i]])
      }
    }
    if (makemap != 0) {
      var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 2,
        center: new google.maps.LatLng(39.8283, -98.5795),
        mapTypeId: google.maps.MapTypeId.ROADMAP
      });
      var infowindow = new google.maps.InfoWindow();
      var marker, i;
      for (i = 0; i < locations.length; i++) { 
        marker = new google.maps.Marker({
            position: new google.maps.LatLng(locations[i][1], locations[i][2]),
            map: map
        });
        google.maps.event.addListener(marker, 'click', (function(marker, i) {
            return function() {
                infowindow.setContent(locations[i][0]);
                infowindow.open(map, marker);
            }
        })(marker, i));
      }
    }

  }
};
xmlhttp.open("GET", "location.json", true);
xmlhttp.send();
