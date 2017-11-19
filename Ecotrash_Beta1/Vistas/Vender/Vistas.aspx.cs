using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAL;
using BLL.TipoProductoBLL;
using BLL.DetallePedidosBLL;
using BLL.PedidoBLL;
using BLL.ProductoBLL;
using Newtonsoft.Json;
using BLL.UsuarioBLL;

namespace Ecotrash_Beta1.Vistas.Menu
{
    public partial class Menu : System.Web.UI.Page
    {

        static List<itemListVender> itemsList = new List<itemListVender>();

        [WebMethod]
        public static void ClearData()
        {
            itemsList.Clear();
        }


        [WebMethod]
        public static string AddItem(string tipo, string descripcion)
        {
            string response = "";
            int newId = 1;
            if(itemsList.Count > 1)
            {
                newId = (itemsList.Last().id + 1);
            }

            itemsList.Add(new itemListVender() { id = newId, tipoProductoId = int.Parse(tipo), descripcion = descripcion });
            response = JsonConvert.SerializeObject(itemsList);
            return response;

        }

        [WebMethod]
        public static string DeleteItem(string id)
        {
            itemsList.Remove(itemsList.Where(p => p.id == int.Parse(id)).FirstOrDefault());
            return JsonConvert.SerializeObject(itemsList);
        }

        [WebMethod]
        public static string GetTipoProductos()
        {
            TipoProductoLogic tiposProductosLogic = new TipoProductoLogic();
            List<TipoProducto> list = tiposProductosLogic.getAll().ToList();

            List<TipoProducto> tiposF = new List<TipoProducto>();

            foreach (TipoProducto item in list)
            {
                tiposF.Add(new TipoProducto() { id = item.id, descripcion = item.descripcion, tarifa = item.tarifa });
            }

            return JsonConvert.SerializeObject(tiposF);
        }

        [WebMethod]
        public static string Confirmar(string direccion)
        {
            PedidoLogic pedidosLogic = new PedidoLogic();
            DetallePedidoLogic detallesPedidosLogic = new DetallePedidoLogic();
            ProductoLogic productoLogic = new ProductoLogic();
            UsuarioLogic userLog = new UsuarioLogic();

            Pedido pedido = new Pedido();
            pedido.estatus = "P";
            pedido.fechaRecoleccion = DateTime.Now.Date;
            pedido.fechaRealRecoleccion = DateTime.Now.Date;
            pedido.idUsuarioPeticion = Ecotrash_Beta1.Session.user.id;
            Pedido responseRecord = pedidosLogic.add(pedido);
            foreach (itemListVender item in itemsList)
            {
                Producto producto = new Producto();
                producto.descripcion = item.descripcion;
                producto.tipoProducto = item.tipoProductoId;
                Producto responseProducto = productoLogic.add(producto);

                DetallePedido record = new DetallePedido();
                record.idPedido = responseRecord.id;
                record.idProducto = responseProducto.id;
                record.total = 0;
                record.cantidadKg = 0;
                detallesPedidosLogic.add(record);
            }

            Usuario user = userLog.GetById(Ecotrash_Beta1.Session.user.id);
            user.direccion = direccion;

            userLog.Update(user);
            return responseRecord.id.ToString();
        }

        private class itemListVender
        {
            public int id { get; set; }
            public int tipoProductoId { get; set; }
            public string descripcion { get; set; }
        }
    }
}