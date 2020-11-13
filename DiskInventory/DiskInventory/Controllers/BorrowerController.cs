using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using DiskInventory.Models;

namespace DiskInventory.Controllers     //controller for Borrower table
{
    public class BorrowerController : Controller
    {
        private disk_inventory_spContext context { get; set; }
        public BorrowerController(disk_inventory_spContext ctx)
        {
            context = ctx;
        }
        public IActionResult List()
        {
            List<Borrower> borrower = context.Borrower.OrderBy(a => a.LastName).ToList();
            return View(borrower);
        }

    }
}
