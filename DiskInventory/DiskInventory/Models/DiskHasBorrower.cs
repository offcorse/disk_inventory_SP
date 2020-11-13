using System;
using System.Collections.Generic;

namespace DiskInventory.Models
{
    public partial class DiskHasBorrower
    {
        public int BorrowerId { get; set; }
        public int DiskId { get; set; }
        public DateTime BorrowedDate { get; set; }
        public DateTime? ReturnedDate { get; set; }

        public virtual Borrower Borrower { get; set; }
        public virtual Disk Disk { get; set; }
    }
}
