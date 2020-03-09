<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/top" />

<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=n2rwg8ji5r&amp;submodules=geocoder"></script>

<!--자바스크립트 / CSS-->
<link href="asset/css/style.css" rel="stylesheet">

<style type="text/css">
#startPointInfo {
	height: 60px;
	font-size: 0.5em;
}

#endPointInfo {
	height: 60px;
	font-size: 0.5em;
}
</style>

<!-- ===== wrap ====== -->
<div id="container">
	<div id="wrap" class="section">
		<!-- map 검색 -->
		<div id="map" style="width: 100%; height: 1080px;"></div>
		<div id="map_search">
			<a class="logo" href="index.html"> <img
				src="asset/images/RUN_LOGO.png"></a> <img
				src="asset/images/hangang_kor.png">
			<p class="sub">마이 라이딩</p>
			<div class="search-bar">
				<input type="search" id="searchingPlace" placeholder="장소 검색"
					value="당산역" /> <input id="map_submit" class="icon" type="image"
					src="asset/images/search.png" value="" />
			</div>
		</div>
		<div id="map_check">
			<table>
				<tr>
					<td><span id="startPointInfo" class="departure">출발지</span></td>
					<td>
						<button id="startPoint" type="button" onclick="registerPoint1()"
							class="mappick">
							<img src="asset/images/mappick.png" alt="chooseAdress">
						</button>
					</td>
				</tr>
				<tr>
					<td><span id="endPointInfo" class="arrival">도착지</span></td>
					<td>
						<button id="endPoint" type="button" onclick="registerPoint2()"
							class="mappick">
							<img src="asset/images/mappick.png" alt="chooseAdress">
						</button>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;"><input id="searchRoot"
						submit="findDirection" type="button" value="경로 찾기" /></td>
					<td style="text-align: center;"><input id="registerRoot"
						submit="registerRoot" type="button" value="경로 추가" /></td>
				</tr>
			</table>
		</div>
	</div>

	<!-- 1지점 등록관련 form start--------------------------------------------------- -->
	<form name="point1" id="point1" method="POST" action="registerPlace">
		<input type="text" name="title" id="title"> <input type="text"
			name="latitude" id="latitude"> <input type="text"
			name="longitude" id="longitude"> <input type="text"
			name="road_address" id="road_address"> <input type="text"
			name="jibun_address" id="jibun_address">
	</form>
	<!-- ----------------------------------------------------------------------- -->
	<!-- 2지점 등록관련 form start--------------------------------------------------- -->
	<form name="point2" id="point2" method="POST" action="registerPlace">
		<input type="text" name="title" id="title2"> <input
			type="text" name="latitude" id="latitude2"> <input
			type="text" name="longitude" id="longitude2"> <input
			type="text" name="road_address" id="road_address2"> <input
			type="text" name="jibun_address" id="jibun_address2">
	</form>
	<!-- ----------------------------------------------------------------------- -->
</div>

<!-- ===== /indexwrap ====== -->
<script id="code">
	var registerPoint1 = function() {
		$('#title').val(selectedPoints[0].title);
		$('#latitude').val(selectedPoints[0].y);
		$('#longitude').val(selectedPoints[0].x);
		$('#road_address').val(selectedPoints[0].road);
		$('#jibun_address').val(selectedPoints[0].jibun);
		var params = $('#point1').serialize();
		alert(params);
		$.ajax({
			type : 'POST',
			data : params,
			url : 'registerPlace',
			dataType : 'text',
			cache : false,
			success : function(res) {
				alert(res);
				// 등록버튼 변경
				// 등록버튼 비활성화
			},
			error : function(err) {
				alert(err.status)
			}
		})
	}//registerPoint1------------------

	var registerPoint2 = function() {
		alert(selectedPoints[1].title);
		$('#title2').val(selectedPoints[1].title);
		$('#latitude2').val(selectedPoints[1].y);
		$('#longitude2').val(selectedPoints[1].x);
		$('#road_address2').val(selectedPoints[1].road);
		$('#jibun_address2').val(selectedPoints[1].jibun);
		//point2.submit();
		var params = $('#point2').serialize();
		alert(params);
		$.ajax({
			type : 'POST',
			data : params,
			url : 'registerPlace',
			dataType : 'text',
			cache : false,
			success : function(res) {
				alert(res);
				// 등록버튼 변경
				// 등록버튼 비활성화
			},
			error : function(err) {
				alert(err.status)
			}
		})
	}//registerPoint2------------------

	var selectPoints = 0;
	var selectedPoints = [];
	var selectedMarkers = [];
	var bicycleLayer = new naver.maps.BicycleLayer();
	var mapCenter = new naver.maps.LatLng(37.5349277, 126.9027279);

	function setMapCenter(center) {
		mapCenter = center;
	}

	var mapOptions = {
		center : mapCenter,
		mapTypeControl : true,
		mapTypeControlOptions : {
			style : naver.maps.MapTypeControlStyle.BUTTON,
			position : naver.maps.Position.TOP_RIGHT
		},
		zoomControl : true,
		zoomControlOptions : {
			style : naver.maps.ZoomControlStyle.LARGE,
			position : naver.maps.Position.RIGHT_CENTER
		},
		scaleControl : true,
		scaleControlOptions : {
			position : naver.maps.Position.BOTTOM_LEFT
		},
		logoControl : true,
		logoControlOptions : {
			position : naver.maps.Position.TOP_LEFT
		},
		mapDataControl : true,
		mapDataControlOptions : {
			position : naver.maps.Position.BOTTOM_LEFT
		},
	};

	var map = new naver.maps.Map(document.getElementById('map'), mapOptions);

	var infoWindow = new naver.maps.InfoWindow({
		backgroundColor : "#eee",
		borderColor : "#2db400",
		borderWidth : 5,
		anchorSize : new naver.maps.Size(30, 30),
		anchorSkew : true,
		anchorColor : "#eee",
		pixelOffset : new naver.maps.Point(20, -20)
	});

	map.setCursor('pointer');

	function searchCoordinateToAddress(latlng) {

		infoWindow.close();

		naver.maps.Service
				.reverseGeocode(
						{
							coords : latlng,
							orders : [ naver.maps.Service.OrderType.ADDR,
									naver.maps.Service.OrderType.ROAD_ADDR ]
									.join(',')
						},
						function(status, response) {
							if (status === naver.maps.Service.Status.ERROR) {
								return alert('Something Wrong!');
							}

							var items = response.v2.results, address = '', htmlAddresses = [];
							var markerInfo = {
								title : "",
								x : "",
								y : "",
								road : "",
								jibun : ""
							};
							markerInfo.title = "클릭한 지점";
							markerInfo.x = latlng.x;
							markerInfo.y = latlng.y;

							for (var i = 0, ii = items.length, item, addrType; i < ii; i++) {
								item = items[i];
								address = makeAddress(item) || '';
								addrType = item.name === 'roadaddr' ? '[도로명 주소]'
										: '[지번 주소]';

								htmlAddresses.push((i + 1) + '. ' + addrType
										+ ' ' + address);

								if (addrType == '[도로명 주소]') {
									markerInfo.road = address;
								} else {
									markerInfo.jibun = address;
								}
							}

							markerInfos.push(markerInfo);
							viewMarkers();

							infoWindow
									.setContent([
											'<div style="padding:10px;min-width:200px;line-height:150%;">',
											'<h4 style="margin-top:5px;">검색 좌표</h4><br />',
											latlng, '<br>', latlng.x, ",",
											latlng.y, '<br>',
											htmlAddresses.join('<br />'),
											'</div>' ].join('\n'));

							infoWindow.open(map, latlng);
						});
	}

	function makeAddress(item) {
		if (!item) {
			return;
		}

		var name = item.name, region = item.region, land = item.land, isRoadAddress = name === 'roadaddr';

		var sido = '', sigugun = '', dongmyun = '', ri = '', rest = '';

		if (hasArea(region.area1)) {
			sido = region.area1.name;
		}

		if (hasArea(region.area2)) {
			sigugun = region.area2.name;
		}

		if (hasArea(region.area3)) {
			dongmyun = region.area3.name;
		}

		if (hasArea(region.area4)) {
			ri = region.area4.name;
		}

		if (land) {
			if (hasData(land.number1)) {
				if (hasData(land.type) && land.type === '2') {
					rest += '산';
				}

				rest += land.number1;

				if (hasData(land.number2)) {
					rest += ('-' + land.number2);
				}
			}

			if (isRoadAddress === true) {
				if (checkLastString(dongmyun, '면')) {
					ri = land.name;
				} else {
					dongmyun = land.name;
					ri = '';
				}

				if (hasAddition(land.addition0)) {
					rest += ' ' + land.addition0.value;
				}
			}
		}

		return [ sido, sigugun, dongmyun, ri, rest ].join(' ');
	}

	function hasArea(area) {
		return !!(area && area.name && area.name !== '');
	}

	function hasData(data) {
		return !!(data && data !== '');
	}

	function checkLastString(word, lastString) {
		return new RegExp(lastString + '$').test(word);
	}

	function hasAddition(addition) {
		return !!(addition && addition.value);
	}

	function initGeocoder() {

		map.addListener('click', function(e) {
			searchCoordinateToAddress(e.coord);
		});

		$('#searchingPlace').on('keydown', function(e) {
			var keyCode = e.which;

			if (keyCode === 13) { // Enter Key
				searchingPlace($('#searchingPlace').val());
			}
		});

		$('#map_submit').on('click', function(e) {
			e.preventDefault();
			searchingPlace($('#searchingPlace').val());
		});

		$('#searchRoot').on('click', function(e) {
			e.preventDefault();
			// 여기에  경로찾기(direction API) function call
			findDirection();
		});

		bicycleLayer.setMap(map);
	}

	function findDirection() {
		if (selectPoints < 2) {
			alert("먼저 출발지점과 도착지점을 설정하세요.")
			return;
		} else {
			$.ajax({
				type : 'POST',
				url : './Directions',
				data : {
					startx : selectedPoints[0].x,
					starty : selectedPoints[0].y,
					endx : selectedPoints[1].x,
					endy : selectedPoints[1].y,
				},
				dataType : 'text', //응답유형 xml
				cashe : 'false',
				success : function(res) {
					viewDirection(res);
				},
				error : function(e) {
					alert('error: ' + e.status);
				}
			})
		}
	}

	function searchingPlace(place) {
		var center = map.getCenter();
		setMapCenter(center);
		$.ajax({
			type : 'POST',
			url : './SearchPlaces',
			data : {
				place : place,
				lng : mapCenter.x,
				lat : mapCenter.y
			},
			dataType : 'json', //응답유형 text
			cashe : 'false',
			success : function(res) {
				makePlaceMatrix(res.places);
				viewMarkers();
			},
			error : function(e) {
				alert('error: ' + e.status);
			}
		})
	}

	var bounds = map.getBounds(), southWest = bounds.getSW(), northEast = bounds
			.getNE(), lngSpan = northEast.lng() - southWest.lng(), latSpan = northEast
			.lat()
			- southWest.lat();

	var markers = [];
	var latlngs = [];
	//var directions = [];
	var distance;
	var markerInfos = [];

	function viewDirection(distance) {
		$.ajax({
			url : 'gpx/test.gpx',
			dataType : 'xml',
			success : startDataLayer,
			error : function(e) {
				alert('error: ' + e.status);
			}
		});
	}

	function startDataLayer(xmlDoc) {
		map.data.addGpx(xmlDoc);
		map.data.setStyle(function(feature) {
			var color = 'red';

			if (feature.getProperty('isColorful')) {
				color = feature.getProperty('color');
			}

			return {
				strokeColor : color,
				strokeWeight : 4,
				icon : null
			};
		});
	}

	function makePlaceMatrix(resPlaces) {
		// markerInfos 비우기
		while (markerInfos.length > 0) {
			markerInfos.shift();
		}
		$.each(resPlaces, function(i, place) {
			var markerInfo = {
				title : "",
				x : "",
				y : "",
				road : "",
				jibun : ""
			};
			markerInfo.title = place.name;
			markerInfo.x = place.x;
			markerInfo.y = place.y;
			markerInfo.road = place.road_address;
			markerInfo.jibun = place.jibun_address;
			markerInfos.push(markerInfo);
		})
	}

	function viewMarkers() {
		infoWindow.close();
		// markerInfos 비우기
		while (markers.length > 0) {
			markers[0].setMap(null);
			markers.shift();
		}
		for (var i = 0, ii = markerInfos.length; i < ii; i++) {
			// console.log(latlngs[i]);
			var icon = {
				url : 'asset/images/sp_pins_spot_v3.png',
				size : new naver.maps.Size(24, 37),
				anchor : new naver.maps.Point(12, 37),
				origin : new naver.maps.Point(i * 29, 0)
			}, marker = new naver.maps.Marker({
				position : new naver.maps.LatLng(markerInfos[i].y,
						markerInfos[i].x),
				title : markerInfos[i].toString(),
				map : map,
				icon : icon
			});

			marker.set('seq', i);
			markers.push(marker);

			marker.addListener('mouseover', onMouseOver);
			marker.addListener('mouseout', onMouseOut);
			marker.addListener('click', clickMouse);

			icon = null;
			marker = null;
		}
		setMapCenter(markers[0].position);
		map.setCenter(mapCenter);
	}

	function displayPointInfo(latlng, title, coordinate, road, jibun) {
		infoWindow.close();
		infoWindow.setContent([
				'<div style="padding:10px;min-width:200px;line-height:150%;">',
				'<h3 style="text-align:center;" >:: 장소 정보::</h3>', '명칭:',
				title, '<br>', coordinate, '<br>', road, '<br>', jibun, '<br>',
				'</div>' ].join('\n'));
		infoWindow.open(map, latlng);
	}

	function showPoints(place, number) {
		var str = place.title + "<br>";
		if (place.road != null)
			str += place.road + "<br>";
		if (place.jibun != null)
			str += place.jibun;
		if (number == 1) {
			$('#startPointInfo').empty();//비워주기
			$('#startPointInfo').html(str);
		} else {
			$('#endPointInfo').empty();//비워주기
			$('#endPointInfo').html(str);
		}
	}//------------------------------

	function clickMouse(e) {
		var marker = e.overlay, seq = marker.get('seq');
		var url = null;
		if (selectPoints == 0) {
			url = 'asset/images/start.png';
		} else if (selectPoints == 1) {
			url = 'asset/images/finish.png';
		}
		marker.setIcon({
			url : url,
			size : new naver.maps.Size(32, 20),
			origin : new naver.maps.Point(0, 0)
		});

		selectedMarkers[selectPoints] = seq;
		selectPoints++;
		if (selectPoints > 2) {
			selectedPoints.pop();
			selectPoints = 2;
		}
		/* alert(seq + " 마커 클릭\n" + markerInfos[seq].title + "\n"
		      + markerInfos[seq].x + "\n" + markerInfos[seq].y + "\n"
		      + markerInfos[seq].road + "\n" + markerInfos[seq].jibun); */
		selectedPoints.push(markerInfos[seq]);
		showPoints(selectedPoints[selectPoints - 1], selectPoints);
	}

	function onMouseOver(e) {
		var marker = e.overlay, seq = marker.get('seq');
		for (var i = 0; i < selectedMarkers.length; i++) {
			if (selectedMarkers[i] == seq)
				return;
		}

		marker.setIcon({
			url : 'asset/images/sp_pins_spot_v3_over.png',
			size : new naver.maps.Size(24, 37),
			anchor : new naver.maps.Point(12, 37),
			origin : new naver.maps.Point(seq * 29, 50)
		});
		var title = markerInfos[seq].title;
		var coordinate = "경도: " + markerInfos[seq].x + ", " + "위도: "
				+ markerInfos[seq].y;
		var road = markerInfos[seq].road;
		var jibun = markerInfos[seq].jibun;
		displayPointInfo(markers[seq].position, title, coordinate, road, jibun);
	}

	function onMouseOut(e) {
		var marker = e.overlay, seq = marker.get('seq');
		for (var i = 0; i < selectedMarkers.length; i++) {
			if (selectedMarkers[i] == seq)
				return;
		}

		marker.setIcon({
			url : 'asset/images/sp_pins_spot_v3.png',
			size : new naver.maps.Size(24, 37),
			anchor : new naver.maps.Point(12, 37),
			origin : new naver.maps.Point(seq * 29, 0)
		});
		infoWindow.close();
	}

	naver.maps.Event.addListener(map, 'idle', function() {
		updateMarkers(map, markers);
	});

	function updateMarkers(map, markers) {

		var mapBounds = map.getBounds();
		var marker, position;

		for (var i = 0; i < markers.length; i++) {

			marker = markers[i]
			position = marker.getPosition();

			if (mapBounds.hasLatLng(position)) {
				showMarker(map, marker);
			} else {
				hideMarker(map, marker);
			}
		}
	}

	function showMarker(map, marker) {

		if (marker.getMap())
			return;
		marker.setMap(map);
	}

	function hideMarker(map, marker) {

		if (!marker.getMap())
			return;
		marker.setMap(null);
	}

	naver.maps.onJSContentLoaded = initGeocoder;
</script>
