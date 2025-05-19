
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;

public class CustomService
{
    private readonly IRepository<Custom> _repository;

    public CustomService()
    {
        _repository = new GenericRepository<Custom>();
    }

    public IEnumerable<Custom> GetAllWithDepartments()
    {
        return _repository.GetQueryable()
            .Include(c => c.Department)
            .ToList();
    }

    public Custom GetById(int id)
    {
        return _repository.GetById(id);
    }

    public void Create(Custom custom)
    {
        ValidateCustom(custom);
        _repository.Add(custom);
        _repository.Save();
    }

    public void Update(Custom custom)
    {
        ValidateCustom(custom);
        _repository.Update(custom);
        _repository.Save();
    }

    public void Delete(int id)
    {
        _repository.Delete(id);
        _repository.Save();
    }

    private void ValidateCustom(Custom custom)
    {
        if (string.IsNullOrWhiteSpace(custom.CName))
            throw new ArgumentException("客户名称不能为空");

        if (custom.DepartmentId <= 0)
            throw new ArgumentException("必须选择所属部门");
    }
}