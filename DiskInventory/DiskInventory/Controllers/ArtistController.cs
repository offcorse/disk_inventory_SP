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
            ViewBag.ArtistTypes = context.ArtistType.OrderBy(t => t.ArtistDescription).ToList();
            ViewBag.Artists = context.Artist.OrderBy(a => a.ArtistLastName).ToList();
            List<Artist> artists = context.Artist.OrderBy(a => a.ArtistFirstName).ThenBy(a => a.ArtistLastName).ToList(); //list out the artists into an artists object and return to the view
            return View(artists);
        }
        [HttpGet]
        public IActionResult Add()
        {
            ViewBag.Action = "Add";
            ViewBag.ArtistTypes = context.ArtistType.OrderBy(t => t.ArtistDescription).ToList(); //use the viewbag to store artist types
            return View("Edit", new Artist()); //use the Edit view with an empty new Artist for the Add function (artistID == 0)
        }
        [HttpGet]
        public IActionResult Edit(int id)
        {
            ViewBag.Action = "Edit";
            ViewBag.ArtistTypes = context.ArtistType.OrderBy(t => t.ArtistDescription).ToList();//use the viewbag to store artist types
            ViewBag.Artists = context.Artist.OrderBy(a => a.ArtistLastName).ToList();
            var artist = context.Artist.Find(id);
            return View(artist);//return the artist object to the view
        }
        [HttpPost]
        public IActionResult Edit(Artist artist)
        {
            if (ModelState.IsValid)
            {
                if (artist.ArtistId == 0)//then it's an Add
                    context.Artist.Add(artist);
                else
                    context.Artist.Update(artist);
                context.SaveChanges();
                return RedirectToAction("List", "Artist");
            }
            else
            {
                ViewBag.Action = (artist.ArtistId == 0) ? "Add":"Edit";
                ViewBag.ArtistTypes = context.ArtistType.OrderBy(t => t.ArtistDescription).ToList(); //use the viewbag to store artist types
                ViewBag.Artists = context.Artist.OrderBy(a => a.ArtistLastName).ToList();
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
