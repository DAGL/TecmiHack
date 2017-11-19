using BLL.PedidoBLL;
using DAL;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ecotrash_Beta1.Vistas.Comprar
{
    public partial class confirmacionPedido : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string GetPedido(int id)
        {
            PedidoLogic tp = new PedidoLogic();
            Pedido pedido = tp.getById(id);

            Pedido nPedido = new Pedido();
            nPedido.Usuario = new Usuario();
            nPedido.Usuario.direccion = pedido.Usuario.direccion;
            return JsonConvert.SerializeObject(nPedido);
        }

        [WebMethod]
        public static string ActualizaLlegada(string id)
        {
            PedidoLogic pedidoLogic = new PedidoLogic();
            Pedido record = pedidoLogic.getById(int.Parse(id));
            record.estatus = "L";
            pedidoLogic.update(record);
            return id;
        }
    }
}