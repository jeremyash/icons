# create points to be used in legend for smokeR and other reporting tools, modeled after Fire and Smoke Map icons

#  create icon for permanent monitors
png("perm_mon.png", width = 900, height = 900, res = 10500, bg = "transparent")
par(mar = c(0, 0, 0, 0))
plot.new()
points(.5, .5, pch = 21, col = "black", bg = "#00E400")
dev.off()

#  create icon for temp monitors
png("temp_mon.png", width = 900, height = 900, res = 10500, bg = "transparent")
par(mar = c(0, 0, 0, 0))
plot.new()
points(.5, .5, pch = 21, cex = 0.5, lwd = 0.5,  col = "black", bg = "#00E400")
dev.off()




# recolor fire icon from Bootstrap: https://icons.getbootstrap.com/icons/fire/
library(svgparser)
library(grid)
library(magick)

fire_grob <- read_svg("fire.svg")

grid::grid.newpage()
grid::grid.draw(fire_grob)

# get elements
ls <- grid::grid.ls()
print(head(ls))
names <- ls$name[grepl('pathgrob', ls$name)]
print(head(names))

# get fills
fills <- sapply(names, function(name) {
  ngrob <- grid.get(gPath(name))
  ngrob$gp$fill 
})
ncols <- length(unique(fills))

table(fills)


# recolor black portion of flame with FASM color: note this requires manual export of image
red_flame <- sapply(names, function(name) {
  ngrob <- grid::grid.get(gPath(name))
  ngrob$gp$fill <- "#d52900"
  grid::grid.draw(ngrob)
})

# trim whitespace
fire_png <- image_read("redFlame.png")

# Trim whitespace
trimmed_img <- image_trim(fire_png)

# Save the trimmed image
image_write(trimmed_img, "redFlame.png")



