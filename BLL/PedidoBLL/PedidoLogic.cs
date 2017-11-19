using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;
using DAL.PedidoDAL;

namespace BLL.PedidoBLL
{
    public class PedidoLogic
    {
        PedidoRepo pedidoRepo;

        public IEnumerable<Pedido> getAll()
        { 

            pedidoRepo = new PedidoRepo();

            return pedidoRepo.GetAll();
        }

        public Pedido getById(int id)
        {
            pedidoRepo = new PedidoRepo();

            Pedido detalle = pedidoRepo.GetById(id);

            if (detalle == null)
                throw new Exception("No existe pedido");

            return detalle;
        }

        public Pedido add(Pedido pedido)
        {
            pedidoRepo = new PedidoRepo();

            Pedido pedidoN = new Pedido();
            pedidoN.estatus = pedido.estatus;
            pedidoN.fechaRealRecoleccion = pedido.fechaRealRecoleccion;
            pedidoN.fechaRecoleccion = pedido.fechaRecoleccion;
            pedidoN.idUsuarioPeticion = pedido.idUsuarioPeticion;
            pedidoN.idUsuarioRecoleccion = pedido.idUsuarioRecoleccion;
            pedidoRepo.Add(pedidoN);

            return pedidoN;
        }

        public Pedido update(Pedido pedido)
        {
            pedidoRepo = new PedidoRepo();

            Pedido pedidoN = pedidoRepo.GetById(pedido.id);
            pedidoN.estatus = pedido.estatus;
            pedidoN.fechaRealRecoleccion = pedido.fechaRealRecoleccion;
            pedidoN.fechaRecoleccion = pedido.fechaRecoleccion;
            pedidoN.idUsuarioPeticion = pedido.idUsuarioPeticion;
            pedidoN.idUsuarioRecoleccion = pedido.idUsuarioRecoleccion;
            pedidoRepo.Update(pedidoN);

            return pedidoN;
        }

        public void delete(int id)
        {
            pedidoRepo = new PedidoRepo();

            Pedido pedido = pedidoRepo.GetById(id);
            pedidoRepo.Delete(pedido);
        }
    }
}
