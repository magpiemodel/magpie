*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @code
*' For the time period beloning to the historical time period (y1965 to y2010
*' in this version of the model), the scalar `s62_historical` is set to 1 and
*' for the non-historical time periods, `s62_historical` is set to 0.
*' How this switch affects the material demand calculations is explained in the
*' equation(s) accompanying this module.

if (sum(sameas(t_past,t),1) = 1,
  s62_historical=1;
else
 s62_historical=0;
);

*' @stop
