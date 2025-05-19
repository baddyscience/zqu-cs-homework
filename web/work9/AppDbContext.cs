using System.Collections.Generic;
using System.Data.Entity;

public class AppDbContext : DbContext
{
    public AppDbContext() : base("name=AppConn") { }

    public DbSet<Department> Departments { get; set; }
    public DbSet<Custom> Customs { get; set; }

    protected override void OnModelCreating(DbModelBuilder modelBuilder)
    {
        // 配置实体关系
        modelBuilder.Entity<Custom>()
            .HasOptional(c => c.Department)
            .WithMany(d => d.Customs)
            .HasForeignKey(c => c.DepartmentId);
    }
}