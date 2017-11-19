using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Linq.Expressions;
using DAL;

namespace DAL.Repository
{
    public abstract class Repository<TEntity> : IRepository<TEntity> where TEntity : class
    {
        private readonly DbSet<TEntity> _entities;
        public ecotrash_dbEntities context;


        public Repository()
        {
            context = new ecotrash_dbEntities();
            //context.Configuration.AutoDetectChangesEnabled = true;
            _entities = context.Set<TEntity>();
            
        }

        public IEnumerable<TEntity> Get(Expression<Func<TEntity, bool>> predicate)
        {
            
            return _entities.Where(predicate).ToList();
        }

        public IEnumerable<TEntity> GetAll()
        {
            return _entities.ToList();
        }

        public TEntity GetById(int id)
        {
            return _entities.Find(id);
        }

        public void Attach(TEntity entity)
        {
            _entities.Attach(entity);
            context.SaveChanges();
        }

        public void Add(TEntity entity)
        {
            _entities.Add(entity);
            context.SaveChanges();
        }

        public void Update(TEntity entity)
        {
            
            context.SaveChanges();
        }

        public void Delete(TEntity entity)
        {
            _entities.Remove(entity);
            context.SaveChanges();
        }

        public void Commit()
        {
            context.SaveChanges();
        }
    }
}
