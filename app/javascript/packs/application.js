// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// Font awesome
require("@fortawesome/fontawesome-free");

document.addEventListener("turbolinks:load", () => {
  let profPic = document.getElementById("nav-prof-pic");
  let dropDiv = document.getElementById("nav-drop-content");

  profPic.addEventListener("click", () => {
    if (dropDiv.style.display === "block") {
      dropDiv.style.display = "none";
    } else {
      dropDiv.style.display = "block";
    }
  });

  document.addEventListener("click", (e) => {
    if (e.target.id != "nav-prof-pic") {
      dropDiv.style.display = "none";
    }
  });
});

document.addEventListener("turbolinks:load", () => {
  let tintedTiles = document.querySelectorAll(".tinted-tile");

  tintedTiles.forEach((tile) => {
    tile.addEventListener("mouseenter", () => {
      tile.style.backgroundColor = "rgba(0, 0, 0, 0.5)";
      tile.childNodes[1].style.display = "block";
    });

    tile.addEventListener("mouseleave", () => {
      tile.style.backgroundColor = "rgba(0, 0, 0, 0.0)";
      tile.childNodes[1].style.display = "none";
    });
  });
});
