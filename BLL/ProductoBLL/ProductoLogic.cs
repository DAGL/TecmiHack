using DAL;
using DAL.ProductoDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.ProductoBLL
{
    public class ProductoLogic
    {
        ProductoDAL prodRepo;

        public IEnumerable<Producto> getAll()
        {

            prodRepo = new ProductoDAL();

            return prodRepo.GetAll();
        }

        public Producto getById(int id)
        {
            prodRepo = new ProductoDAL();

            Producto tipo = prodRepo.GetById(id);

            if (tipo == null)
                throw new Exception("No existe producto");

            return tipo;
        }

        public Producto add(Producto prod)
        {
            prodRepo = new ProductoDAL();

            Producto prodN = new Producto();
            prodN.descripcion = prod.descripcion;
            prodN.tipoProducto = prod.tipoProducto;
            prodRepo.Add(prodN);

            return prodN;
        }

        public Producto update(Producto prod)
        {
            prodRepo = new ProductoDAL();

            Producto prodN = new Producto();
            prodN.id = prod.id;
            prodN.descripcion = prod.descripcion;
            prodN.tipoProducto = prod.tipoProducto;
            prodRepo.Commit();

            return prodN;
        }

        public void delete(int id)
        {
            prodRepo = new ProductoDAL();

            Producto tipo = prodRepo.GetById(id);
            prodRepo.Delete(tipo);
        }
    }
}
