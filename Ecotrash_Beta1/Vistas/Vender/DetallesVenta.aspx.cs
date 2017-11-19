using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using DAL;
using BLL.PedidoBLL;

namespace Ecotrash_Beta1.Vistas.Vender
{
    public partial class DetallesVenta : System.Web.UI.Page
    {
        [WebMethod]
        public static string VerificaEstatus(string id)
        {
            PedidoLogic pedidoLogic = new PedidoLogic();
            string estaus = pedidoLogic.getById(int.Parse(id)).estatus;
            return estaus;
        }

        [WebMethod]
        public static string ConsultarDatos(string id)
        {
            PedidoLogic pedidoLogic = new PedidoLogic();
            Pedido pedido = pedidoLogic.getById(int.Parse(id));
            Choefer chof = new Choefer();
            chof.nombre = pedido.Usuario1.nombres + " " + pedido.Usuario1.apellidos;
            chof.modelo = "Camino";
            chof.placa = "12-12-12";
            return JsonConvert.SerializeObject(chof);
        }

        private class Choefer
        {
            public string nombre { get; set; }
            public string modelo { get; set; }
            public string placa { get; set; }
        }
    }
}