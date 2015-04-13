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
	;��ʼ��ս����λ��,��Ļ����
	;--------------------------
	local	@stRect:RECT
		invoke	GetClientRect,hWinMain, addr @stRect
		mov	eax,@stRect.right
		sub	eax,@stRect.left
		shr eax,1	;eax = ���
		mov	ecx,@stRect.top	
		add	ecx,dwSkyHeight
		sub	ecx,dwShipHeight		;ecx = �߶�
		mov dwShipX, eax
		mov dwShipY, ecx
		ret
_initShipParam endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_DrawShip proc uses ebx, _hdc, _hMemDC
	;-------------------------
	;����
	;-------------------------
	local @dwShipEndX, @dwShipEndY
	mov ebx, dwShipX
	add ebx, dwShipWidth
	mov @dwShipEndX, ebx
	mov ebx, dwShipY
	add ebx, dwShipHeight
	mov @dwShipEndY, ebx
	;�����ͼ����Ӱ����
	invoke SelectObject,_hMemDC,hBitmap_ship_mask	  
	invoke BitBlt,_hdc,dwShipX,dwShipY,@dwShipEndX,@dwShipEndY,_hMemDC,0,0,SRCAND
	;�����ͼ
	invoke SelectObject,_hMemDC,hBitmap_ship
	invoke BitBlt,_hdc,dwShipX,dwShipY,@dwShipEndX,@dwShipEndY,_hMemDC,0,0,SRCPAINT
	ret
_DrawShip endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_MoveShip proc uses ebx, _direction
	;-------------------------
	;���ݰ����ƶ�ս����
	;-------------------------
	local	@stRect:RECT
	invoke	GetClientRect,hWinMain,addr @stRect
	mov	eax,@stRect.right
	sub	eax,@stRect.left	;eax = ��Ļ���
	mov ebx, dwShipX
	.if _direction == 0		;left
		sub ebx, dwShipSpeed
	.elseif _direction == 1	;right
		add ebx, dwShipSpeed
	.endif	
	.if ebx > 10					;����Ļ��߽���	
		sub eax, ebx		
		sub eax, dwShipWidth
		.if eax > 10				;����Ļ�ұ߽���
			mov dwShipX, ebx
		.endif
	.endif
	ret
_MoveShip endp
end