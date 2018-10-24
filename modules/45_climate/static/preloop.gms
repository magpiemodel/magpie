*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @code
*' In each cell $j$, the climate class shares $clcl$ sum up to 1.

pm_climate_class(j,clcl) = f45_koeppengeiger(j,clcl);

*' @stop
