using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using work9;

public class Department
{
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }

    [Required]
    [StringLength(50)]
    public string DepartName { get; set; }

    [Required]
    [StringLength(100)]
    public string Description { get; set; }

    public virtual ICollection<Custom> Customs { get; set; }
}