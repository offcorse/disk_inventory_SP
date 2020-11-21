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

        [HttpGet]

        public IActionResult Add()
        {
            ViewBag.Action = "Add";
            return View("Edit", new Borrower());
        }
        [HttpGet]

        public IActionResult Edit(int id)
        {
            ViewBag.Action = "Edit";
            var borrower = context.Borrower.Find(id);
            return View(borrower);
        }
        [HttpPost]
        public IActionResult Edit(Borrower borrower)
        {
            if (ModelState.IsValid)
            {
                if (borrower.BorrowerId == 0)
                    context.Borrower.Add(borrower);
                else
                    context.Borrower.Update(borrower);
                context.SaveChanges();
                return RedirectToAction("List", "Borrower");
            }
            else
            {
                ViewBag.Action = (borrower.BorrowerId == 0) ? "Add" : "Edit";
                return View(borrower);
            }
        }

        [HttpGet]
        public IActionResult Delete(int id)
        {
            var borrower = context.Borrower.Find(id);
            return View(borrower);
        }
        [HttpPost]
        public IActionResult Delete(Borrower borrower)
        {
            context.Borrower.Remove(borrower);
            context.SaveChanges();
            return RedirectToAction("List","Borrower");
        }
    }
}
