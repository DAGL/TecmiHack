<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="Ecotrash_Beta1.Vistas.Menu.Menu" %>

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
            <div style="height: 15%;">
                <img src="logo.png" class="img-responsive" alt="" style="margin-left: auto; margin-right: auto;">
            </div>
            <div class="form-bottom" style="width:100%;height:100%;">
            <div style=" height: 15%; margin-top: 20%;" id="Vender">
                <button id="btn4"class="btn btn-default" style="width:100%; font-size: 20px !important; border: 1px #98bc89 solid;" onclick="openWindow('venta')">
                    <span style="right:5%; color: #98bc89;" class="glyphicon glyphicon-leaf"></span>
                    Vender
                </button>
            </div>
            <div style="height: 15%; margin-top: 15%;" id="PedidosPendientes">
                <button id="btn2" class="btn btn-default" style="width:100%; font-size: 20px !important; border: 1px #98bc89 solid;" onclick="openWindow('pedidosP')">
                    <span style="right:5%; color: #98bc89;" class="glyphicon glyphicon-leaf"></span>
                    Pedidos Pendientes
                </button>
            </div>
            <div style="height: 15%; margin-top: 15%;" id="PedidosRealizados">
                <button id="btn3" class="btn btn-default" style="width:100%; font-size: 20px !important; border: 1px #98bc89 solid;" onclick="openWindow('pedidosR')">
                    <span style="right:5%; color: #98bc89;" class="glyphicon glyphicon-leaf"></span>
                    Pedidos Realizados
                </button>
            </div>
                </div>
        </div>
    </div>
    <script>

        $(document).ready(function load() {
            accessValidate();
        });

        function openWindow(op) {
            switch (op) {
                case 'venta': window.open("../Vender/Vistas.aspx", "_self");
                    break;
                case 'pedidosP': window.open("../Comprar/Compras.aspx", "_self");
                    break;
                case 'pedidosR': window.open("../Menu/Menu.aspx", "_self");
                    break;

            }
        }

        function accessValidate() {
            $.ajax({
                type: "POST",
                url: 'Menu.aspx/GetTypeUser',
                dataType: "json",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                success: function (response) {
                    DesplegaMenu(response.d)
                }
            });
        }

        function DesplegaMenu(type) {
            if (type == 'C') {
                document.getElementById("PedidosRealizados").style.display = 'none';
                document.getElementById("PedidosPendientes").style.display = 'none';
            } else {
                document.getElementById("Vender").style.display = 'none';

            }
        }
    </script>
</body>
</html>
