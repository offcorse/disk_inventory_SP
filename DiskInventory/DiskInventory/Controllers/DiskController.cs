using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using DiskInventory.Models;  //added

namespace DiskInventory.Controllers //controller for Disk table
{
    public class DiskController : Controller
    {
        private disk_inventory_spContext context { get; set; }
        public DiskController(disk_inventory_spContext ctx)
        {
            context = ctx;
        }
        public IActionResult List()
        {
            List<Disk> disk = context.Disk.OrderBy(a => a.DiskName).ToList();
            ViewBag.DiskTypes = context.DiskType.OrderBy(t => t.DiskTypeId).ToList(); //viewbags for Disktype,genre, and status
            ViewBag.Genres = context.Genre.OrderBy(g => g.GenreDescription).ToList();
            ViewBag.Status = context.Status.OrderBy(s => s.StatusDescription).ToList();
            return View(disk);
        }
        [HttpGet]
        public IActionResult Add()
        {
            ViewBag.Action = "Add";
            ViewBag.DiskTypes = context.DiskType.OrderBy(t => t.DiskTypeId).ToList(); //viewbags for Disktype,genre, and status
            ViewBag.Genres = context.Genre.OrderBy(g => g.GenreDescription).ToList();
            ViewBag.Status = context.Status.OrderBy(s => s.StatusDescription).ToList();
            return View("Edit", new Disk());//return the Edit view with an empty Disk object for the Add process.
        }
        [HttpGet]
        public IActionResult Edit(int id)
        {
            ViewBag.Action = "Edit";
            ViewBag.DiskTypes = context.DiskType.OrderBy(t => t.DiskDescription).ToList();  //viewbags for Disktype,genre, and status
            ViewBag.Genres = context.Genre.OrderBy(g => g.GenreDescription).ToList();
            ViewBag.Status = context.Status.OrderBy(s => s.StatusDescription).ToList();
            var disk = context.Disk.Find(id);
            return View(disk); //return the disk object to the view
        }
        [HttpPost]
        public IActionResult Edit(Disk disk)
        {
            if (ModelState.IsValid)
            {
                if (disk.DiskId == 0)
                { 
                    //disk.GenreId = 1;
                    //disk.StatusId = 1;
                    context.Disk.Add(disk);
                }
                else
                { 
                    //disk.GenreId = 1;
                    //disk.StatusId = 1;
                    context.Disk.Update(disk);
                }
                context.SaveChanges();
                return RedirectToAction("List", "Disk"); //redirect back to disk list
            }
            else
            {
                ViewBag.Action = (disk.DiskId == 0) ? "Add" : "Edit";
                ViewBag.DiskTypes = context.DiskType.OrderBy(t => t.DiskDescription).ToList();  //viewbags for Disktype,genre, and status
                ViewBag.Genres = context.Genre.OrderBy(g => g.GenreDescription).ToList();
                ViewBag.Status = context.Status.OrderBy(s => s.StatusDescription).ToList();
                return View(disk);  //return the disk object to the view
            }
        }
        [HttpGet]
        public IActionResult Delete(int id)
        {
            var disk = context.Disk.Find(id);
            return View(disk);
        }
        [HttpPost]
        public IActionResult Delete(Disk disk)
        {
            context.Disk.Remove(disk);
            context.SaveChanges();
            return RedirectToAction("List", "Disk");
        }
    }
}
