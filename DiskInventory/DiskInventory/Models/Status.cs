using System;
using System.Collections.Generic;

namespace DiskInventory.Models
{
    public partial class Status
    {
        public Status()
        {
            Disk = new HashSet<Disk>();
        }

        public int StatusId { get; set; }
        public string StatusDescription { get; set; }

        public virtual ICollection<Disk> Disk { get; set; }
    }
}
