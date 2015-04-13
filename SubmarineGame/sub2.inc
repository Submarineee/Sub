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
EXTERNDEF dwSub2: SUBMARINE
EXTERNDEF dwSub2UpperY :DWORD
EXTERNDEF dwSub2LowerY :DWORD
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_DrawSub2 PROTO, _hDC :DWORD,_hMemDC:DWORD
_ReleaseSub2 PROTO
_MoveSub2 PROTO
_CreateBmp_Sub2 PROTO
_DestoryBmp_Sub2 PROTO
