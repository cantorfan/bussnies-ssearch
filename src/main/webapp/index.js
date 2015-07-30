var map;
var pos;
/**
init google map and get location
**/
function initialize() {
	var mapOptions = {
		zoom: 10,
		disableDefaultUI: false
	};
	map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

	// Try HTML5 geolocation
	if(navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(function(position) {
			pos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);

			var infowindow = new google.maps.InfoWindow({
				map: map, position: pos, content: "Here"
			});

			map.setCenter(pos);
		}, function() {
			handleNoGeolocation(true);
		});
	} else {
		// Browser doesn't support Geolocation
		handleNoGeolocation(false);
	}
}

function handleNoGeolocation(errorFlag) {
	if (errorFlag) {
		var content = 'Error: The Geolocation service failed.';
	} else {
		var content = 'Error: Your browser doesn\'t support geolocation.';
	}

	pos = new google.maps.LatLng(60, 105);
	var options = {
		map: map,
		position: pos,
		content: content
	};
	
	var infowindow = new google.maps.InfoWindow(options);
	map.setCenter(options.position);
}

google.maps.event.addDomListener(window, 'load', initialize);

$("#searchSubmtBtn").click(function(){
	var name = $("#name").val();
	var address = $("#address").val();
	var number = $("#number").val();
	
//	var vurl = "https://maps.googleapis.com/maps/api/place/radarsearch/json?"+
//		"location="+pos.lat()+","+pos.lng()+
//		"&radius=5000"+
//		"&types=geocode"+
//		"&keyword="+number+
//		"&key="+key;
			
	$.get("request.jsp", {"name": name, "address": address, "number": number, "_":new Date().getTime()}, 
		function(data){
			
		var result = $.parseJSON(data)
		$("#items").hide().html("");
		if(result.status){
			
			var cname =  result.name;
			var caddress = result.address;
			var cphone = result.phone;

			var index = cname.toLowerCase().indexOf(name.toLowerCase());
			if(index!=-1){
				var f = cname.substring(0, index);
				var t = cname.substring(index, index+name.length);
				var e = cname.substring(index+name.length);
				var item = "<li>"+f+"<span class=\"same\">"+t+"</span>"+e+"</li>";
				console.log(item);
				$("#items").append(item);
			}else{
				$("#items").append("<li>"+cname+"</li>");
			}
			
			
			var addesses = address.split(/\s+/g);
			if(addesses.length>0){
				var item = "<li>";
				
				for(var i=0; i<addesses.length; i++){
					var ads = addesses[i];
					index = caddress.toLowerCase().indexOf(ads.toLowerCase());
					if(index!=-1){
						var f = caddress.substring(0, index);
						var t = caddress.substring(index, index+ads.length);
						var e = caddress.substring(index+ads.length);
						caddress = f+"<span class=\"same\">"+t+"</span>"+e+"&nbsp;&nbsp;";
					}
				}
				
				item+=caddress;
				
				item += "</li>";
				console.log(item);
				$("#items").append(item);
			}else{
				$("#items").append("<li>"+caddress+"</li>");
			}
			
			index = cphone.toLowerCase().indexOf(number.toLowerCase());
			if(index!=-1){
				var f = cphone.substring(0, index);
				var t = cphone.substring(index, index+number.length);
				var e = cphone.substring(index+number.length);
				var item = "<li>"+f+"<span class=\"same\">"+t+"</span>"+e+"</li>";
				console.log(item);
				$("#items").append(item);
			}else{
				$("#items").append("<li>"+cphone+"</li>");
			}
			
		}else{
			var $item = $("<li>not found!</li>");
			$("#items").append($item);
			
		}
		$("#items").show("slow");
			
		/*
			if(datas.length>0){
				$("#items").hide().html("");
			}
			for(var i=0; i<datas.length; i++){
				//var item = "<li>"+datas[i]+"</li>";
				var item = datas[i];
				
				if(name){
					var reg = new RegExp(name,"gi");
					item = item.replace(reg, "<span class='same'>"+name+"</span>")
				}
				
				if(address){
					var reg = new RegExp(address,"gi");
					item = item.replace(reg, "<span class='same'>"+address+"</span>")
				}
				
				if(number){
					var reg = new RegExp(number,"gi");
					item = item.replace(reg, "<span class='same'>"+number+"</span>")
				}
				
				var $item = $("<li>"+item+"</li>");
				$("#items").append($item);
				
			}
			$("#items").show("slow");
			*/
		}
	);
	
});














