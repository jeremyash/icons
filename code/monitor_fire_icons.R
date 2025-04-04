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
points(.5, .5, pch = 21, cex = 0.65, lwd = 0.5,  col = "black", bg = "#00E400")
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
fire_png <- image_read("redFlame_raw.png")

img <- image_trim(fire_png, fuzz = 10)

img <- image_flatten(fire_png)

# Flood-fill from top-left
img1 <- image_fill(img, color = "none", point = "+0+0", fuzz = 10)

# Flood-fill from top-right
width <- image_info(img)$width
img2 <- image_fill(img1, color = "none", point = paste0("+", width - 1, "+0"), fuzz = 10)

# Flood-fill from bottom-left
height <- image_info(img)$height
img3 <- image_fill(img2, color = "none", point = paste0("+0+", height - 1), fuzz = 10)

# Flood-fill from bottom-right (optional but often useful)
img_final <- image_fill(img3, color = "none", point = paste0("+", width - 1, "+", height - 1), fuzz = 10)

# Save result
image_write(img_final, "redFlame.png")


# create satellite detect image
fire_detect_png <- image_read("sattelite_detect.png")

# Define image size
width <- 900
height <- 900

# Create an empty image
canvas <- image_blank(width, height, color = "transparent")

# Save outer circle with blur
png("outer_circle.png", width = width, height = height, bg = "transparent")
par(mar = rep(0, 4)) # Remove margins
plot(1, type = "n", xlim = c(0, width), ylim = c(0, height), axes = FALSE, xlab = "", ylab = "")
symbols(width / 2, height / 2, circles = width / 3, inches = FALSE, bg = "#EFCD78", fg = NA, add = TRUE)
dev.off()

outer_circle <- image_read("outer_circle.png") %>% image_blur(40, 20)

# Save inner circle with slight blur
png("inner_circle.png", width = width, height = height, bg = "transparent")
par(mar = rep(0, 4))
plot(1, type = "n", xlim = c(0, width), ylim = c(0, height), axes = FALSE, xlab = "", ylab = "")
symbols(width / 2, height / 2, circles = width / 6, inches = FALSE, bg = "#FE9929", fg = NA, add = TRUE)
dev.off()

inner_circle <- image_read("inner_circle.png") %>% image_blur(3, 1)

# Composite the two circles
final_image <- image_composite(outer_circle, inner_circle, operator = "over")

# trim image
final_image <- image_trim(final_image)

# resize image
final_image <- image_resize(final_image, "900x900")

# Save and display the final image
image_write(final_image, 
            "sattelite_detect.png")
final_image



















