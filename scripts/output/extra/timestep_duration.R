# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Makes a png file containing solve time for each step
# comparison script: FALSE
# ---------------------------------------------------------------

#Version 1.00 - Abhijeet Mishra
# 1.00: first working version [AM]
# 1.10: Bugfix to calculate all times in single units [AM]

library(magpie4)
library(magpiesets)
library(lusweave)
library(magclass)
library(ggplot2)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir    <-"."
}

filenames <- list.files(outputdir,full.names = TRUE)
filenames <- grep(x=filenames,pattern="gdx",value=T)

infor <- file.info(filenames)

infor$filename = basename(rownames(infor))
rownames(infor) = NULL

infor <- infor[order(infor$mtime),]
infor$Tdiff <- 0

for(i in 2:nrow(infor)){
  infor$Tdiff[i] <- round(difftime(infor$mtime[i], infor$mtime[i-1], units='mins'),2)
}

infor <- infor[order(infor$mtime),]

p <- ggplot(infor, aes(x = factor(filename, levels = filename), y = Tdiff)) +
  geom_bar(aes(fill=Tdiff), stat = 'identity',position="dodge",colour="black", width = 0.8) +
  theme(axis.text.x = element_text(angle = 90)) +
  xlab("GDX files in order of creation") +
  ylab("Minutes") +
  labs(fill = "Minutes")


ggsave(plot = p,filename = paste0(outputdir,"/timestep_solve_duration.png"),width = 12,height = 6)
