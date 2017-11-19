using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAL;
using BLL.PedidoBLL;
using BLL.DetallePedidosBLL;
using Newtonsoft.Json;

namespace Ecotrash_Beta1.Vistas.Comprar
{
    public partial class Compras : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string GetTipoProductos()
        {
            PedidoLogic tp = new PedidoLogic();
            List<Pedido> list = tp.getAll().ToList();
            DetallePedidoLogic dp = new DetallePedidoLogic();
            List<DetallePedido> list2 = dp.getAll().ToList();

            var x = from y in list
                    join y2 in list2 on y.id equals y2.idPedido
                    where y.estatus == "P"
                    select y.id + " - " + y2.Producto.descripcion + "<br/>" + Convert.ToDateTime(y.fechaRealRecoleccion.ToString()).ToShortDateString();

            return JsonConvert.SerializeObject(x);
        }

        [WebMethod]
        public static void Actualizar(int id)
        {
            PedidoLogic tp = new PedidoLogic();
            Pedido p = tp.getById(id);
            p.estatus = "C";
            p.idUsuarioRecoleccion = Ecotrash_Beta1.Session.user.id;
            tp.update(p);

        }
    }
}