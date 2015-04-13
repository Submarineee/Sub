include windows.inc
include user32.inc
include kernel32.inc
include gdi32.inc
includelib user32.lib
includelib kernel32.lib
includelib gdi32.lib
include msvcrt.inc
includelib msvcrt.lib
include vars.inc
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
EXTERNDEF dwShipX		 :DWORD
EXTERNDEF dwShipY		 :DWORD
EXTERNDEF dwShipWidth	 :DWORD
EXTERNDEF dwShipHeight	 :DWORD
EXTERNDEF dwShipSpeed    :DWORD
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_initShipParam PROTO
_DrawShip PROTO, 
	_hdc:DWORD, 
	_hMemDC:DWORD
_MoveShip PROTO, 
	_direction:DWORD
_CreateBmp_Ship PROTO
_DestoryBmp_Ship PROTO