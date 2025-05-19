using System.Collections.Generic;
using System.Linq;

public interface IRepository<T> where T : class
{
    IEnumerable<T> GetAll();
    IQueryable<T> GetQueryable();
    T GetById(int id);
    void Add(T entity);
    void Update(T entity);
    void Delete(int id);
    void Save();
}