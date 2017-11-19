<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Vistas.aspx.cs" Inherits="Ecotrash_Beta1.Vistas.Menu.Menu" %>

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

            /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 200px;
      }
      /* Optional: Makes the sample page fill the window. */
 
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
</head>
<body style="background: #F9F8F8; font-size: 20px !important">
    <fieldset class="container" style="margin-top: 10px;">
        <legend style="font-size: 15px; font-weight: bold;">Producto a Vender</legend>
        <div class="row">
            <label  style="font-size: 15px; margin-left: 17px;">Descripción:</label>
        </div>
        <div class="row">
            <input id="txtDescripcion" class="form-control" type="text" placeholder="Descripción" style="margin-left: 15px; width: 90%; height: 30px;" />
        </div>
        <div class="row">
            <div style="float: left; width: 60%;">
                <label style="font-size: 15px; margin-left: 17px;">Tipo de Producto:</label>
                <select id="ddlTipoProducto" class="form-control" style="margin-left: 15px; width: 95%; height: 30px;" onchange="selectTipoProducto(this)"></select>
            </div>
            <div style="float: right; width: 40%;">
                <label style="font-size: 15px; margin-left: 17px;">Tarifa x Kg.</label>
                <input id="txtTarifa" type="text" disabled="disabled" class="form-control" style="margin-left: 15px; width: 75%; height: 30px;" />
            </div>
        </div>
        <div class="row">
            <button class="form-control" onclick="addProducto()" style="margin-top: 10px; margin-left: 15px; width: 90%; height: 30px;">Agregar</button>
        </div>
    </fieldset>
    <fieldset class="container" style="height: 30%; padding: 10px 10px 10px 10px; margin-top: 20px; overflow-x: hidden; overflow-y: hidden;">
        <legend style="font-size: 15px; font-weight: bold;">Lista de Venta</legend>
        <div style="height:100%;width:100%;overflow-x:hidden;overflow-y:auto;">
            <ul id="lstVentas" class="list-group">
            </ul>
        </div>

    </fieldset>
    <div class="container">
        <div class="row">
            <label style="font-size: 15px; margin-left: 17px;">Dirección:</label>
            <input id="pac-input" class="controls" type="text" placeholder="Search Box" />
    <div><div id="map" style="z-index: -1;margin-bottom:60px;"></div></div>
        </div>
        
        <div class="row">
            <button onclick="confirmar()" class="btn-danger" style="position:fixed;bottom:0;width:100%;">Confirmar</button>
        </div>
    </div>
    <script>

        $(document).ready(function load() {
            clearData();
        });

        function clearData() {
            $.ajax({
                type: "POST",
                url: 'Vistas.aspx/ClearData',
                dataType: "json",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                success: function () {
                    fillDdlTipoProductos();
                }
            });
        }

        function selectTipoProducto(component) {
            document.getElementById('txtTarifa').value = '$ ' + component.value.split('-')[1];
        }

        function fillDdlTipoProductos() {
            $.ajax({
                type: "POST",
                url: 'Vistas.aspx/GetTipoProductos',
                dataType: "json",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                success: function (response) {
                    var listTipos = JSON.parse(response.d);
                    var items = '';
                    $.each(listTipos, function (index, item) {
                        items += '<option value=' + item.id + '-' + item.tarifa + '>' + item.descripcion + '</option>';
                    });
                    document.getElementById('ddlTipoProducto').innerHTML = items;
                    document.getElementById('txtTarifa').value = '$ ' + listTipos[0].tarifa;
                }
            });
        }

        function addProducto() {
            if (document.getElementById('txtDescripcion').value.trim() == '') {
                alert('Completar el llenado de los campos.');
                return;
            }

            var tipo = document.getElementById('ddlTipoProducto').value.split('-')[0];
            var descripcion = document.getElementById('txtDescripcion').value;
            $.ajax({
                type: "POST",
                url: 'Vistas.aspx/AddItem',
                dataType: "json",
                data: '{"tipo":"' + tipo + '", "descripcion":"' + descripcion + '" }',
                contentType: "application/json; charset=utf-8",
                success: function (response) {
                    document.getElementById('txtDescripcion').value = "";
                    var listVenta = JSON.parse(response.d);
                    var items = "";
                    $.each(listVenta, function (index, item) {
                        items += "<li id=" + item.id + " class='list-group-item'>" + item.descripcion + "<a onclick='removeItem(" + item.id + ")'><span style='float:right;margin-top:5px;' class='glyphicon glyphicon-remove'></span></a></li>";
                    });
                    document.getElementById('lstVentas').innerHTML = items;
                }
            });
        }

        function removeItem(id) {
            $.ajax({
                type: "POST",
                url: 'Vistas.aspx/DeleteItem',
                dataType: "json",
                data: '{"id":"' + id + '"}',
                contentType: "application/json; charset=utf-8",
                success: function (response) {
                    document.getElementById('txtDescripcion').value = "";
                    var listVenta = JSON.parse(response.d);
                    var items = "";
                    $.each(listVenta, function (index, item) {
                        items += "<li id=" + item.id + " class='list-group-item'>" + item.descripcion + "<a onclick='removeItem(" + item.id + ")'><span style='float:right;margin-top:5px;' class='glyphicon glyphicon-remove'></span></a></li>";
                    });
                    document.getElementById('lstVentas').innerHTML = items;
                }
            });
        }

        function confirmar() {
            var direccion = document.getElementById('pac-input').value;
            if (confirm('¿Seguro de realizar el pedido?')) {
                $.ajax({
                    type: "POST",
                    url: 'Vistas.aspx/Confirmar',
                    dataType: "json",
                    data: '{"direccion":"' + direccion + '"}',
                    contentType: "application/json; charset=utf-8",
                    success: function (response) {
                        window.open('DetallesVenta.aspx?pedidoId=' + response.d, '_self');
                    }
                });
            }
        }
        function initAutocomplete() {
            var map = new google.maps.Map(document.getElementById('map'), {
                center: { lat: -33.8688, lng: 151.2195 },
                zoom: 13,
                mapTypeId: 'roadmap'
            });

            // Create the search box and link it to the UI element.
            var input = document.getElementById('pac-input');
            var searchBox = new google.maps.places.SearchBox(input);
            //map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

            // Bias the SearchBox results towards current map's viewport.
            map.addListener('bounds_changed', function () {
                searchBox.setBounds(map.getBounds());
            });

            var markers = [];
            // Listen for the event fired when the user selects a prediction and retrieve
            // more details for that place.
            searchBox.addListener('places_changed', function () {
                var places = searchBox.getPlaces();

                if (places.length == 0) {
                    return;
                }

                // Clear out the old markers.
                markers.forEach(function (marker) {
                    marker.setMap(null);
                });
                markers = [];

                // For each place, get the icon, name and location.
                var bounds = new google.maps.LatLngBounds();
                places.forEach(function (place) {
                    if (!place.geometry) {
                        console.log("Returned place contains no geometry");
                        return;
                    }
                    var icon = {
                        url: place.icon,
                        size: new google.maps.Size(71, 71),
                        origin: new google.maps.Point(0, 0),
                        anchor: new google.maps.Point(17, 34),
                        scaledSize: new google.maps.Size(25, 25)
                    };

                    // Create a marker for each place.
                    markers.push(new google.maps.Marker({
                        map: map,
                        icon: icon,
                        title: place.name,
                        position: place.geometry.location
                    }));

                    if (place.geometry.viewport) {
                        // Only geocodes have viewport.
                        bounds.union(place.geometry.viewport);
                    } else {
                        bounds.extend(place.geometry.location);
                    }
                });
                map.fitBounds(bounds);
            });
        }

    </script>
      <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBRLJvN9co-ZAw_fh9b8kbPj-lVDkHKXEk&libraries=places&callback=initAutocomplete" async defer></script>
   
</body>
</html>
