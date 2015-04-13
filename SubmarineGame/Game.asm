.386
.model flat,stdcall
option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; Include 库文件
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
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
; Include 自定义文件
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include vars.inc
include battleship.inc
include bomb.inc
include rand.inc
include sub1.inc
include sub2.inc
include sub3.inc
include torpedo.inc
include explode.inc
include timer.inc
WinMain proto :DWORD,:DWORD,:DWORD,:DWORD
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; 数据段
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.data
ClassName db "SimpleWin32ASMBitmapClass",0
AppName  db "Win32ASM Simple Bitmap Example",0
CommandLine LPSTR ?
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; 代码段
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.code
_CreateBmp proc uses eax
	invoke LoadBitmap,hInstance,IDB_BACKGROUND		;背景图
	mov hBitmap_background,eax
	invoke _CreateBmp_Ship
	invoke _CreateBmp_Bomb	
	invoke _CreateBmp_Sub1
	invoke _CreateBmp_Sub2
	invoke _CreateBmp_Sub3	
	invoke _CreateBmp_Torpedo	
	invoke _CreateBmp_Explode
	ret
_CreateBmp endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_DestroyBmp proc
	invoke DeleteObject, hBitmap_background
	invoke _DestoryBmp_Ship
	invoke _DestoryBmp_Bomb
	invoke _DestoryBmp_Sub1
	invoke _DestoryBmp_Sub2
	invoke _DestoryBmp_Sub3
	invoke _DestoryBmp_Torpedo
	invoke _DestoryBmp_Explode	
	ret
_DestroyBmp endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
start:
	invoke GetModuleHandle, NULL
	mov    hInstance,eax
	invoke GetCommandLine
	mov    CommandLine,eax
	invoke WinMain, hInstance,NULL,CommandLine, SW_SHOWDEFAULT
	invoke ExitProcess,eax
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
WinMain proc hInst:HINSTANCE,hPrevInst:HINSTANCE,CmdLine:LPSTR,CmdShow:DWORD
	LOCAL wc:WNDCLASSEX
	LOCAL msg:MSG
	LOCAL hwnd:HWND
	mov   wc.cbSize,SIZEOF WNDCLASSEX
	mov   wc.style, CS_HREDRAW or CS_VREDRAW
	mov   wc.lpfnWndProc, OFFSET WndProc
	mov   wc.cbClsExtra,NULL
	mov   wc.cbWndExtra,NULL
	push  hInstance
	pop   wc.hInstance
	mov   wc.hbrBackground,COLOR_WINDOW+1
	mov   wc.lpszMenuName,NULL
	mov   wc.lpszClassName,OFFSET ClassName
	invoke LoadIcon,NULL,IDI_APPLICATION
	mov   wc.hIcon,eax
	mov   wc.hIconSm,eax
	invoke LoadCursor,NULL,IDC_ARROW
	mov   wc.hCursor,eax
	invoke RegisterClassEx, addr wc
	INVOKE CreateWindowEx,NULL,ADDR ClassName,ADDR AppName,\
		   WS_OVERLAPPED or WS_CAPTION or WS_SYSMENU ,\
		   dwWindowX,dwWindowY,dwWindowWidth,dwWindowHeight,NULL,NULL,\
		   hInst,NULL
	mov   hwnd,eax
	mov   hWinMain,eax
	invoke ShowWindow, hwnd,SW_SHOWNORMAL
	invoke UpdateWindow, hwnd
	.while TRUE
		invoke GetMessage, ADDR msg,NULL,0,0
		.break .if (!eax)
		invoke TranslateMessage, ADDR msg
		invoke DispatchMessage, ADDR msg
	.endw
	mov     eax,msg.wParam
	ret
WinMain endp

WndProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
   LOCAL ps:PAINTSTRUCT
   LOCAL hdc:HDC
   LOCAL hMemDC:HDC
   LOCAL rect:RECT
   ;加载图片
   .if uMsg==WM_CREATE 
		invoke _CreateBmp
	;初始化
	.elseif uMsg == WM_SIZE
		invoke  _initShipParam
		invoke  _SetTimer
	;按键反应	
	.elseif uMsg == WM_KEYDOWN
		mov eax, wParam
		.if ax == VK_LEFT
			invoke _MoveShip, 0
		.elseif ax == VK_RIGHT
			invoke _MoveShip, 1	
		.elseif ax == VK_Z
			invoke _ReleaseBomb, 0
		.elseif ax == VK_X
			invoke _ReleaseBomb, 1
		.elseif ax == VK_C
			invoke _ReleaseBomb, 2	
		.endif
		invoke	InvalidateRect,hWnd,NULL,FALSE
	;定时器消息，让整个客户区失效，重新绘制WM_Paint
	;InvalidRect函数最后的True参数要求把整个客户区清除成背景色
	.elseif	uMsg ==	WM_TIMER
		mov	eax,wParam
		.if	eax ==	ID_TIMER
			invoke	InvalidateRect,hWnd,NULL,FALSE
			invoke _MoveSub1
			invoke _MoveSub2
			invoke _MoveSub3
			invoke _BombSub
			invoke _BoomSub
		.elseif eax == ID_TIMER_BOMB
			invoke _DropBomb
			invoke _FloatTorpedo
			invoke _ChangeBoomPic
		.elseif eax == ID_TIMER_RANDOM
			invoke _iRand, 1, 3
			.if eax == 1
				invoke _ReleaseSub1
			.elseif eax == 2
				invoke _ReleaseSub2
			.elseif eax == 3
				invoke _ReleaseSub3
			.endif
		.elseif eax == ID_TIMER_CHANGEPIC
			invoke _ChangeBombPic
		.endif
	;画图片
   .elseif uMsg==WM_PAINT 
		invoke BeginPaint,hWnd,addr ps
		mov hdc,eax
		invoke CreateCompatibleDC,hdc
		mov hMemDC,eax
		invoke GetClientRect,hWnd,addr rect		
		invoke SelectObject,hMemDC,hBitmap_background	;背景图
		invoke BitBlt,hdc,0,0,rect.right,rect.bottom,hMemDC,0,0,SRCCOPY
		invoke _DrawBomb, hdc, hMemDC		;画炸弹
		invoke _DrawShip, hdc, hMemDC		;画战舰
		invoke _DrawSub1, hdc, hMemDC		;画潜艇1
		invoke _DrawSub2, hdc, hMemDC		;画潜艇2
		invoke _DrawSub3, hdc, hMemDC		;画潜艇3
		invoke _DrawBoom, hdc, hMemDC		;画爆炸效果
		invoke _DrawTorpedo, hdc, hMemDC		;画鱼雷
		invoke DeleteDC,hMemDC
		invoke EndPaint,hWnd,addr ps
	;清理
	.elseif uMsg==WM_DESTROY
		invoke _DestroyBmp
		invoke _KillTimer
		invoke PostQuitMessage,NULL
	.ELSE
		invoke DefWindowProc,hWnd,uMsg,wParam,lParam		
		ret
	.ENDIF
	xor eax,eax
	ret
WndProc endp
end start
