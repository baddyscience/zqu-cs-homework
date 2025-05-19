using System.Collections.Generic;
using System;

public class DepartmentService
{
    private readonly IRepository<Department> _repository;

    public DepartmentService()
    {
        _repository = new GenericRepository<Department>();
    }

    public IEnumerable<Department> GetAll()
    {
        return _repository.GetAll();
    }

    public Department GetById(int id) => _repository.GetById(id);

    public void Create(Department department)
    {
        ValidateDepartment(department);
        _repository.Add(department);
        _repository.Save();
    }

    public void Update(Department department)
    {
        ValidateDepartment(department);
        _repository.Update(department);
        _repository.Save();
    }

    public void Delete(int id)
    {
        _repository.Delete(id);
        _repository.Save();
    }

    private void ValidateDepartment(Department department)
    {
        if (string.IsNullOrWhiteSpace(department.DepartName))
            throw new ArgumentException("部门名称不能为空");
    }
}