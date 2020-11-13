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
            List<Artist> artists = context.Artist.OrderBy(a => a.ArtistLastName).ToList();
            return View(artists);
        }

    }
}
