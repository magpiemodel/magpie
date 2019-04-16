*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Phosphorus
*'
*' @description The phosphorus module is introduced to estimate the major
*' P-flows in the agricultural sector and to determine the dynamics of P-Pools in the soil.
*' Different P-flows can be accounted in MAgPIE, among others:
*'
*'     * P withdrawals by harvest: estimated as P content of crop harvest
*'     * P withdrawals by harvest of above ground residues: estimated as P content of residues
*'     * P inputs by decaying recycled residues: estimated as P content of recycled residues
*'     * P inputs by burned residues: estimated as P content of burned residues but no combustion losses assumed
*'     * P inputs by manure recycled to croplands
*'     * P inputs by fertilizers
*'     * P inputs by release of plant-available P from the permanent P-Pool.
*'     * P inputs by seed
*'     * P inputs by weathering
*'     * P losses by erosion
*'     * P losses by leaching
*'
*' However, for the time being, this module is not activated in MAgPIE.
*' It is a topic we seek to include in future developments of the model as enriches
*' the biophysical aspects of the model as well as adds to the fertilizer costs (and hence total costs of production).
*'
*' @authors Benjamin Leon Bodirsky

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%phosphorus%" == "off" $include "./modules/54_phosphorus/off.gms"
*###################### R SECTION END (MODULETYPES) ############################
