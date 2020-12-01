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
