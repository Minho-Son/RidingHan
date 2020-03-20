<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="/top" />

<script type="text/javascript"
   src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=n2rwg8ji5r&amp;submodules=geocoder"></script>

<div><br></div>
<div class="container">
   <div class="row">
      <div class="col-md-12 col-md-offset-0 table-responsive">
         <h1 class="text-primary text-center">등록 장소 목록</h1>
         <table class="table table-striped">
            <tr class="success">
               <th>번호</th>
               <th>장소이름</th>
               <th>위도</th>
               <th>경도</th>
               <th>도로명주소</th>
               <th>지번주소</th>
            </tr>
            <!-- --------------------------- -->
            <c:forEach var="place" items="${placeArr}">
               <tr>
                  <td>${place.place_no}</td>
                  <td>${place.title}</td>
                  <td>
                     <fmt:formatNumber value="${place.latitude}" pattern="###.#####"/>
                  </td>
                  <td>
                     <fmt:formatNumber value="${place.longitude}" pattern="###.#####"/>
                  </td>
                  <td>${place.road_address}</td>
                  <td>${place.jibun_address}</td>
                  <td>
                     <!-- href속성값에 자바스크립트 함수를 넣을 때는 반드시 함수 앞에 "javascript:" 접두어를 붙여주자 -->
                     <a href="javascript:select('${place.place_no}')">선택</a>
                  </td>
               </tr>
            </c:forEach>
            <!-- --------------------------- -->
            <tr>
               <td></td>
               <td></td>
               <td colspan="2" class="text-center">${pageNavi}</td>
               <td colspan="2" class="text-right">
                  총 등록 장소수 : <b>${totalCount} 개</b>
               </td>
            </tr>
         </table>
      </div>
   </div>

   <!-- 등록할 장소 처리시 사용할 form -->
   <form name="frm" method="post">
      <input type="hidden" name="place_no">
      <!-- hidden data -->
   </form>

   <div id="wrap" class="section">
      <!-- map 검색 -->
      <div id="map" style="width: 100%; height: 600px;"></div>
      <div id="map_search">
         <a class="logo" href="index.html"> <img
            src="asset/images/RUN_LOGO.png"></a> <img
            src="asset/images/hangang_kor.png">
         <p class="sub">마이 라이딩</p>
      </div>
      <div id="map_check">
         <table>
            <tr>
               <td><span id="myPlace" class="myPlace">내 지점</span></td>
               <td>
                  <button id="myPoint" type="button" onclick="placeNearbyMap()"
                     class="mappick">
                  </button>
               </td>
            </tr>
            <tr>
               <td><span id="placeInfo" class="placeInfo">선정 지점</span></td>
            </tr>
            <tr>
               <td style="text-align: center;"><input id="selectPoint"
                  submit="selectPoint" type="button" value="선택확인" /></td>
            </tr>
         </table>
      </div>
   </div>

   <!-- 장서 선택 관련 form start--------------------------------------------------- -->
   <form name="place" id="place" method="POST" action="selectPlace">
      <input type="hidden" name="title" id="title">
      <input type="hidden" name="latitude" id="latitude"> 
      <input type="hidden" name="longitude" id="longitude">
      <input type="hidden" name="road_address" id="road_address">
      <input type="hidden" name="jibun_address" id="jibun_address">
   </form>
   <!-- ----------------------------------------------------------------------- -->
</div>


<script>
   function select(place_no) {
      //정말 선택하시겠습니까 물어보기
      var yn = confirm(place_no + "번 장소를 선택하시 겠습니까?");
      //frm폼의 place_no value값으로 place_no값을 넣어주자.
      if (yn) {
         frm.place_no.value = place_no;
         frm.action = "selectPlace";
         frm.method = 'post';
         frm.submit();
      }
   }
   
   var placeNearbyMap = function() {
      $('#latitude').val(latitude);
      $('#longitude').val(longitude);
      var params = $('#myLocation').serialize();
      alert(params);
      $.ajax({
         type : 'POST',
         data : params,
         url : 'placeNearbyMap',
         dataType : 'json',
         cache : false,
         success : function(res) {
            alert(res);
            makePlaceMatrix(res);
            // 등록버튼 변경
            // 등록버튼 비활성화
         },
         error : function(err) {
            alert(err.status)
         }
      })
   }

   
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
         position : naver.maps.Position.TOP_RIGHT
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
      
      bicycleLayer.setMap(map);
   }

   var bounds = map.getBounds(), southWest = bounds.getSW(), northEast = bounds
         .getNE(), lngSpan = northEast.lng() - southWest.lng(), latSpan = northEast
         .lat()
         - southWest.lat();

   var markers = [];
   var markerInfos = [];

   function makePlaceMatrix(resPlaces) {
      alert("resPlaces : "+resPlaces);
      $.each(resPlaces, function(i, place) {
         var markerInfo = {
            title : "",
            x : "",
            y : "",
            road : "",
            jibun : ""
         };
         markerInfo.title = place.name;
         markerInfo.x = place.longitude;
         markerInfo.y = place.latitude;
         markerInfo.road = place.road_address;
         markerInfo.jibun = place.jibun_address;
         markerInfos.push(markerInfo);
      })
   }

   function viewMarkers() {
      infoWindow.close();
      // markers 비우기
      while (markers.length > 0) {
         markers[0].setMap(null);
         markers.shift();
      }
      for (var i = 0, ii = markerInfos.length; i < ii; i++) {
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
         marker.addListener('mousedown', clickMouse);

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

   function showPoints(place) {
      var str = place.title + "<br>";
      if (place.road != null)
         str += place.road + "<br>";
      if (place.jibun != null)
         str += place.jibun;
      $('#placeInfo').empty();//비워주기
      $('#placeInfo').html(str);
   }//------------------------------

   function clickMouse(e) {
      var marker = e.overlay, seq = marker.get('seq');
      marker.setIcon({
         url : 'asset/images/start.png',
         size : new naver.maps.Size(32, 20),
         origin : new naver.maps.Point(0, 0)
      });
      showPoints(markerInfos[seq]);
   }

   function onMouseOver(e) {
      var marker = e.overlay, seq = marker.get('seq');
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

<c:import url="/foot" />

