﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class ecotrash_dbEntities : DbContext
    {
        public ecotrash_dbEntities()
            : base("name=ecotrash_dbEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<DetallePedido> DetallePedido { get; set; }
        public virtual DbSet<Pedido> Pedido { get; set; }
        public virtual DbSet<Producto> Producto { get; set; }
        public virtual DbSet<TipoPedido> TipoPedido { get; set; }
        public virtual DbSet<TipoProducto> TipoProducto { get; set; }
        public virtual DbSet<Transporte> Transporte { get; set; }
        public virtual DbSet<Usuario> Usuario { get; set; }
        public virtual DbSet<Usuario_Transporte> Usuario_Transporte { get; set; }
    }
}
