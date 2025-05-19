using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;

public class GenericRepository<T> : IRepository<T> where T : class
{
    private readonly AppDbContext _context;
    private readonly DbSet<T> _dbSet;
    public IQueryable<T> GetQueryable() => _dbSet.AsQueryable();

    public GenericRepository()
    {
        _context = new AppDbContext();
        _dbSet = _context.Set<T>();
    }

    public IEnumerable<T> GetAll() => _dbSet.ToList();

    public T GetById(int id) => _dbSet.Find(id);

    public void Add(T entity) => _dbSet.Add(entity);

    public void Update(T entity)
    {
        _dbSet.Attach(entity);
        _context.Entry(entity).State = EntityState.Modified;
    }

    public void Delete(int id) => _dbSet.Remove(GetById(id));

    public void Save() => _context.SaveChanges();

}