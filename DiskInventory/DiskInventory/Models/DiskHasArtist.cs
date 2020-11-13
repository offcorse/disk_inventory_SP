using System;
using System.Collections.Generic;

namespace DiskInventory.Models
{
    public partial class DiskHasArtist
    {
        public int DiskId { get; set; }
        public int ArtistId { get; set; }

        public virtual Artist Artist { get; set; }
        public virtual Disk Disk { get; set; }
    }
}
