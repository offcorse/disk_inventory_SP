using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using DiskInventory.Models;
using Microsoft.EntityFrameworkCore;

namespace DiskInventory.Controllers
{
    public class DiskHasBorrowerController : Controller
    {
        private disk_inventory_spContext context { get; set; }
        public DiskHasBorrowerController(disk_inventory_spContext ctx)
        {
            context = ctx;
        }
        public IActionResult List()
        {
            ViewBag.Disks = context.Disk.OrderBy(d => d.DiskName).ToList(); //use the viewbag to store artist types
            ViewBag.Borrowers = context.Borrower.OrderBy(b => b.LastName).ToList(); //use the viewbag to store artist types
            //List<DiskHasBorrower> diskhasborrower = context.DiskHasBorrower.OrderBy(d => d.DiskId).ThenBy(d => d.DiskHasBorrowerId).ToList();
            var diskhasborrower = context.DiskHasBorrower.OrderBy(db => db.BorrowedDate).
                Include(d => d.Disk).OrderBy(d => d.Id).
                Include(b => b.Borrower).OrderBy(b => b.BorrowedDate).ToList();

            return View(diskhasborrower);
        }
        [HttpGet]
        public IActionResult Add()
        {
            ViewBag.Action = "Add";
            ViewBag.Disks = context.Disk.OrderBy(d => d.DiskName).ToList(); //use the viewbag to store Disk types
            ViewBag.Borrowers = context.Borrower.OrderBy(b => b.LastName).ToList(); //use the viewbag to store borrowers
            return View("Edit", new DiskHasBorrower()); //use the Edit view with an empty new DiskHasBorrower for the Add function (artistID == 0)
        }
        [HttpGet]
        public IActionResult Edit(int id)
        {
            ViewBag.Action = "Edit";
            ViewBag.Disks = context.Disk.OrderBy(d => d.DiskName).ToList(); //use the viewbag to store Disk types
            ViewBag.Borrowers = context.Borrower.OrderBy(b => b.LastName).ToList(); //use the viewbag to store borrowers
            var diskhasborrower = context.DiskHasBorrower.Find(id);//find the id in the database
            return View(diskhasborrower);//return the diskhasborrower object to the view
        }
         [HttpPost]
        public IActionResult Edit(DiskHasBorrower diskhasborrower)
        {
            if (ModelState.IsValid)
            {
                if (diskhasborrower.Id == 0)//then it's an Add
                    context.DiskHasBorrower.Add(diskhasborrower);
                else
                    context.DiskHasBorrower.Update(diskhasborrower);
                context.SaveChanges();
                return RedirectToAction("List", "DiskHasBorrower");
            }
            else
            {
                ViewBag.Action = (diskhasborrower.Id == 0) ? "Add":"Edit";
                ViewBag.Disks = context.Disk.OrderBy(d => d.DiskName).ToList(); //use the viewbag to store Disk types
                ViewBag.Borrowers = context.Borrower.OrderBy(b => b.LastName).ToList(); //use the viewbag to store borrowers
                return View(diskhasborrower);
            }
        }
    }
}
