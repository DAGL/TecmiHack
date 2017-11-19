using DAL;
using DAL.TIpoPedidoDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.TipoPedidoBLL
{
    public class TipoPedidoLogic
    {
        TipoPedidoRepo tipoPedidoRepo;

        public IEnumerable<TipoPedido> getAll()
        {

            tipoPedidoRepo = new TipoPedidoRepo();

            return tipoPedidoRepo.GetAll();
        }

        public TipoPedido getById(int id)
        {
            tipoPedidoRepo = new TipoPedidoRepo();

            TipoPedido tipo = tipoPedidoRepo.GetById(id);

            if (tipo == null)
                throw new Exception("No existe pedido");

            return tipo;
        }

        public TipoPedido add(TipoPedido tipo)
        {
            tipoPedidoRepo = new TipoPedidoRepo();

            TipoPedido tipoN = new TipoPedido();
            tipoN.descripcion = tipo.descripcion;
            tipoPedidoRepo.Add(tipoN);

            return tipoN;
        }

        public TipoPedido update(TipoPedido tipo)
        {
            tipoPedidoRepo = new TipoPedidoRepo();

            TipoPedido tipoN = new TipoPedido();
            tipoN.id = tipo.id;
            tipoN.descripcion = tipo.descripcion;
            tipoPedidoRepo.Commit();

            return tipoN;
        }

        public void delete(int id)
        {
            tipoPedidoRepo = new TipoPedidoRepo();

            TipoPedido tipo = tipoPedidoRepo.GetById(id);
            tipoPedidoRepo.Delete(tipo);
        }
    }
}
