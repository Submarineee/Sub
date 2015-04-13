.386
.model flat,stdcall
option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include vars.inc
include battleship.inc
include torpedo.inc
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.data
dwTorpedo TORPEDO 30 dup(<0, 0, 0>)
dwTorpedoWidth	 dd 10
dwTorpedoHeight dd 10
dwTorpedoSpeed	 dd 2
dwTorpedoFromSubX	 dd 20
dwTorpedoTimeCount	 dd 10
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.code
_CreateBmp_Torpedo proc	
	invoke LoadBitmap, hInstance,IDB_TORPEDO   	;ÓãÀ×
	mov hBitmap_torpedo, eax
	invoke LoadBitmap, hInstance,IDB_TORPEDO_MASK
	mov hBitmap_torpedo_mask, eax	
	ret
_CreateBmp_Torpedo endp

_DestoryBmp_Torpedo proc
	invoke DeleteObject, hBitmap_torpedo
	invoke DeleteObject, hBitmap_torpedo_mask
	ret
_DestoryBmp_Torpedo endp

_DrawTorpedo proc uses esi ecx eax ebx, _hDC, _hMemDC
;-----------------
; »æ»­ÓãÀ×
;-----------------
	local  @TorpedoX1:DWORD, @TorpedoY1:DWORD, @TorpedoX2:DWORD, @TorpedoY2:DWORD, @count:DWORD
	mov esi, OFFSET dwTorpedo
	assume esi : PTR TORPEDO
	mov @count, LENGTHOF dwTorpedo
CountLoop:	
	mov eax, [esi].X
	mov ebx, [esi].Y
	.if (eax > 0) || (ebx > 0)
		mov @TorpedoX1, eax
		mov @TorpedoY1, ebx
		add eax, dwTorpedoWidth
		add ebx, dwTorpedoHeight
		mov @TorpedoX2, eax
		mov @TorpedoY2, ebx
		invoke SelectObject,_hMemDC,hBitmap_torpedo_mask	  
		invoke BitBlt,_hDC,@TorpedoX1, @TorpedoY1, @TorpedoX2, @TorpedoY2,_hMemDC,0,0,SRCAND
		invoke SelectObject,_hMemDC,hBitmap_torpedo
		invoke BitBlt,_hDC,@TorpedoX1, @TorpedoY1, @TorpedoX2, @TorpedoY2,_hMemDC,0,0,SRCPAINT
	.endif
	add esi, TYPE TORPEDO
	sub @count, 1
	.if @count > 0
		jmp CountLoop
	.endif
	assume esi: nothing
	ret
_DrawTorpedo endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_FloatTorpedo proc uses ecx esi ebx eax,
;-----------------
;ÓãÀ×Æ¯¸¡
;-----------------
	local @count
	mov esi, OFFSET dwTorpedo	;esi = dwTorpedo
	assume esi : PTR TORPEDO
	mov @count, LENGTHOF dwTorpedo	;count = length of dwTorpedo
CountLoop:
	mov eax, dwTorpedoHeight
	shr eax, 1
	mov ecx, dwSkyHeight
	sub ecx, eax
	mov eax, [esi].X
	mov ebx, [esi].Y
	.if (ebx > ecx)
		sub ebx, dwTorpedoSpeed
		mov [esi].Y, ebx
	.elseif (ebx > 0)
		inc [esi].TIMECOUNT
	.endif
	mov ebx, [esi].TIMECOUNT
	.if ebx > dwTorpedoTimeCount
		mov [esi].X, 0
		mov [esi].Y, 0
		mov [esi].TIMECOUNT, 0
	.endif
	add esi, TYPE TORPEDO
	sub @count, 1
	.if @count > 0
		jmp CountLoop
	.endif
	assume esi: nothing
	ret
_FloatTorpedo endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_ReleaseTorpedo proc uses eax ebx ecx esi, _SubX, _SubY, _direction
;-----------------
;ÊÍ·ÅÅÚµ¯
;-----------------
	local @TorpedoX, @TorpedoY, @count
	mov eax, _SubX		;TorpedoX
	mov ebx, _SubY		;TorpedoY
	;¸ù¾Ý°´¼ü£¬È·¶¨ÓãÀ×·¢ÉäµÄÎ»ÖÃ£¬0×ó1ÓÒ
	.if _direction == 0
		add eax, dwTorpedoFromSubX
	.elseif _direction == 1
		add eax, dwSubWidth
		sub eax, dwTorpedoFromSubX
	.endif
	;¸üÐÂÓãÀ××ø±êÊý×é
	mov esi, OFFSET dwTorpedo
	assume esi:PTR TORPEDO
	mov @count, LENGTHOF dwTorpedo	;count = length of dwTorpedo
CountLoop:
	mov ecx, [esi].X
	mov edx, [esi].Y
	.if (ecx == 0) && (edx == 0)	;ÊÇ·ñÓÐ¿ÕÓãÀ×
		mov [esi].X, eax
		mov [esi].Y, ebx
		mov [esi].TIMECOUNT, 0
		mov @count, 1
	.endif
	add esi, TYPE TORPEDO
	sub @count, 1
	.if @count > 0
		jmp CountLoop
	.endif

	assume esi: nothing
	ret
_ReleaseTorpedo endp

end