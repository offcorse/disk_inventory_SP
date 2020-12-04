using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations; //added for project 4

namespace DiskInventory.Models
{
    public partial class DiskHasBorrower
    {
        public int Id { get; set; }  //added for project 4
        
        [Required(ErrorMessage = "Please enter a borrower.")] //added for project 4
        public int BorrowerId { get; set; }
        public virtual Borrower Borrower { get; set; }//moved from bottom

        [Required(ErrorMessage = "Please enter a disk.")] //added for project 4
        public int DiskId { get; set; }
        public virtual Disk Disk { get; set; }//moved from bottom

        [Required(ErrorMessage = "Please enter a borrowed date.")] //added for project 4
        public DateTime BorrowedDate { get; set; }
        public DateTime? ReturnedDate { get; set; }

       
       
    }
}
