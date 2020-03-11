library(magpie4)
gdx<-"/Users/flo/OneDrive/Dokumente/PIK/Development/MAgPIE/f_forestry/output/R054xx--SSP2-NormalRotation-Ref/fulldata.gdx"
gdx<-"/Users/flo/OneDrive/Dokumente/PIK/Development/MAgPIE/f_forestry/output/fulldata.gdx"
reportPriceGHG(gdx)
readGDX(gdx,"ov_cdr_aff",select = list(type="level"))
a <- readGDX(gdx,"ov32_land",select = list(type="level"))
dimSums(a,dim=c(1,3.2))
land(gdx,level="glo")[,,"forestry"]
dimSums(readGDX(gdx,"pm_land_start"),dim=1)[,,"forestry"]
a <- readGDX(gdx,"p32_land")
dimSums(a,dim=c(1,3.2))
dimSums(readGDX(gdx,"p56_c_price_aff"),dim=c(1,3))
g
a <- readGDX(gdx,"pm_rotation_reg")
mean(a["CAZ",1995,])/5
dimSums(a,dim=c(1,3))
dimSums(a,dim=c(1,3))

dimSums(readGDX(gdx,"ov35_other")[,,"level"][,,"ac0"],dim=1)
dimSums(readGDX(gdx,"ov32_land")[,,"level"][,,"ac0"],dim=1)
dimSums(readGDX(gdx,"ov32_land")[,,"level"][,,"ac0"],dim=1)
dimSums(readGDX(gdx,"ov_hvarea_other")[,,"level"][,,],dim=c(1,3.1))
dimSums(readGDX(gdx,"ov_other_reduction")[,,"level"][,,],dim=c(1,3))
dimSums(readGDX(gdx,"ov_hvarea_primforest")[,,"level"][,,],dim=c(1,3))
dimSums(readGDX(gdx,"ov_hvarea_secdforest")[,,"level"][,,],dim=c(1,3))

dimSums(readGDX(gdx,"pm_demand_ext")[,,][,,],dim=c(1,3))
dimSums(collapseNames(dimSums(readGDX(gdx,"ov73_prod_ton")[,,"level"][,,],dim=c(1)))/readGDX(gdx,"p73_volumetric_conversion"),dim=3)
dimSums(readGDX(gdx,"ov73_prod_natveg")[,,"level"][,,],dim=c(1,3))
dimSums(readGDX(gdx,"ov73_prod_forestry")[,,"level"][,,],dim=c(1,3))

ac0_free <- costs(gdx,leve="glo")
ac0_fixed <- costs(gdx,leve="glo")

dimSums(readGDX(gdx,"p32_land_before")[,,],dim=c(1,3.2))
dimSums(readGDX(gdx,"p32_land")[,,],dim=c(1,3.2))
dimSums(readGDX(gdx,"v32_land")[,,"l"],dim=c(1,3.2))


v73_prod_natveg

calc_scaling(gdx)

vm_hvarea_other
readGDX(gdx,"pc56_c_price_induced_aff")
