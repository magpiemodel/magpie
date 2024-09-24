# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Comparison at cellular level of land and crop types with LUH2 and MAPSPAM
# comparison script: FALSE
# ---------------------------------------------------------------

library(magpie4)
library(luscale)
library(luplot)
library(lusweave)
library(magpiesets)
library(gdx2)

############################# BASIC CONFIGURATION ##############################
if (!file.exists(paste0(outputdir, "/LUH2_croparea_0.5.mz"))) stop("Cell validation is not possible. LUH2_croparea_0.5.mz and MAPSPAM_croparea_0.5.mz files are missing")
map_file <- Sys.glob(file.path(outputdir, "/clustermap_*.rds"))
gdx <- file.path(outputdir, "/fulldata.gdx")
cfg <- gms::loadConfig(file.path(outputdir, "/config.yml"))
crops <- c("maiz", "rice_pro", "soybean", "tece")
mapping <- readRDS(map_file)
################################################################################

#### Folder for saving results
out_dir <- paste0(outputdir, "/CellularValidation/")
if (!dir.exists(out_dir)) dir.create(out_dir)

######## Land use types comparison with LUH ########
magpie_LU <- land(gdx, level = "cell")
historical_LU <- readGDX(gdx, "f10_land")

LU <- plotCorrHist2D(
    x = historical_LU, y = magpie_LU, xlab = "LUH2 \n (mio.ha)", ylab = "MAgPIE \n (mio.ha)", bins = 35,
    folder = out_dir, file = "/validationLUcell", breaks = c(1, 10, 100), nrows = 2, ncols = 2, axisFont = 10,
    axisTitleFont = 11, TitleFontSize = 12, legendTitleFont = 10, legendTextFont = 8, statFont = 2, stat = FALSE, table = TRUE, tag = "year"
)

######## Crop types ("maiz","rice_pro","soybean","tece") comparison  with LUH ########
magpie <- croparea(gdx, level = "cell", product_aggr = FALSE, water_aggr = TRUE)[, , crops]
historical1 <- read.magpie(paste0(outputdir, "/LUH2_croparea_0.5.mz"))
historical1 <- magpiesort((gdxAggregate(gdx, historical1, to = "cell", absolute = TRUE, dir = outputdir)))[, , crops]
historical1 <- dimSums(historical1, dim = 3.1)

intYears <- intersect(getYears(magpie, as.integer = TRUE), getYears(historical1, as.integer = TRUE))
Crops <- plotCorrHist2D(
    x = historical1[,intYears,], y = magpie[,intYears,], xlab = "LUH2 \n (mio.ha)", ylab = "MAgPIE \n (mio.ha)", bins = 35,
    folder = out_dir, file = "/validationCropCell", breaks = c(1, 10, 50), nrows = 2, ncols = 2, axisFont = 10,
    axisTitleFont = 11, TitleFontSize = 12, legendTitleFont = 10, legendTextFont = 8, statFont = 2, stat = FALSE, table = TRUE, tag = "year"
)

######## Crop types ("maiz","rice_pro","soybean","tece") comparison  with MAPSPAM ########
historical <- read.magpie(paste0(outputdir, "/MAPSPAM_croparea_0.5.mz"))
historical <- magpiesort(gdxAggregate(gdx, historical, to = "cell", absolute = TRUE, dir = outputdir))[,,crops] 
historical <- dimSums(historical, dim = 3.2)
intYears2 <- intersect(getYears(magpie, as.integer = TRUE), getYears(historical, as.integer = TRUE))

CropsSPAM <- plotCorrHist2D(
    x = historical, y = magpie[, intYears2, ], xlab = "MAPSPAM \n (mio.ha)", ylab = "MAgPIE \n (mio.ha)", bins = 35,
    folder = out_dir, file = "/validationCropCellSPAM", breaks = c(1, 10, 50), nrows = 2, ncols = 2, axisFont = 10,
    axisTitleFont = 11, TitleFontSize = 12, legendTitleFont = 10, legendTextFont = 8, statFont = 2, stat = FALSE, table = TRUE,
    palette = "PiYG", tag = "year"
)

######################################### Generates document ##############################################
template <- c(
    "\\documentclass[a4paper, portrait ]{article}",
    "\\setlength{\\parindent}{0in}",
    "\\usepackage{float}",
    "\\usepackage[bookmarksopenlevel=section]{hyperref}",
    "\\hypersetup{bookmarks=true,pdfauthor={PIK Landuse group}}",
    "\\usepackage{graphicx}",
    "\\usepackage{rotating}",
    "\\usepackage[strings]{underscore}",
    "\\usepackage[margin=2cm]{geometry}",
    "\\usepackage{fancyhdr}",
    "\\pagestyle{fancy}",
    "\\begin{document}",
    "<<echo=false>>=",
    "options(width=90)",
    "@"
)

############################## Plots LUH vs. magpie land use types ####################################################
x <- LU[[1]]
y <- as.data.frame(LU[[2]])
colnames(y) <- y[1, ]
rownames(y) <- NULL
y <- (y[2:(nrow(y)), ])
y[, 3:ncol(y)] <- round(as.numeric(unlist(y[, 3:ncol(y)])), 3)
colnames(y) <- c("Year", "Variable", "R2", "MAE", "MPE", "MAPE")

tmpplot <- function(x, range) {
    plotLU <- function(x, range) {
        print(gridExtra::marrangeGrob(x[range], nrow = 3, ncol = 2, top = NULL))
    }
    a <- capture.output(plotLU(x, range))
}

namesReport <- as.character(magpiesets::reportingnames(getNames(magpie_LU)))

sw <- swopen(outfile = paste0(outputdir, "/CellValidation.pdf"), template = template)
swlatex(sw, c("\\title{MAgPIE Validation on Cellular level}", "\\maketitle", "\\tableofcontents"))
swlatex(sw, "\\section{Land use between 1995-2020 compared to LUH2}")

b <- 0

for (i in 1:length(namesReport)) {
    swlatex(sw, paste0("\\subsection{", namesReport[i], "}"))
    a <- b + 1
    b <- a + length(getYears(historical_LU)) - 1
    swfigure(sw, tmpplot, x = x, c(a:b))
    swtable(sw, collapseNames(as.magpie(y[a:b, ])),
        table.placement = "H", caption.placement = "top",
        transpose = FALSE, caption = paste0("Compilation of error measurements for ", namesReport[i], " data comparing MAgPIE outputs \\& the LUH2 set at cluster level"), vert.lines = 0, align = "c"
    )
    swlatex(sw, "\\newpage")
}


############################## Plots LUH vs. magpie crop types ##########################################################
swlatex(sw, "\\section{", paste0("MAgPIE crop types compared to LUH2 (", intYears[1], "-", intYears[length(intYears)], ")"), "}")

namesReport1 <- as.character(magpiesets::reportingnames(getNames(magpie)))
x1 <- Crops[[1]]
y1 <- as.data.frame(Crops[[2]])
colnames(y1) <- y1[1, ]
rownames(y1) <- NULL
y1 <- (y1[2:(nrow(y1)), ])
y1[, 3:ncol(y1)] <- round(as.numeric(unlist(y1[, 3:ncol(y1)])), 3)
colnames(y1) <- c("Year", "Variable", "R2", "MAE", "MPE", "MAPE")

tmpplot1 <- function(x1, range) {
    plotLU1 <- function(x1, range) {
        print(gridExtra::marrangeGrob(x1[range], nrow = 3, ncol = 2, top = NULL))
    }
    a <- capture.output(plotLU1(x1, range))
}

b1 <- 0
for (i in 1:length(namesReport1)) {
    swlatex(sw, paste0("\\subsection{", namesReport1[i], "}"))
    a1 <- b1 + 1
    b1 <- a1 + length(intYears) - 1
    swfigure(sw, tmpplot1, x = x1, c(a1:b1))
    swtable(sw, collapseNames(as.magpie(y1[a1:b1, ])),
        table.placement = "H", caption.placement = "top",
        transpose = FALSE, caption = paste0("Compilation of error measurements for ", namesReport1[i], " data comparing MAgPIE outputs \\& the LUH2 set at cluster level"), vert.lines = 0, align = "c"
    )
    swlatex(sw, "\\newpage")
}


############################## Plots MAPSPAM vs. magpie crop types ##########################################################


    swlatex(sw, "\\newpage")
    swlatex(sw, "\\section{", paste0("MAgPIE crop types compared to MAPSPAM (", intYears2[1], "-", intYears2[length(intYears2)], ")"), "}")

    x2 <- CropsSPAM[[1]]
    names(x2) <- paste0(names(x2), "MAP")
    x3 <- Crops[[1]][names(CropsSPAM[[1]])]
    y2 <- as.data.frame(CropsSPAM[[2]])
    colnames(y2) <- y2[1, ]
    rownames(y2) <- NULL
    y2 <- (y2[2:(nrow(y2)), ])
    y2[, 3:ncol(y2)] <- round(as.numeric(unlist(y2[, 3:ncol(y2)])), 3)
    colnames(y2) <- c("Year", "Variable", "R2", "MAE", "MPE", "MAPE")

    tmpplot2 <- function(x2, x3, range) {
        plotLU2 <- function(x2, x3, range) {
            print(gridExtra::marrangeGrob(c(x2[range], x3[range]), nrow = 3, ncol = 2, top = NULL))
        }
        a <- capture.output(plotLU2(x2, x3, range))
    }

    b2 <- 0
    for (i in 1:length(namesReport1)) {
        swlatex(sw, paste0("\\subsection{", namesReport1[i], "}"))
        swlatex(sw, "\\qquad \\textbf{MAPSPAM} \\qquad \\qquad \\qquad \\qquad \\qquad \\qquad \\qquad \\qquad \\qquad \\qquad \\textbf{LUH2}")
        a2 <- b2 + 1
        b2 <- a2 + length(intYears2) - 1
        swfigure(sw, tmpplot2, x2 = x2, x3 = x3, range = c(a2:b2))
        swtable(sw, collapseNames(as.magpie(y2[a2:b2, ])),
            table.placement = "H", caption.placement = "top",
            transpose = FALSE, caption = paste0("Compilation of error measurements for ", namesReport[i], " data comparing MAgPIE outputs \\& the MAPSPAM set at cluster level"), vert.lines = 0, align = "c"
        )
        swlatex(sw, "\\newpage")
    }

########## Details about statistics ##########
swlatex(sw, "\\newpage")
swlatex(sw, "\\section{Details about statistical measuremens of error and goodness of fit}")
swlatex(sw, "\\begin{itemize} \\item R2 represents the coefficient of determination. \\end{itemize}")
swlatex(sw, "\\begin{itemize} \\item MAE stands for mean absolute error and is calculated as $MAE=\\frac{1}{n}\\sum(|error|)$. Where, error represents the difference between LUH/MAPSPAM values and MAgPIE Outputs.  \\end{itemize}")
swlatex(sw, "\\begin{itemize} \\item MPE stands for mean percentage error (a measure of bias) and is calculated as $MPE=\\frac{100\\%}{n}\\sum(RE)$. Where, RE (relative error) represents the relative difference between LUH/MAPSPAM values and MAgPIE Outputs.  \\end{itemize}")
swlatex(sw, "\\begin{itemize} \\item Finally, MAPE stands for mean absolute percentage error and is calculated as $MAPE=\\frac{100\\%}{n}\\sum(|RE|)$. Where, RE (relative error) represents the relative difference between LUH/MAPSPAM values and MAgPIE Outputs.  \\end{itemize}")

####### Closes the pdf document
swclose(sw, clean_output = FALSE, engine = "knitr")

###########################################################################################################################

##### Erase latex style and output files

fileErase <- c(
    Sys.glob(file.path(outputdir, "/CellValidation.*")),
    Sys.glob(file.path(outputdir, "/Sweave.sty")),
    Sys.glob(file.path(outputdir, "figure/*")),
    Sys.glob(file.path(outputdir, "figure"))
)
fileErase <- fileErase[!(fileErase %in% paste0(outputdir, "//CellValidation.pdf"))]


unlink(fileErase, recursive = TRUE)
