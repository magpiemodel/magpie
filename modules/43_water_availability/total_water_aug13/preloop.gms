*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

im_wat_avail(t,"surface",j) = f43_wat_avail(t,j);

im_wat_avail(t,"ground",j) = 0;
im_wat_avail(t,"ren_ground",j) = 0;
im_wat_avail(t,"technical",j) = 0;
