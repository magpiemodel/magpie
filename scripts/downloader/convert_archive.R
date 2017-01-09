convert_archive <- function(folder=".") {

  # converts archive from old to new format
  
  setwd(folder)
  folder <- getwd()
  on.exit(setwd(folder))
  
  # get relevant directories
  # take only revisions >= 22
  dirs <- grep("rev2[2-9]",list.dirs(full.names = FALSE),value = TRUE)
  
  # take only 0.5_set and *_set/* folders
  dirs <- grep("(0\\.5_set|_set/.*)$",dirs,value=TRUE)
  
  for(d in dirs) {
    setwd(d)
    f <- "avl_land_0.5.mz"
    if(!file.exists(f)) file.copy(paste0("../../0.5_set/",f),f)
    # tar(paste0(folder,"/",gsub("/","__",d),".tgz"), files=list.files(), compression="gzip")
    system(paste0("tar -czf ",folder,"/",gsub("_set","",gsub("/","_",d)),".tgz"," *"))
    setwd(folder)
  }
}

convert_moinput <- function(folder=".") {
  
  # converts archive from old to new format
  
  setwd(folder)
  folder <- getwd()
  on.exit(setwd(folder))
  
  # get relevant directories
  # take only folders with depth=2
  dirs <-  grep("^[^/]*/[^/]*/[^/]*$",list.dirs(full.names=FALSE),value=TRUE)

  for(d in dirs) {
    setwd(d)
    # tar(paste0(folder,"/",gsub("/","__",d),".tgz"), files=list.files(), compression="gzip")
    system(paste0("tar -czf ",folder,"/",gsub("/","_",d),".tgz"," *"))
    setwd(folder)
  }
}