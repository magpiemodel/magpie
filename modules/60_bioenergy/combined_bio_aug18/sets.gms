*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

sets
   kbe60(kcr) bio energy activities
        / betr, begr /

   kbec60(kcr) bio energy crop activities
        / sugr_cane /

   scenCombBio60 first plus second generation bioenergy scenarios
       / const2030.SSP1-Ref-SPA0,    const2030.SSP2-Ref-SPA0,    const2030.SSP5-Ref-SPA0,    const2030.SSP1-20-SPA0,
         const2030.SSP1-26-SPA0,     const2030.SSP1-37-SPA0,     const2030.SSP1-45-SPA0,     const2030.SSP2-20-SPA0,
         const2030.SSP2-26-SPA0,     const2030.SSP2-37-SPA0,     const2030.SSP2-45-SPA0,     const2030.SSP2-60-SPA0,
         const2030.SSP5-20-SPA0,     const2030.SSP5-26-SPA0,     const2030.SSP5-37-SPA0,     const2030.SSP5-45-SPA0,
         const2030.SSP5-60-SPA0,     const2030.SSP1-20-SPA1,     const2030.SSP1-26-SPA1,     const2030.SSP1-37-SPA1,
         const2030.SSP1-45-SPA1,     const2030.SSP2-20-SPA2,     const2030.SSP2-26-SPA2,     const2030.SSP2-37-SPA2,
         const2030.SSP2-45-SPA2,     const2030.SSP2-60-SPA2,     const2030.SSP2-OS-SPA2,     const2030.SSP5-20-SPA5,
         const2030.SSP5-26-SPA5,     const2030.SSP5-37-SPA5,     const2030.SSP5-45-SPA5,     const2030.SSP5-60-SPA5,
         const2030.SSP5-OS-SPA5,     const2020.SSP1-Ref-SPA0,    const2020.SSP2-Ref-SPA0,    const2020.SSP5-Ref-SPA0,
         const2020.SSP1-20-SPA0,     const2020.SSP1-26-SPA0,     const2020.SSP1-37-SPA0,     const2020.SSP1-45-SPA0,
         const2020.SSP2-20-SPA0,     const2020.SSP2-26-SPA0,     const2020.SSP2-37-SPA0,     const2020.SSP2-45-SPA0,    
         const2020.SSP2-60-SPA0,     const2020.SSP5-20-SPA0,     const2020.SSP5-26-SPA0,     const2020.SSP5-37-SPA0,
         const2020.SSP5-45-SPA0,     const2020.SSP5-60-SPA0,     const2020.SSP1-20-SPA1,     const2020.SSP1-26-SPA1,
         const2020.SSP1-37-SPA1,     const2020.SSP1-45-SPA1,     const2020.SSP2-20-SPA2,     const2020.SSP2-26-SPA2,
         const2020.SSP2-37-SPA2,     const2020.SSP2-45-SPA2,     const2020.SSP2-60-SPA2,     const2020.SSP2-OS-SPA2,
         const2020.SSP5-20-SPA5,     const2020.SSP5-26-SPA5,     const2020.SSP5-37-SPA5,     const2020.SSP5-45-SPA5,
         const2020.SSP5-60-SPA5,     const2020.SSP5-OS-SPA5,     phaseout2020.SSP1-Ref-SPA0, phaseout2020.SSP2-Ref-SPA0,
         phaseout2020.SSP5-Ref-SPA0, phaseout2020.SSP1-20-SPA0,  phaseout2020.SSP1-26-SPA0,  phaseout2020.SSP1-37-SPA0,
         phaseout2020.SSP1-45-SPA0,  phaseout2020.SSP2-20-SPA0,  phaseout2020.SSP2-26-SPA0,  phaseout2020.SSP2-37-SPA0,
         phaseout2020.SSP2-45-SPA0,  phaseout2020.SSP2-60-SPA0,  phaseout2020.SSP5-20-SPA0,  phaseout2020.SSP5-26-SPA0,
         phaseout2020.SSP5-37-SPA0,  phaseout2020.SSP5-45-SPA0,  phaseout2020.SSP5-60-SPA0,  phaseout2020.SSP1-20-SPA1,
         phaseout2020.SSP1-26-SPA1,  phaseout2020.SSP1-37-SPA1,  phaseout2020.SSP1-45-SPA1,  phaseout2020.SSP2-20-SPA2,
         phaseout2020.SSP2-26-SPA2,  phaseout2020.SSP2-37-SPA2,  phaseout2020.SSP2-45-SPA2,  phaseout2020.SSP2-60-SPA2,
         phaseout2020.SSP2-OS-SPA2,  phaseout2020.SSP5-20-SPA5,  phaseout2020.SSP5-26-SPA5,  phaseout2020.SSP5-37-SPA5,
         phaseout2020.SSP5-45-SPA5,  phaseout2020.SSP5-60-SPA5,  phaseout2020.SSP5-OS-SPA5  /
;
