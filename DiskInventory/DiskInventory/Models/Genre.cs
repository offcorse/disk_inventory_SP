using System;
using System.Collections.Generic;

namespace DiskInventory.Models
{
    public partial class Genre
    {
        public Genre()
        {
            Disk = new HashSet<Disk>();
        }

        public int GenreId { get; set; }
        public string GenreDescription { get; set; }

        public virtual ICollection<Disk> Disk { get; set; }
    }
}
