# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de

############################# LOAD LIBRARIES #############################
library(lucode, quietly = TRUE, warn.conflicts =FALSE)

if(!exists("source_include")) {
 outputdirs <- c("output/default_2015-01-14_11.41.17",
                 "output/default_2015-01-14_12.28.56",
                 "output/default_2015-01-14_15.00.13",
                 "output/default_2015-01-14_15.36.12");
 readArgs("outputdirs")
}

print(readRuntime(outputdirs,plot=TRUE))
