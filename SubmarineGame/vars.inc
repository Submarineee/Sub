;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
EXTERNDEF hWinMain:DWORD
EXTERNDEF hInstance:DWORD
EXTERNDEF dwSkyHeight:DWORD
EXTERNDEF dwSubWidth:DWORD
EXTERNDEF dwSubHeight:DWORD
EXTERNDEF dwWindowHeight:DWORD
EXTERNDEF dwWindowWidth:DWORD
EXTERNDEF dwWindowX:DWORD
EXTERNDEF dwWindowY:DWORD
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; hBitmap, 在vars.asm中定义
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
EXTERNDEF hBitmap_ship:DWORD
EXTERNDEF hBitmap_background:DWORD  
EXTERNDEF hBitmap_ship_mask:DWORD 
EXTERNDEF hBitmap_bomb_middle:DWORD 
EXTERNDEF hBitmap_bomb_middle_mask:DWORD 
EXTERNDEF hBitmap_bomb_left:DWORD 
EXTERNDEF hBitmap_bomb_left_mask:DWORD 
EXTERNDEF hBitmap_bomb_right:DWORD 
EXTERNDEF hBitmap_bomb_right_mask:DWORD 
EXTERNDEF hBitmap_sub1_left:DWORD 
EXTERNDEF hBitmap_sub1_left_mask:DWORD 
EXTERNDEF hBitmap_sub1_right:DWORD 
EXTERNDEF hBitmap_sub1_right_mask:DWORD 
EXTERNDEF hBitmap_sub2_left:DWORD 
EXTERNDEF hBitmap_sub2_left_mask:DWORD 
EXTERNDEF hBitmap_sub2_right:DWORD 
EXTERNDEF hBitmap_sub2_right_mask:DWORD 
EXTERNDEF hBitmap_sub3_left:DWORD 
EXTERNDEF hBitmap_sub3_left_mask:DWORD 
EXTERNDEF hBitmap_sub3_right:DWORD 
EXTERNDEF hBitmap_sub3_right_mask:DWORD 
EXTERNDEF hBitmap_torpedo:DWORD 
EXTERNDEF hBitmap_torpedo_mask:DWORD 
EXTERNDEF hBitmap_boom1:DWORD 
EXTERNDEF hBitmap_boom1_mask:DWORD 
EXTERNDEF hBitmap_boom2:DWORD 
EXTERNDEF hBitmap_boom2_mask:DWORD 
EXTERNDEF hBitmap_boom3:DWORD 
EXTERNDEF hBitmap_boom3_mask:DWORD 
EXTERNDEF hBitmap_boom4:DWORD 
EXTERNDEF hBitmap_boom4_mask:DWORD 
EXTERNDEF hBitmap_boom5:DWORD 
EXTERNDEF hBitmap_boom5_mask:DWORD 
EXTERNDEF hBitmap_boom6:DWORD 
EXTERNDEF hBitmap_boom6_mask:DWORD 
EXTERNDEF hBitmap_boom7:DWORD 
EXTERNDEF hBitmap_boom7_mask:DWORD 
EXTERNDEF hBitmap_boom8:DWORD 
EXTERNDEF hBitmap_boom8_mask:DWORD 
EXTERNDEF hBitmap_boom9:DWORD 
EXTERNDEF hBitmap_boom9_mask:DWORD 
EXTERNDEF hBitmap_boom10:DWORD 
EXTERNDEF hBitmap_boom10_mask:DWORD 
EXTERNDEF hBitmap_boom11:DWORD 
EXTERNDEF hBitmap_boom11_mask:DWORD 
EXTERNDEF hBitmap_boom12:DWORD 
EXTERNDEF hBitmap_boom12_mask:DWORD 
EXTERNDEF hBitmap_boom13:DWORD 
EXTERNDEF hBitmap_boom13_mask:DWORD 
EXTERNDEF hBitmap_boom14:DWORD 
EXTERNDEF hBitmap_boom14_mask:DWORD 
EXTERNDEF hBitmap_boom15:DWORD 
EXTERNDEF hBitmap_boom15_mask:DWORD 
EXTERNDEF hBitmap_boom16:DWORD 
EXTERNDEF hBitmap_boom16_mask:DWORD 
EXTERNDEF hBitmap_boom17:DWORD 
EXTERNDEF hBitmap_boom17_mask:DWORD 
EXTERNDEF hBitmap_boom18:DWORD 
EXTERNDEF hBitmap_boom18_mask:DWORD 
EXTERNDEF hBitmap_boom19:DWORD 
EXTERNDEF hBitmap_boom19_mask:DWORD 
EXTERNDEF hBitmap_boom20:DWORD 
EXTERNDEF hBitmap_boom20_mask:DWORD 
EXTERNDEF hBitmap_boom21:DWORD 
EXTERNDEF hBitmap_boom21_mask:DWORD 
EXTERNDEF hBitmap_boom22:DWORD 
EXTERNDEF hBitmap_boom22_mask:DWORD 

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; Equ 等值定义
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
IDB_SHIP	  equ 1
IDB_BACKGROUND	  equ 2
IDB_SHIP_MASK equ 3
IDB_BOMB_MIDDLE	  equ 4
IDB_BOMB_MIDDLE_MASK equ 5
IDB_BOMB_LEFT	  equ 10
IDB_BOMB_LEFT_MASK equ 11
IDB_BOMB_RIGHT	  equ 12
IDB_BOMB_RIGHT_MASK equ 13
IDB_SUB1_LEFT	  equ 6
IDB_SUB1_LEFT_MASK equ 7
IDB_SUB1_RIGHT	  equ 8
IDB_SUB1_RIGHT_MASK equ 9
IDB_SUB2_LEFT	  equ 14
IDB_SUB2_LEFT_MASK equ 15
IDB_SUB2_RIGHT	  equ 16
IDB_SUB2_RIGHT_MASK equ 17
IDB_SUB3_LEFT	  equ 18
IDB_SUB3_LEFT_MASK equ 19
IDB_SUB3_RIGHT	  equ 20
IDB_SUB3_RIGHT_MASK equ 21
ID_TIMER	  equ 100
ID_TIMER_BOMB equ 101
ID_TIMER_RANDOM equ 102
ID_TIMER_CHANGEPIC equ 103
IDB_TORPEDO equ 22
IDB_TORPEDO_MASK equ 23
IDB_BOOM1 equ 56
IDB_BOOM1_MASK equ 57
IDB_BOOM2 equ 58
IDB_BOOM2_MASK equ 59
IDB_BOOM3 equ 60
IDB_BOOM3_MASK equ 61
IDB_BOOM4 equ 62
IDB_BOOM4_MASK equ 63
IDB_BOOM5 equ 64
IDB_BOOM5_MASK equ 65
IDB_BOOM6 equ 66
IDB_BOOM6_MASK equ 67
IDB_BOOM7 equ 68
IDB_BOOM7_MASK equ 69
IDB_BOOM8 equ 70
IDB_BOOM8_MASK equ 71
IDB_BOOM9 equ 72
IDB_BOOM9_MASK equ 73
IDB_BOOM10 equ 74
IDB_BOOM10_MASK equ 75
IDB_BOOM11 equ 76
IDB_BOOM11_MASK equ 77
IDB_BOOM12 equ 99
IDB_BOOM12_MASK equ 78
IDB_BOOM13 equ 79
IDB_BOOM13_MASK equ 80
IDB_BOOM14 equ 81
IDB_BOOM14_MASK equ 82
IDB_BOOM15 equ 83
IDB_BOOM15_MASK equ 84
IDB_BOOM16 equ 85
IDB_BOOM16_MASK equ 86
IDB_BOOM17 equ 87
IDB_BOOM17_MASK equ 88
IDB_BOOM18 equ 89
IDB_BOOM18_MASK equ 90
IDB_BOOM19 equ 91
IDB_BOOM19_MASK equ 92
IDB_BOOM20 equ 93
IDB_BOOM20_MASK equ 94
IDB_BOOM21 equ 95
IDB_BOOM21_MASK equ 96
IDB_BOOM22 equ 97
IDB_BOOM22_MASK equ 98