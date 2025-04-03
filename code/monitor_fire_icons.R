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


  

