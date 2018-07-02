*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

sets
$ontext
        scen12 real interest rate scenarios
                  / low_boud,high_bound /

        scen12_to_dev(scen12,dev)
      /        high        . (lic)
               medium        . (mic)
               low                . (hic) /

        t_to_i_to_dev(t,i,dev)
$offtext
bound12 /low, high/
;