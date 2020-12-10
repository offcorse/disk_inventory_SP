using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace DiskInventory.Models
{
    public partial class Artist
    {
        public Artist()
        {
            DiskHasArtist = new HashSet<DiskHasArtist>();
        }

        public int ArtistId { get; set; }
        
        [Required(ErrorMessage = "Enter an Artist First Name/Group Name.")]
        public string ArtistFirstName { get; set; }
        public string ArtistLastName { get; set; }
        public int ArtistTypeId { get; set; }

        public virtual ArtistType ArtistType { get; set; }
        public virtual ICollection<DiskHasArtist> DiskHasArtist { get; set; }
    }
}
