using DAL;
using DAL.TipoProductoDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.TipoProductoBLL
{
    public class TipoProductoLogic
    {
        TipoProductoRepository tipoProdRepo;

        public IEnumerable<TipoProducto> getAll()
        {

            tipoProdRepo = new TipoProductoRepository();

            return tipoProdRepo.GetAll();
        }

        public TipoProducto getById(int id)
        {
            tipoProdRepo = new TipoProductoRepository();

            TipoProducto tipo = tipoProdRepo.GetById(id);

            if (tipo == null)
                throw new Exception("No existe producto");

            return tipo;
        }

        public TipoProducto add(TipoProducto tipo)
        {
            tipoProdRepo = new TipoProductoRepository();

            TipoProducto tipoN = new TipoProducto();
            tipoN.descripcion = tipo.descripcion;
            tipoProdRepo.Add(tipoN);

            return tipoN;
        }

        public TipoProducto update(TipoProducto tipo)
        {
            tipoProdRepo = new TipoProductoRepository();

            TipoProducto tipoN = new TipoProducto();
            tipoN.id = tipo.id;
            tipoN.descripcion = tipo.descripcion;
            tipoProdRepo.Commit();

            return tipoN;
        }

        public void delete(int id)
        {
            tipoProdRepo = new TipoProductoRepository();

            TipoProducto tipo = tipoProdRepo.GetById(id);
            tipoProdRepo.Delete(tipo);
        }
    }
}
