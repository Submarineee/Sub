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
EXTERNDEF dwSub3: SUBMARINE
EXTERNDEF dwSub3UpperY :DWORD
EXTERNDEF dwSub3LowerY :DWORD
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_DrawSub3 PROTO, _hDC:DWORD, _hMemDC:DWORD
_ReleaseSub3 PROTO
_MoveSub3 PROTO
_CreateBmp_Sub3 PROTO
_DestoryBmp_Sub3 PROTO
