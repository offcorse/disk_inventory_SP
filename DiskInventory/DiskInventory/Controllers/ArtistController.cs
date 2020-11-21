using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using DiskInventory.Models; //added

namespace DiskInventory.Controllers  //controller for Artist table
{
    public class ArtistController : Controller
    {
        private disk_inventory_spContext context { get; set; }
        public ArtistController(disk_inventory_spContext ctx)
        {
            context = ctx;
        }
        public IActionResult List()
        {
            List<Artist> artists = context.Artist.OrderBy(a => a.ArtistLastName).ThenBy(a => a.ArtistFirstName).ToList();
            return View(artists);
        }
        [HttpGet]
        public IActionResult Add()
        {
            ViewBag.Action = "Add";
            ViewBag.ArtistTypes = context.ArtistType.OrderBy(t => t.ArtistDescription).ToList();
            return View("Edit", new Artist());
        }
        [HttpGet]
        public IActionResult Edit(int id)
        {
            ViewBag.Action = "Edit";
            ViewBag.ArtistTypes = context.ArtistType.OrderBy(t => t.ArtistDescription).ToList();
            var artist = context.Artist.Find(id);
            return View(artist);
        }
        [HttpPost]
        public IActionResult Edit(Artist artist)
        {
            if (ModelState.IsValid)
            {
                if (artist.ArtistId == 0)
                    context.Artist.Add(artist);
                else
                    context.Artist.Update(artist);
                context.SaveChanges();
                return RedirectToAction("List", "Artist");
            }
            else
            {
                ViewBag.Action = (artist.ArtistId == 0) ? "Add":"Edit";
                ViewBag.ArtistTypes = context.ArtistType.OrderBy(t => t.ArtistDescription).ToList();
                return View(artist);
            }
        }
        [HttpGet]
        public IActionResult Delete(int id)
        {
            var artist = context.Artist.Find(id);
            return View(artist);
        }
        [HttpPost]
        public IActionResult Delete(Artist artist)
        {
            context.Artist.Remove(artist);
            context.SaveChanges();
            return RedirectToAction("List", "Artist");
        }
    }
}
