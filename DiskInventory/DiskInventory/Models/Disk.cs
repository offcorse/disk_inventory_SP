using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace DiskInventory.Models
{
    public partial class Disk
    {
        public Disk()
        {
            DiskHasArtist = new HashSet<DiskHasArtist>();
            DiskHasBorrower = new HashSet<DiskHasBorrower>();
        }

        public int DiskId { get; set; }
        [Required(ErrorMessage = "Enter a disk name.")]
        public string DiskName { get; set; }
        
        [Required]
        public DateTime ReleaseDate { get; set; }
        [Required]
        public int GenreId { get; set; }
        public int StatusId { get; set; }
        public int DiskTypeId { get; set; }

        public virtual DiskType DiskType { get; set; }
        public virtual Genre Genre { get; set; }
        public virtual Status Status { get; set; }
        public virtual ICollection<DiskHasArtist> DiskHasArtist { get; set; }
        public virtual ICollection<DiskHasBorrower> DiskHasBorrower { get; set; }
    }
}
