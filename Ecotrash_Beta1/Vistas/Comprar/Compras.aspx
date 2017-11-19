<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Compras.aspx.cs" Inherits="Ecotrash_Beta1.Vistas.Comprar.Compras" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSS -->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
    <link rel="stylesheet" href="../Login/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../Login/assets/font-awesome/css/font-awesome.min.css">

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
<body style="background: #F9F8F8; font-size: 20px !important">
    <div class="row" style="width: 100%; height: 100%;">

        <div class="form-bottom" style="width: 100%; height: 100%;">
            <form role="form" action="" method="post" class="login-form" style="width: 100%; height: 100%; margin-top: 10%;">
                <div style="height: 10%;">
                    Pendientes <input type='button' style='position:absolute; left:60%;' class='btn btn- primary' onclick="hola();" value="Actualizar"/>
                </div>
                <div class="form-group" style="height: 15%; margin-top: 5%;">
                    <ul class="list-group" id="lst">
                    </ul>
                </div>
            </form>
        </div>
    </div>

    <script>

        $(document).ready(function load() {
            fillList();
        });

        function hola() {
            fillList();
        }
        function fillList() {
            $.ajax({
                type: "POST",
                url: 'Compras.aspx/GetTipoProductos',
                dataType: "json",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                success: function (response) {
                    var listTipos = JSON.parse(response.d);
                    var items = '';
                    $.each(listTipos, function (index, item) {
                        items += '<li class="list-group-item ">' + item + " <input type='button' style='position:absolute; left:50%;' onclick='abrirModal("+ item.split(" -", 1) + ")' id='btn' class='btn btn- primary' value='Confirmar pedido'/>  " + '</li>';
                    });
                    document.getElementById('lst').innerHTML = items;
                }
            });
        }

        function abrirModal(id) {
            $.ajax({
                type: "POST",
                url: 'Compras.aspx/Actualizar',
                dataType: "json",
                data: '{id:'+id+'}',
                contentType: "application/json; charset=utf-8",
                success: function (response) {
                    window.open('confirmacionPedido.aspx?idPedido=' + id, '_self');
                }
            });
        }

    </script>
</body>
</html>
