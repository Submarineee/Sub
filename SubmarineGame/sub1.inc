include windows.inc
include user32.inc
include kernel32.inc
include gdi32.inc
includelib user32.lib
includelib kernel32.lib
includelib gdi32.lib
include msvcrt.inc
includelib msvcrt.lib
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include myStruct.inc
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
EXTERNDEF dwSub1 : SUBMARINE
EXTERNDEF dwSub1UpperY :DWORD
EXTERNDEF dwSub1LowerY :DWORD
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_DrawSub1 PROTO, _hDC :DWORD,_hMemDC:DWORD
_ReleaseSub1 PROTO
_MoveSub1 PROTO
_CreateBmp_Sub1 PROTO
_DestoryBmp_Sub1 PROTO

