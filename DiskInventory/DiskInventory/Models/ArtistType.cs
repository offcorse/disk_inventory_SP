using System;
using System.Collections.Generic;

namespace DiskInventory.Models
{
    public partial class ArtistType
    {
        public ArtistType()
        {
            Artist = new HashSet<Artist>();
        }

        public int ArtistTypeId { get; set; }
        public string ArtistDescription { get; set; }

        public virtual ICollection<Artist> Artist { get; set; }
    }
}
