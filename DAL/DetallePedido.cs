//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DAL
{
    using System;
    using System.Collections.Generic;
    
    public partial class DetallePedido
    {
        public int id { get; set; }
        public int idProducto { get; set; }
        public decimal cantidadKg { get; set; }
        public decimal total { get; set; }
        public int idPedido { get; set; }
    
        public virtual Producto Producto { get; set; }
        public virtual Pedido Pedido { get; set; }
    }
}
