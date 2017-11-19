using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Repository
{
    public interface IRepository<T>
    {
        //T First(Expression<Func<T, bool>> predicate);
        IEnumerable<T> Get(Expression<Func<T, bool>> predicate);
        T GetById(int id);
        IEnumerable<T> GetAll();
        //IEnumerable<T> GetAllOrderBy(Func<T, object> keySelector);
        //IEnumerable<T> GetAllOrderByDescending(Func<T, object> keySelector);
        void Add(T entity);
        void Update(T entity);
        void Delete(T entity);
        //void DeleteWhere(Expression<Func<T, bool>> predicate);
        //void DeleteAny(List<T> lstEntities);
        void Commit();
        //void Dispose();
    }
}
