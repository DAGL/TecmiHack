<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetallesVenta.aspx.cs" Inherits="Ecotrash_Beta1.Vistas.Vender.DetallesVenta" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSS -->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500" />
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
    </style>

    <!-- Javascript -->
    <script src="../Login/assets/js/jquery-1.11.1.min.js"></script>
    <script src="../Login/assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="../Login/assets/js/jquery.backstretch.min.js"></script>
    <script src="../Login/assets/js/scripts.js"></script>
</head>
<body>
    <div id="wait">
        <label>Esperando Confirmación...</label>
    </div>
    <div id="data" style="display: none;">
        <fieldset>
            <legend>Datos del Recolector</legend>
        </fieldset>
        <div class="row col-md-6">
            <label style="font-size: 15px;">Responsable:</label>
            <input style="right:80%;" class="form-control" id="txtResponsable" type="text" disabled="disabled" />
        </div>
        <div class="row col-md-6">
            <label style="font-size: 15px;">Modelo:</label>
            <input id="txtModelo" class="form-control" type="text" disabled="disabled" />
        </div>
        <div class="row col-md-6">
            <label style="font-size: 15px;">Placas:</label>
            <input id="txtPlacas" class="form-control" type="text" disabled="disabled" />
        </div>
        <div>
            <button id="btn4" class="btn btn-danger" style="width:100%; position:fixed; bottom:10%;  font-size: 20px !important; border: 1px #98bc89 solid;" onclick="window.open('../Menu/Menu.aspx', '_self');">
                Cancelar
            </button>
        </div>
    </div>
    <script>
        $(document).ready(function load() {
            verficiaEstatus();
        });

        function verficiaEstatus() {
            pedidoID = getParameterByName('pedidoId');
            $.ajax({
                type: "POST",
                url: 'DetallesVenta.aspx/VerificaEstatus',
                dataType: "json",
                data: '{"id": "' + pedidoID + '"}',
                contentType: "application/json; charset=utf-8",
                success: function (response) {
                    if (response.d == "C") {
                        CargarDatos();
                    } if (response.d == "L") {
                        document.getElementById('btn4').Value = 'Cerrar';
                        return;
                    } else {
                        setTimeout(verficiaEstatus(), 2000);
                    }
                }
            });
        }

        function CargarDatos() {
            pedidoID = getParameterByName('pedidoId');
            document.getElementById("wait").style.display = 'none';
            document.getElementById("data").style.display = 'inline';
            $.ajax({
                type: "POST",
                url: 'DetallesVenta.aspx/ConsultarDatos',
                dataType: "json",
                data: '{"id": "' + pedidoID + '"}',
                contentType: "application/json; charset=utf-8",
                success: function (response) {
                    var Info = JSON.parse(response.d);
                    document.getElementById('txtResponsable').value = Info.nombre;
                    document.getElementById('txtModelo').value = Info.modelo;
                    document.getElementById('txtPlacas').value = Info.placas;
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
    </script>
</body>
</html>
