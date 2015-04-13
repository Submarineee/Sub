.386
.model flat,stdcall
option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include vars.inc
include battleship.inc
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.data
dwShipX		 dd ?
dwShipY		 dd ?
dwShipWidth	 dd 66
dwShipHeight dd 26
dwShipSpeed  dd 10
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.code
_CreateBmp_Ship proc
	invoke LoadBitmap,hInstance,IDB_SHIP		
	mov hBitmap_ship, eax	  	  	  
	invoke LoadBitmap,hInstance, IDB_SHIP_MASK;	
	mov hBitmap_ship_mask,eax
	ret
_CreateBmp_Ship endp

_DestoryBmp_Ship proc
	invoke DeleteObject, hBitmap_ship
	invoke DeleteObject, hBitmap_ship_mask
	ret
_DestoryBmp_Ship endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_initShipParam proc uses eax ecx,
	;-------------------------
	;初始化战斗舰位置,屏幕中心
	;--------------------------
	local	@stRect:RECT
		invoke	GetClientRect,hWinMain, addr @stRect
		mov	eax,@stRect.right
		sub	eax,@stRect.left
		shr eax,1	;eax = 宽度
		mov	ecx,@stRect.top	
		add	ecx,dwSkyHeight
		sub	ecx,dwShipHeight		;ecx = 高度
		mov dwShipX, eax
		mov dwShipY, ecx
		ret
_initShipParam endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_DrawShip proc uses ebx, _hdc, _hMemDC
	;-------------------------
	;画船
	;-------------------------
	local @dwShipEndX, @dwShipEndY
	mov ebx, dwShipX
	add ebx, dwShipWidth
	mov @dwShipEndX, ebx
	mov ebx, dwShipY
	add ebx, dwShipHeight
	mov @dwShipEndY, ebx
	;上面的图的阴影部分
	invoke SelectObject,_hMemDC,hBitmap_ship_mask	  
	invoke BitBlt,_hdc,dwShipX,dwShipY,@dwShipEndX,@dwShipEndY,_hMemDC,0,0,SRCAND
	;上面的图
	invoke SelectObject,_hMemDC,hBitmap_ship
	invoke BitBlt,_hdc,dwShipX,dwShipY,@dwShipEndX,@dwShipEndY,_hMemDC,0,0,SRCPAINT
	ret
_DrawShip endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_MoveShip proc uses ebx, _direction
	;-------------------------
	;根据按键移动战斗舰
	;-------------------------
	local	@stRect:RECT
	invoke	GetClientRect,hWinMain,addr @stRect
	mov	eax,@stRect.right
	sub	eax,@stRect.left	;eax = 屏幕宽度
	mov ebx, dwShipX
	.if _direction == 0		;left
		sub ebx, dwShipSpeed
	.elseif _direction == 1	;right
		add ebx, dwShipSpeed
	.endif	
	.if ebx > 10					;在屏幕左边界内	
		sub eax, ebx		
		sub eax, dwShipWidth
		.if eax > 10				;在屏幕右边界内
			mov dwShipX, ebx
		.endif
	.endif
	ret
_MoveShip endp
end