<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="confirmacionPedido.aspx.cs" Inherits="Ecotrash_Beta1.Vistas.Comprar.confirmacionPedido" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- CSS -->
    <link rel="stylesheet" href="../Login/assets/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="../Login/assets/font-awesome/css/font-awesome.min.css" />

    <style>
        body, html {
            width: 100%;
            height: 100%;
        }

        .form-box {
            margin-top: 35px;
        }


        .form-bottom form button.btn {
            width: 100%;
            height: 90%;
        }

        .form-group {
            width: 100%;
            height: 100%;
        }

        .form-bottom {
            padding-top: 15%;
            padding-right: 5%;
            padding-bottom: 15%;
            padding-left: 15%;
            background: #F9F8F8;
            width: 100%;
            height: 100%;
            -moz-border-radius: 0 0 4px 4px;
            -webkit-border-radius: 0 0 4px 4px;
            border-radius: 0 0 4px 4px;
            text-align: left;
        }

            .form-bottom form textarea {
                height: 100px;
            }

            .form-bottom form button.btn {
                width: 100%;
            }
                #map {
        height: 500px;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      .controls {
        margin-top: 10px;
        border: 1px solid transparent;
        border-radius: 2px 0 0 2px;
        box-sizing: border-box;
        -moz-box-sizing: border-box;
        height: 32px;
        outline: none;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
      }

      #pac-input {
        background-color: #fff;
        font-family: Roboto;
        font-size: 15px;
        font-weight: 300;
        margin-left: 12px;
        padding: 0 11px 0 13px;
        text-overflow: ellipsis;
        width: 300px;
      }

      #pac-input:focus {
        border-color: #4d90fe;
      }

      .pac-container {
        font-family: Roboto;
      }

      #type-selector {
        color: #fff;
        background-color: #4d90fe;
        padding: 5px 11px 0px 11px;
      }

      #type-selector label {
        font-family: Roboto;
        font-size: 13px;
        font-weight: 300;
      }
      #target {
        width: 345px;
      }
    </style>

    <!-- Javascript -->
    <script src="../Login/assets/js/jquery-1.11.1.min.js"></script>
    <script src="../Login/assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="../Login/assets/js/jquery.backstretch.min.js"></script>
    <script src="../Login/assets/js/scripts.js"></script>
        <script type="text/javascript" src="http://www.google.com/jsapi"></script>
</head>
<body style="background: #F9F8F8; font-size: 20px !important">
    <div class="container">
        <div class="row">
            <input type="text" id="start" style="display: none;" />
            <input type="text" id="end" style="display: none;" />
    <div><div id="map" style="z-index: -1;"></div></div>
        </div>
        
        <div class="row">
            <button class="btn-danger" style="position:fixed;bottom:10%;width:100%;" onclick="confirmar()">Llegada</button>
        </div>
    </div>
    <script>



        function getPedido() {
            $.ajax({
                type: "POST",
                url: 'confirmacionPedido.aspx/GetPedido',
                dataType: "json",
                data: '{"id": "' + getParameterByName('idPedido') + '"}',
                contentType: "application/json; charset=utf-8",
                success: function (response) {
                    var item = JSON.parse(response.d);
                        document.getElementById('end').value = item.Usuario.direccion;
                }
            });
        }

        function confirmar() {
            $.ajax({
                type: "POST",
                url: 'confirmacionPedido.aspx/ActualizaLlegada',
                dataType: "json",
                data: '{"id": "' + getParameterByName('idPedido') + '"}',
                contentType: "application/json; charset=utf-8",
                success: function (response) {
                    window.open("../PayPal/Paypal.aspx?tarifa=" + response.d, '_self');
                }
            });
        }

        /**
        * @param String name
        * @return String
        */
        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                results = regex.exec(location.search);
            return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }

        var map;
        var infoWindow;
        var address = '';

        function initMap() {
            var directionsService = new google.maps.DirectionsService;
            var directionsDisplay = new google.maps.DirectionsRenderer;
            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 15,
                center: { lat: 41.85, lng: -87.65 }
            });
            directionsDisplay.setMap(map);
            

            //document.getElementById('end').addEventListener('change', onChangeHandler);

            infoWindow = new google.maps.InfoWindow({ map: map });

            if (navigator.geolocation) {
                var geocoder = new google.maps.Geocoder();
                navigator.geolocation.watchPosition(function (position) {
                    var pos = {
                        lat: position.coords.latitude,
                        lng: position.coords.longitude
                    };

                    
                    infoWindow.setPosition(pos);
                    infoWindow.setContent('Camion en Ruta.');
                    initialize(pos);
                    var str = infoWindow.formatted_address;
                    map.setCenter(pos);

                    var latlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
                    geocoder.geocode({ 'latLng': latlng }, function (results, status) {
                        if (status == google.maps.GeocoderStatus.OK) {
                            document.getElementById('start').value = results[0]['formatted_address'];
                        };
                    });
                }, function () {
                    handleLocationError(true, infoWindow, map.getCenter());
                });
            } else {
                handleLocationError(false, infoWindow, map.getCenter());
            }
            getPedido();

            setTimeout(function set() {
                calculateAndDisplayRoute(directionsService, directionsDisplay);
            }, 2500);
        }

        function geocodePosition(pos) {
            var str = '';
            var geocoder = new google.maps.Geocoder();
            geocoder.geocode({
                latLng: pos
            }, function (responses) {
                if (responses && responses.length > 0) {
                    str = responses[0].formatted_address;
                } else {
                    updateMarkerAddress('Cannot determine address at this location.');
                }
            });

            return str;
        }

        function calculateAndDisplayRoute(directionsService, directionsDisplay) {
            directionsService.route({
                origin: document.getElementById('start').value,
                destination: document.getElementById('end').value,
                travelMode: 'DRIVING'
            }, function (response, status) {
                if (status === 'OK') {
                    directionsDisplay.setDirections(response);
                } else {
                    window.alert('Directions request failed due to ' + status);
                }
            });
        }

        function initialize(pos) {
            var loc = {};
            var geocoder = new google.maps.Geocoder();

            if (google.loader.ClientLocation) {
                //loc.lat = pos.lat;
                //loc.lng = pos.lng;

                var latlng = new google.maps.LatLng(loc.lat, loc.lng);
                geocoder.geocode({ 'latLng': latlng }, function (results, status) {
                    if (status == google.maps.GeocoderStatus.OK) {
                        //document.getElementById('start').value = results[0]['formatted_address'];
                    };
                });
            }



        }

        function handleLocationError(browserHasGeolocation, infoWindow, pos) {
            infoWindow.setPosition(pos);
            infoWindow.setContent(browserHasGeolocation ? 'Error: The Geolocation service failed.' : 'Error: Your browser doesn\'t support geolocation.');
        }
        </script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBRLJvN9co-ZAw_fh9b8kbPj-lVDkHKXEk&callback=initMap" async defer></script>
     
</body>
</html>
