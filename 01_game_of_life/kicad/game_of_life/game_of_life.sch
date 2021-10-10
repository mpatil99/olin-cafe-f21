EESchema Schematic File Version 4
LIBS:game_of_life-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 11
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Sheet
S 1380 1750 510  430 
U 6161E013
F0 "HalfAdder1" 50
F1 "halfadder.sch" 50
F2 "Sum" I R 1890 1860 50 
F3 "Cout" I R 1890 2040 50 
F4 "A" I L 1380 1860 50 
F5 "B" I L 1380 2040 50 
$EndSheet
$Sheet
S 1380 2450 510  430 
U 61621DCF
F0 "HalfAdder2" 50
F1 "halfadder.sch" 50
F2 "Sum" I R 1890 2560 50 
F3 "Cout" I R 1890 2740 50 
F4 "A" I L 1380 2560 50 
F5 "B" I L 1380 2740 50 
$EndSheet
$Sheet
S 1370 1050 510  430 
U 61621E5D
F0 "HalfAdder0" 50
F1 "halfadder.sch" 50
F2 "Sum" I R 1880 1160 50 
F3 "Cout" I R 1880 1340 50 
F4 "A" I L 1370 1160 50 
F5 "B" I L 1370 1340 50 
$EndSheet
$Sheet
S 1390 3150 510  430 
U 61621E6C
F0 "HalfAdder3" 50
F1 "halfadder.sch" 50
F2 "Sum" I R 1900 3260 50 
F3 "Cout" I R 1900 3440 50 
F4 "A" I L 1390 3260 50 
F5 "B" I L 1390 3440 50 
$EndSheet
$Sheet
S 2510 2450 510  430 
U 61621EA9
F0 "HalfAdder6" 50
F1 "halfadder.sch" 50
F2 "Sum" I R 3020 2560 50 
F3 "Cout" I R 3020 2740 50 
F4 "A" I L 2510 2560 50 
F5 "B" I L 2510 2740 50 
$EndSheet
$Sheet
S 2490 1050 510  430 
U 61621EAF
F0 "HalfAdder4" 50
F1 "halfadder.sch" 50
F2 "Sum" I R 3000 1160 50 
F3 "Cout" I R 3000 1340 50 
F4 "A" I L 2490 1160 50 
F5 "B" I L 2490 1340 50 
$EndSheet
$Sheet
S 2500 3150 510  430 
U 61621EB5
F0 "HalfAdder7" 50
F1 "halfadder.sch" 50
F2 "Sum" I R 3010 3260 50 
F3 "Cout" I R 3010 3440 50 
F4 "A" I L 2500 3260 50 
F5 "B" I L 2500 3440 50 
$EndSheet
Text Label 1270 1160 0    50   ~ 0
0
Text Label 1270 1340 0    50   ~ 0
1
Text Label 1270 1860 0    50   ~ 0
2
Text Label 1270 2040 0    50   ~ 0
3
Text Label 1300 3260 0    50   ~ 0
6
Text Label 1300 3440 0    50   ~ 0
7
Text Label 1270 2560 0    50   ~ 0
4
Text Label 1270 2740 0    50   ~ 0
5
Wire Wire Line
	1270 1160 1370 1160
Wire Wire Line
	1270 1340 1370 1340
Wire Wire Line
	1270 1860 1380 1860
Wire Wire Line
	1270 2040 1380 2040
Wire Wire Line
	1270 2560 1380 2560
Wire Wire Line
	1270 2740 1380 2740
Wire Wire Line
	1300 3260 1390 3260
Wire Wire Line
	1300 3440 1390 3440
Wire Wire Line
	1880 1160 2490 1160
Wire Wire Line
	1890 2040 2490 2040
Wire Wire Line
	1940 1340 1880 1340
Text Label 1940 1340 0    50   ~ 0
C0
Text Label 2390 1860 2    50   ~ 0
C0
Wire Wire Line
	2390 1860 2490 1860
Wire Wire Line
	1890 1860 2140 1860
Wire Wire Line
	2140 1860 2140 1340
Wire Wire Line
	2140 1340 2490 1340
Wire Wire Line
	1900 3440 2500 3440
Wire Wire Line
	1950 2740 1890 2740
Text Label 1950 2740 0    50   ~ 0
C2
Text Label 2400 3260 2    50   ~ 0
C2
Wire Wire Line
	2400 3260 2500 3260
Wire Wire Line
	1900 3260 2150 3260
Wire Wire Line
	2150 3260 2150 2740
Text Label 5050 1760 0    50   ~ 0
S8
Wire Wire Line
	4960 1760 5050 1760
Text Label 3100 3440 0    50   ~ 0
C7
Wire Wire Line
	3010 3440 3100 3440
$Comp
L 74xx:74LS32 U1
U 1 1 616236C9
P 3670 1590
F 0 "U1" H 3670 1915 50  0000 C CNN
F 1 "74LS32" H 3670 1824 50  0000 C CNN
F 2 "" H 3670 1590 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS32" H 3670 1590 50  0001 C CNN
	1    3670 1590
	1    0    0    -1  
$EndComp
Wire Wire Line
	3000 1340 3370 1340
Wire Wire Line
	3370 1340 3370 1490
Wire Wire Line
	3000 1860 3370 1860
Wire Wire Line
	3370 1860 3370 1690
$Comp
L 74xx:74LS32 U2
U 1 1 6162490A
P 3690 2990
F 0 "U2" H 3690 3315 50  0000 C CNN
F 1 "74LS32" H 3690 3224 50  0000 C CNN
F 2 "" H 3690 2990 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS32" H 3690 2990 50  0001 C CNN
	1    3690 2990
	1    0    0    -1  
$EndComp
Wire Wire Line
	3020 2740 3390 2740
Wire Wire Line
	3390 2740 3390 2890
Wire Wire Line
	3390 3260 3390 3090
$Sheet
S 4460 2350 510  430 
U 61624DA1
F0 "HalfAdder9" 50
F1 "halfadder.sch" 50
F2 "Sum" I R 4970 2460 50 
F3 "Cout" I R 4970 2640 50 
F4 "A" I L 4460 2460 50 
F5 "B" I L 4460 2640 50 
$EndSheet
Wire Wire Line
	4350 1760 4450 1760
Wire Wire Line
	3990 2990 3990 2640
Wire Wire Line
	3990 2640 4460 2640
Wire Wire Line
	3000 1160 4350 1160
Wire Wire Line
	4350 1160 4350 1760
Text Label 3120 2560 0    50   ~ 0
S6
Wire Wire Line
	3020 2560 3120 2560
Wire Wire Line
	4450 1940 4350 1940
Text Label 4350 1940 2    50   ~ 0
S6
Wire Wire Line
	3970 1590 3970 2460
Wire Wire Line
	3970 2460 4460 2460
Wire Wire Line
	1890 2560 2510 2560
Wire Wire Line
	2150 2740 2510 2740
$Sheet
S 4450 1650 510  430 
U 61624DA7
F0 "HalfAdder8" 50
F1 "halfadder.sch" 50
F2 "Sum" I R 4960 1760 50 
F3 "Cout" I R 4960 1940 50 
F4 "A" I L 4450 1760 50 
F5 "B" I L 4450 1940 50 
$EndSheet
Wire Wire Line
	4960 1940 5050 1940
Text Label 5050 1940 0    50   ~ 0
C8
Wire Wire Line
	4970 2460 5060 2460
Text Label 5060 2460 0    50   ~ 0
S9
Wire Wire Line
	4970 2640 5060 2640
Text Label 5060 2640 0    50   ~ 0
C9
Wire Wire Line
	3000 2040 3090 2040
Text Label 3090 2040 0    50   ~ 0
C5
$Sheet
S 2490 1750 510  430 
U 6162FE84
F0 "HalfAdder5" 50
F1 "halfadder.sch" 50
F2 "Sum" I R 3000 1860 50 
F3 "Cout" I R 3000 2040 50 
F4 "A" I L 2490 1860 50 
F5 "B" I L 2490 2040 50 
$EndSheet
Wire Wire Line
	3010 3260 3390 3260
Text Label 2150 1160 0    50   ~ 0
S0
Text Label 2140 1580 0    50   ~ 0
S1
Text Label 2160 2040 0    50   ~ 0
C1
Text Label 2160 2560 0    50   ~ 0
S2
Text Label 2150 2980 0    50   ~ 0
S3
Text Label 2160 3440 0    50   ~ 0
C3
Text Label 3110 3260 0    50   ~ 0
S7
Text Label 3120 2740 0    50   ~ 0
C6
Text Label 3090 1860 0    50   ~ 0
S5
Text Label 3110 1340 0    50   ~ 0
C4
Text Label 3110 1160 0    50   ~ 0
S4
$EndSCHEMATC
