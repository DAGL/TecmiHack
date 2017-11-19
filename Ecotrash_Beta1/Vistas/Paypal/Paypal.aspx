<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Paypal.aspx.cs" Inherits="Ecotrash_Beta1.Vistas.Paypal.Paypal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://www.paypalobjects.com/js/external/dg.js" type="text/javascript"></script>
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
                Seleccionar metodo de pago
                <br />
                <div class="row">
                    <input id="txtPeso" class="form-control" type="text" placeholder="Peso" style="margin-left: 15px; width: 90%; height: 30px;" />
                </div>
                <label id="lbl"></label>
                <div style="height: 15%; margin-top: 0%;">
                    <button id="btn" onclick="calcular();" class="btn btn-success" style="width: 60%; font-size: 20px !important; border: 1px #98bc89 solid;">
                        Calcular
                    </button>
                </div>
            </div>
            <br />
            <div class="form-bottom" style="width: 100%; height: 100%;">
                <div style="height: 15%; margin-top: 0%;" id="Vender">
                    <label>
                        <input type="radio" name="optradio">Efectivo</label>
                </div>
                <div style="height: 15%; margin-top: 15%;" id="PedidosPendientes">
                    <label>
                        <input type="radio" disabled="disabled" name="optradio">Tarjeta</label>
                </div>
                <div style="height: 15%; margin-top: 15%;" id="PedidosRealizados">
                    <label>
                        <input type="radio" onclick="hola()" name="optradio">Paypal</label>
                    <form action="https://www.sandbox.paypal.com/webapps/adaptivepayment/flow/pay" style="margin-left: 15%;" visibility="false" target="PPDGFrame" class="standard">

                        <input type="image" id="submitBtn" value="Pay with PayPal" src="https://www.paypalobjects.com/en_US/i/btn/btn_paynowCC_LG.gif">
                        <input id="type" type="hidden" name="expType" value="light">
                        <input id="paykey" type="hidden" name="paykey" value="insert_pay_key">
                    </form>

                    <script type="text/javascript" charset="utf-8">
                        var embeddedPPFlow = new PAYPAL.apps.DGFlow({ trigger: 'submitBtn' });

                        function hola() {

                        }
                    </script>
                </div>
                <div style="height: 15%; margin-top: 0%;" id="Vender">
                    <button id="btn3" class="btn btn-success" onclick="salir()" style="width: 60%; font-size: 20px !important; position: fixed; bottom: 10%; border: 1px #98bc89 solid;">
                        Finalizar
                    </button>
                </div>

            </div>

        </div>
    </div>
    <script>

                        function salir() {
                            window.open('../Menu/Menu.aspx',"_self");
                        }

                        function calcular() {
                            var val = getParameterByName('tarifa');
                            val = val * document.getElementById("txtPeso").value;
                            document.getElementById("lbl").innerText = val;
                        }

                        function getParameterByName(name) {
                            name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
                            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                                results = regex.exec(location.search);
                            return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
                        }

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


