using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace DiskInventory.Models
{
    public partial class Borrower
    {
        public Borrower()
        {
            DiskHasBorrower = new HashSet<DiskHasBorrower>();
        }

        public int BorrowerId { get; set; }
        [Required(ErrorMessage ="Please enter a first name.")]
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string PhoneNum { get; set; }

        public virtual ICollection<DiskHasBorrower> DiskHasBorrower { get; set; }
    }
}
