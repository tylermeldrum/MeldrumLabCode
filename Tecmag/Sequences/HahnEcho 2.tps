PSEQ1.001.18 BIN
   HahnEcho 2          NMRLab@AC-ISC1026LAB2   R�S       
   
                                 Name:   Name:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                           1u   Delay   Delay                                                           5u                                                           5u                                                           =p1                                                           =d1                                                           =p2                                                           =d2                                                        
   =Acq. Time                                                           =trep                                                           1u                                                        
    1ME   XT                0   F1_PhRst   F1_PhRst                                                           1                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                        
   1PE   3R                0   F1_Ampl   F1_Ampl                                                           0                                                           0                                                           =90amp                                                           0                                                           =180amp                                                           0                                                           0                                                           0                                                           0                                                        
   1ME   HP                -1   F1_Ph   F1_Ph                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                        
   1PE   3P                -1   F1_PhMod   F1_PhMod                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                        
   1ME   XT                0   F1_HOP   F1_HOP                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                        
   1ME   XT                0
   F1_UnBlank
   F1_UnBlank                                                           0                                                           1                                                           1                                                           1                                                           1                                                           0                                                           0                                                           0                                                           0                                                        
   1QA   CA                0   Acq   Acq                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           1                                                          32   1000000.0 Hz   1000000.0 Hz   500n   16u        0                                                           0                                                        
   1QA   HP                -1	   Acq_phase	   Acq_phase                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                        
   1ME   XT                0   Rx_Blank   Rx_Blank                                                           1                                                           1                                                           1                                                           1                                                           1                                                           0                                                           0                                                           0                                                           0                                                        
   1ME   XT                0
   Scope_Trig
   Scope_Trig                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                        
                          0   Loop   Loop                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                        
                           0   CBranch   CBranch                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                        
                           0   CTest   CTest                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                        
                           0   Ext_Trig   Ext_Trig                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                        
                           0	   RT_Update	   RT_Update                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                                                                                                                                                                  de0:2   0   + Add   0.5u
   Every pass                                                                180amp       80                           180amp                      90amp       40                           90amp                      d1       30u      1n   1000s               d1                      d2      =[d1]+[p1]/2-[Acq. Time]/2	      1n   1000s           d1^p1^Acq. Time   d2                      p1       3u      1n   1000s               p1                      p2       3u      1n   1000s               p2                      trep       10u      1n   1000s               trep                   