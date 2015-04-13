.386
.model flat,stdcall
option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include vars.inc
include battleship.inc
include sub3.inc
include rand.inc
include torpedo.inc
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.data
dwSub3 SUBMARINE 1 dup(<0, 0, 0, 0, 0>)
dwSub3UpperY dd 310
dwSub3LowerY dd 410
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.code
_CreateBmp_Sub3 proc
	invoke LoadBitmap, hInstance,IDB_SUB3_LEFT   	;Ǳͧ3
	mov hBitmap_sub3_left, eax
	invoke LoadBitmap, hInstance,IDB_SUB3_LEFT_MASK
	mov hBitmap_sub3_left_mask, eax
	invoke LoadBitmap, hInstance,IDB_SUB3_RIGHT
	mov hBitmap_sub3_right, eax
	invoke LoadBitmap, hInstance,IDB_SUB3_RIGHT_MASK
	mov hBitmap_sub3_right_mask, eax
	ret
_CreateBmp_Sub3 endp
_DestoryBmp_Sub3 proc
	invoke DeleteObject, hBitmap_sub3_left
	invoke DeleteObject, hBitmap_sub3_left_mask
	invoke DeleteObject, hBitmap_sub3_right
	invoke DeleteObject, hBitmap_sub3_right_mask
	ret
_DestoryBmp_Sub3 endp
_DrawSub3 proc uses esi eax ebx, _hDC, _hMemDC
;-----------------
; �滭Ǳͧ3
;-----------------
	local  @subX1:SDWORD, @subY1:DWORD, @subX2:SDWORD, @subY2:DWORD, @count:DWORD

	mov esi, OFFSET dwSub3
	assume esi : PTR SUBMARINE
	mov @count, LENGTHOF dwSub3
CountLoop:	
	mov eax, [esi].X
	mov ebx, [esi].Y
	.if (eax > 0) || (ebx > 0)
		mov @subX1, eax
		mov @subY1, ebx
		add eax, dwSubWidth
		add ebx, dwSubHeight
		mov @subX2, eax
		mov @subY2, ebx
		.if [esi].DIRECTION == 0
			invoke SelectObject,_hMemDC,hBitmap_sub3_left_mask	  
			invoke BitBlt,_hDC,@subX1, @subY1, @subX2, @subY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_sub3_left
			invoke BitBlt,_hDC,@subX1, @subY1, @subX2, @subY2,_hMemDC,0,0,SRCPAINT
		.elseif [esi].DIRECTION == 1
			invoke SelectObject,_hMemDC,hBitmap_sub3_right_mask	  
			invoke BitBlt,_hDC,@subX1, @subY1, @subX2, @subY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_sub3_right
			invoke BitBlt,_hDC,@subX1, @subY1, @subX2, @subY2,_hMemDC,0,0,SRCPAINT
		.endif
	.endif
	add esi, TYPE SUBMARINE
	sub @count, 1
	.if @count > 0
		jmp CountLoop
	.endif
	assume esi: nothing
	ret
_DrawSub3 endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_ReleaseSub3 proc uses eax ecx edx esi,
;-----------------
;����Ǳͧ3
;-----------------
	local @subY, @speed, @direction, @count, @stRect:RECT, @height, @width
	invoke	GetClientRect,hWinMain,addr @stRect
	mov	eax,@stRect.bottom
	sub eax,@stRect.top	
	mov	@height,eax		;height = �߶�
	mov	eax,@stRect.right
	sub	eax,@stRect.left		;width = ���
	mov	@width,eax
	;���ȷ��Ǳͧ3��λ��
	invoke _iRand, dwSub3UpperY, dwSub3LowerY
	mov @subY, eax
	;���ȷ��Ǳͧ3���ٶ�
	invoke _iRand, 2, 6
	mov @speed, eax
	;���ȷ��Ǳͧ3�ķ���0��1��
	invoke _iRand, 0, 1
	mov @direction, eax
	;����Ǳͧ3��������
	mov esi, OFFSET dwSub3
	assume esi:PTR SUBMARINE
	mov @count, LENGTHOF dwSub3	;count = length of dwSub3
CountLoop:
	mov ecx, [esi].X
	mov edx, [esi].Y
	.if (ecx == 0) && (edx == 0)	;�Ƿ��п�Ǳͧ3
		mov eax, @subY
		mov [esi].Y, eax
		mov eax, @speed
		mov [esi].SPEED, eax
		mov [esi].CARRYBOMB, 1
		mov eax, @direction
		mov [esi].DIRECTION, eax
		.if (@direction == 0)
			mov eax, @width
			mov [esi].X, eax
		.else
			mov eax, 0
			sub eax, dwSubWidth
			mov [esi].X, eax
		.endif
		mov @count, 1
	.endif
	add esi, TYPE SUBMARINE
	sub @count, 1
	.if @count > 0
		jmp CountLoop
	.endif

	assume esi: nothing
	ret
_ReleaseSub3 endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_MoveSub3 proc uses ecx esi ebx eax,
;-----------------
;Ǳͧ3�ƶ�
;-----------------
	local @count,@stRect:RECT,@width:SDWORD,@left:SDWORD
	invoke	GetClientRect,hWinMain,addr @stRect
	mov	ecx,@stRect.right
	sub	ecx,@stRect.left
	mov @width,ecx		;width = ���
	mov esi, OFFSET dwSub3	;esi = dwSub3
	assume esi : PTR SUBMARINE
	mov @count, LENGTHOF dwSub3	;count = length of dwSub3
CountLoop:
	mov eax, [esi].X
	mov ebx, [esi].Y
	.if (eax > 0) || (ebx > 0)	;Ǳͧ3�Ƿ񱻴���
		.if [esi].DIRECTION == 0
			sub eax, [esi].SPEED
			mov [esi].X, eax
			mov ecx,0
			sub ecx,dwSubWidth
			mov @left,ecx
			.if eax < @left				;�Ѿ�ͨ�����
				mov [esi].X, 0
				mov [esi].Y, 0
			.endif
		.elseif [esi].DIRECTION == 1
			add eax, [esi].SPEED
			mov [esi].X, eax
			.if eax > @width				;�Ѿ�ͨ���Ҷ�
				mov [esi].X, 0
				mov [esi].Y, 0
			.endif
		.endif
	.endif	
	add esi, TYPE SUBMARINE
	sub @count, 1
	.if @count > 0
		jmp CountLoop
	.endif
	assume esi: nothing
	ret
_MoveSub3 endp
end