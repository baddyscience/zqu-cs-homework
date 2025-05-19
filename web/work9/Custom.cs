using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

public class Custom
{
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }

    [StringLength(50)]
    public string CName { get; set; }

    public int? DepartmentId { get; set; }

    [ForeignKey("DepartmentId")]
    public virtual Department Department { get; set; }

    public int? Age { get; set; }

    [StringLength(50)]
    public string EName { get; set; }

    [StringLength(50)]
    public string Password { get; set; }
}