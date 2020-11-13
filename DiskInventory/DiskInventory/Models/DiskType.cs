using System;
using System.Collections.Generic;

namespace DiskInventory.Models
{
    public partial class DiskType
    {
        public DiskType()
        {
            Disk = new HashSet<Disk>();
        }

        public int DiskTypeId { get; set; }
        public string DiskDescription { get; set; }

        public virtual ICollection<Disk> Disk { get; set; }
    }
}
