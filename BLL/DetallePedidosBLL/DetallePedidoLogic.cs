using DAL;
using DAL.DetallePedidosDAL;
using System;
using System.Collections.Generic;
using System.Text;

namespace BLL.DetallePedidosBLL
{
    public class DetallePedidoLogic 
    {
        private DetallePedidoRepo detallePedidoRepo;

        public DetallePedidoLogic()
        {
            
        }

        public IEnumerable<DetallePedido> getAll()
        {

            detallePedidoRepo = new DetallePedidoRepo();

            return detallePedidoRepo.GetAll();
        }

        public DetallePedido getById(int id)
        {
            detallePedidoRepo = new DetallePedidoRepo();

            DetallePedido detalle = detallePedidoRepo.GetById(id);

            if (detalle == null)
                throw new Exception("No existe detalle");

            return detalle;
        }

        public DetallePedido add(DetallePedido detalle)
        {
            detallePedidoRepo = new DetallePedidoRepo();

            DetallePedido detalleN = new DetallePedido();
            detalleN.cantidadKg = detalle.cantidadKg;
            detalleN.idPedido = detalle.idPedido;
            detalleN.idProducto = detalle.idProducto;
            detalleN.total = detalle.total;
            detallePedidoRepo.Add(detalleN);

            return detalleN;
        }

        public DetallePedido update(DetallePedido detalle)
        {
            detallePedidoRepo = new DetallePedidoRepo();

            DetallePedido detalleN = new DetallePedido();
            detalleN.id = detalle.id;
            detalleN.cantidadKg = detalle.cantidadKg;
            detalleN.idPedido = detalle.idPedido;
            detalleN.idProducto = detalle.idProducto;
            detalleN.total = detalle.total;
            detallePedidoRepo.Commit();

            return detalleN;
        }

        public void delete(int id)
        {
            detallePedidoRepo = new DetallePedidoRepo();

            DetallePedido detalle = detallePedidoRepo.GetById(id);
            detallePedidoRepo.Delete(detalle);
        }
    }
}
