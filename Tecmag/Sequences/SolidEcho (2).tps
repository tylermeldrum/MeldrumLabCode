PSEQ1.001.18 BIN	   SolidEcho         NMRLab@AC-ISC1026LAB2   ��|T                                           Name:   Name:                                                           Phase Reset                                                        
   StartDelay                                                        
   FirstPulse                                                        
   FirstDelay                                                           SecondPulse                                                        
   LoopDelay1                                                           Acq                                                           tRep                                                        	   LoopPulse                                                           RepTime                                                                                                                                               1u   Delay   Delay                                                           5u                                                           10u                                                           =pw                                                           =tEwait1                                                           =pw                                                           =tEwait2                                                        
   =Acq. Time                                                           =tEwait2                                                           =pw                                                           =tRep                                                           1u                                                            1ME   XT                0   F1_PhRst   F1_PhRst                                                           1                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           1PE   3R                0   F1_Ampl   F1_Ampl                                                           0                                                           0                                                           =90amp                                                           0                                                           =90amp                                                           0                                                           0                                                           0                                                           =90amp                                                           0                                                           0                                                           1ME   HP                -1   F1_Ph   F1_Ph                                                           -1                                                           -1                                                           -1           ph0                                              -1                                                           -1           ph1                                              -1                                                           -1                                                           -1                                                           -1           ph2                                              -1                                                           -1                                                           1PE   3P                -1   F1_PhMod   F1_PhMod                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           1ME   XT                0   F1_HOP   F1_HOP                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           1ME   XT                0
   F1_UnBlank
   F1_UnBlank                                                           0                                                           1                                                           1                                                           1                                                           1                                                           0                                                           0                                                           1                                                           1                                                           0                                                           0                                                           1QA   CA                0   Acq   Acq                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           1                                                          69   500000.000000   500000.000000   1u   69u        0                                                           0                                                           0                                                           0                                                           1QA   HP                -1	   Acq_phase	   Acq_phase                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1           ph2                                              -1                                                           -1                                                           -1                                                           -1                                                           1ME   XT                0   Rx_Blank   Rx_Blank                                                           0                                                           1                                                           1                                                           1                                                           1                                                           0                                                           0                                                           1                                                           1                                                           0                                                           0                                                           1ME   XT                0
   Scope_Trig
   Scope_Trig                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                                                  0   Loop   Loop                                                           0                                                           0                                                           0                                                           0                                                           0                                                        	   =nrEchoes                                                           0                                                           0                                                           -1                                                           0                                                           0                                                                                   0   CBranch   CBranch                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                                                   0   CTest   CTest                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                                                   0   Ext_Trig   Ext_Trig                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                                                   0	   RT_Update	   RT_Update                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                                                                                                                                                                  ph0   0 2
1 3
2 0
3 1                HP                                                     ph1   1 1
2 2
3 3
0 0 
                HP                                                     ph2   3 1
0 2
1 3
2 0                HP                                                     rf0:2   10
15
20
25
30
35
40
45                3R                                                     rf1:2+   60
64
68
72
76
80
84
88
92
96
100                3R                                                     rf2:2   20
30
40
50
60
70
80
90                3R                                                     rf3   0                3R                                                     rf4:2   30 32 34 36 38 40 42 44 46                 3R                                                     rf5:2   60 64 68 72 76 80 84 88 92                3R                                                     rf6:2   0
10
20
30
40
50
                3R                                                     rf7:2   0
20
40
60
80
100
                3R                                                            90amp       26                           90amp   26                  nrEchoes       16                           nrEchoes   16                  pw       6u      1n   1000s               pw   6u                  tEwait1      =[tE]/2-[pw]	      1n   1000s           tE^pw   tEwait1   =[tE]/2-[pw]                  tEwait2      =[tE]/2-[pw]/2-[Acq. Time]/2	      1n   1000s           tE^pw^Acq. Time   tEwait2   =[tE]/2-[pw]/2-[Acq. Time]/2                  tRep       1s      1n                   tRep   1s               LOCV      tE       150u       20u                   tE   100u           ����