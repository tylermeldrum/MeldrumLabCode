PSEQ1.001.18 BIN   CPMG_vary_pw          NMRLab@AC-ISC1026LAB2   �h�S                                           Name:   Name:                                                           Phase Reset                                                        
   StartDelay                                                        
   FirstPulse                                                        
   FirstDelay                                                           SecondPulse                                                        
   LoopDelay1                                                           Acq                                                        
   LoopDelay2                                                           tRep                                                                                                                                               1u   Delay   Delay                                                           5u                                                           10u                                                           =pw                                                           =tEwait1                                                           =pw                                                           =tEwait2                                                        
   =Acq. Time                                                           =tEwait2                                                           =trep                                                           1u                                                            1ME   XT                0   F1_PhRst   F1_PhRst                                                           1                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           1PE   3R                0   F1_Ampl   F1_Ampl                                                           0                                                           0                                                           =90amp                   rf0:2                                      0                                                           =180amp                   rf1:2                                      0                                                           0                                                           0                                                           0                                                           0                                                           1ME   HP                -1   F1_Ph   F1_Ph                                                           -1                                                           -1                                                           -1           ph0                                              -1                                                           -1           ph1                                              -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           1PE   3P                -1   F1_PhMod   F1_PhMod                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           1ME   XT                0   F1_HOP   F1_HOP                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           1ME   XT                0
   F1_UnBlank
   F1_UnBlank                                                           0                                                           1                                                           1                                                           1                                                           1                                                           0                                                           0                                                           1                                                           0                                                           0                                                           1QA   CA                0   Acq   Acq                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           1                                                          64   500000.0 Hz   500000.0 Hz   1u   64u        0                                                           0                                                           0                                                           1QA   HP                -1	   Acq_phase	   Acq_phase                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1                                                           -1           ph2                                              -1                                                           -1                                                           -1                                                           1ME   XT                0   Rx_Blank   Rx_Blank                                                           0                                                           1                                                           1                                                           1                                                           1                                                           0                                                           0                                                           1                                                           0                                                           0                                                           1ME   XT                0
   Scope_Trig
   Scope_Trig                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                                                  0   Loop   Loop                                                           0                                                           0                                                           0                                                           0                                                        	   =nrEchoes                                                           0                                                           0                                                           -1                                                           0                                                           0                                                                                   0   CBranch   CBranch                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                                                   0   CTest   CTest                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                                                   0   Ext_Trig   Ext_Trig                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                                                   0	   RT_Update	   RT_Update                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                           0                                                                                                                                                                                                  ph0   0 2                HP                                                     ph1   1 1                HP                                                     ph2   1 3                HP                                                     rf0:2�   0
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
                3R                                                     rf1:2�   0
2
4
6
8
10
12
14
16
18
20
22
24
26
28
30
32
34
36
38
40
42
44
46
48
50
52
54
56
58
60
62
64
66
68
70
72
74
76
78
80
82
84
86
88
90
92
94
96
98
100
                3R                                                            180amp   
   =[90amp]*2	                      90amp   180amp                      90amp       0                           90amp                      nrEchoes       16                           nrEchoes                      pw       3      1n   1000s               pw                      tEwait1      =[tE]/2-[pw]	      1n   1000s           tE^pw   tEwait1                      tEwait2      =[tE]/2-[pw]/2-[Acq. Time]/2	      1n   1000s           tE^pw^Acq. Time   tEwait2                      trep       1s      1n   1000s               trep                   LOCV      tE       150u       20u                   tE   100u           ����