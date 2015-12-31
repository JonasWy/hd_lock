00000000  8CC8              mov ax,cs
00000002  8ED8              mov ds,ax
00000004  8ED0              mov ss,ax
00000006  8EC0              mov es,ax
00000008  BC0001            mov sp,0x100
0000000B  BD007D            mov bp,0x7d00
0000000E  B98300            mov cx,0x83
00000011  B80113            mov ax,0x1301
00000014  BB0C00            mov bx,0xc
00000017  B200              mov dl,0x0
00000019  CD10              int 0x10
0000001B  B800B8            mov ax,0xb800
0000001E  05A000            add ax,0xa0
00000021  8ED8              mov ds,ax
00000023  31C9              xor cx,cx
00000025  31DB              xor bx,bx
00000027  31C0              xor ax,ax
00000029  CD16              int 0x16
0000002B  3C08              cmp al,0x8
0000002D  741B              jz 0x4a
0000002F  3C0D              cmp al,0xd
00000031  7426              jz 0x59
00000033  B402              mov ah,0x2
00000035  8807              mov [bx],al
00000037  886701            mov [bx+0x1],ah
0000003A  30C0              xor al,al
0000003C  884702            mov [bx+0x2],al
0000003F  83C302            add bx,byte +0x2
00000042  41                inc cx
00000043  2E890EFF7C        mov [cs:0x7cff],cx
00000048  EBDD              jmp short 0x27
0000004A  83EB02            sub bx,byte +0x2
0000004D  49                dec cx
0000004E  2E890EFF7C        mov [cs:0x7cff],cx
00000053  31C0              xor ax,ax
00000055  8907              mov [bx],ax
00000057  EBCE              jmp short 0x27
00000059  8CC8              mov ax,cs
0000005B  8EC0              mov es,ax
0000005D  31DB              xor bx,bx
0000005F  3E8A07            mov al,[ds:bx]
00000062  3C43              cmp al,0x43
00000064  7573              jnz 0xd9
00000066  83C302            add bx,byte +0x2
00000069  3E8A07            mov al,[ds:bx]
0000006C  3C61              cmp al,0x61
0000006E  7569              jnz 0xd9
00000070  83C302            add bx,byte +0x2
00000073  3E8A07            mov al,[ds:bx]
00000076  3C4D              cmp al,0x4d
00000078  755F              jnz 0xd9
0000007A  83C302            add bx,byte +0x2
0000007D  B1FF              mov cl,0xff
0000007F  B500              mov ch,0x0
00000081  2E882EFE7C        mov [cs:0x7cfe],ch
00000086  3E8A07            mov al,[ds:bx]
00000089  3C00              cmp al,0x0
0000008B  740A              jz 0x97
0000008D  2E3006FE7C        xor [cs:0x7cfe],al
00000092  83C302            add bx,byte +0x2
00000095  E2EF              loop 0x86
00000097  B8007E            mov ax,0x7e00
0000009A  8EC0              mov es,ax
0000009C  31DB              xor bx,bx
0000009E  B402              mov ah,0x2
000000A0  B280              mov dl,0x80
000000A2  B001              mov al,0x1
000000A4  B600              mov dh,0x0
000000A6  B500              mov ch,0x0
000000A8  B103              mov cl,0x3
000000AA  CD13              int 0x13
000000AC  BBBD01            mov bx,0x1bd
000000AF  30ED              xor ch,ch
000000B1  26882F            mov [es:bx],ch
000000B4  BBBE01            mov bx,0x1be
000000B7  B140              mov cl,0x40
000000B9  268A07            mov al,[es:bx]
000000BC  2E3206FE7C        xor al,[cs:0x7cfe]
000000C1  268807            mov [es:bx],al
000000C4  43                inc bx
000000C5  E2F2              loop 0xb9
000000C7  31DB              xor bx,bx
000000C9  B403              mov ah,0x3
000000CB  B280              mov dl,0x80
000000CD  B001              mov al,0x1
000000CF  B600              mov dh,0x0
000000D1  B500              mov ch,0x0
000000D3  B101              mov cl,0x1
000000D5  CD13              int 0x13
000000D7  EB1C              jmp short 0xf5
000000D9  BB00B8            mov bx,0xb800
000000DC  81C38300          add bx,0x83
000000E0  B058              mov al,0x58
000000E2  8807              mov [bx],al
000000E4  2E8B0EFF7C        mov cx,[cs:0x7cff]
000000E9  31C0              xor ax,ax
000000EB  8907              mov [bx],ax
000000ED  83C302            add bx,byte +0x2
000000F0  E2F9              loop 0xeb
000000F2  E90BFF            jmp word 0x0
000000F5  B8FFFF            mov ax,0xffff
000000F8  50                push ax
000000F9  B80000            mov ax,0x0
000000FC  50                push ax
000000FD  CB                retf
000000FE  0000              add [bx+si],al
00000100  59                pop cx
00000101  6F                outsw
00000102  7572              jnz 0x176
00000104  20636F            and [bp+di+0x6f],ah
00000107  6D                insw
00000108  7075              jo 0x17f
0000010A  7465              jz 0x171
0000010C  7220              jc 0x12e
0000010E  7761              ja 0x171
00000110  7320              jnc 0x132
00000112  6C                insb
00000113  6F                outsw
00000114  636B65            arpl [bp+di+0x65],bp
00000117  642C20            fs sub al,0x20
0000011A  636F6E            arpl [bx+0x6e],bp
0000011D  7461              jz 0x180
0000011F  637420            arpl [si+0x20],si
00000122  51                push cx
00000123  3A363931          cmp dh,[0x3139]
00000127  37                aaa
00000128  3134              xor [si],si
0000012A  353434            xor ax,0x3434
0000012D  202C              and [si],ch
0000012F  20616E            and [bx+di+0x6e],ah
00000132  64204920          and [fs:bx+di+0x20],cl
00000136  7769              ja 0x1a1
00000138  6C                insb
00000139  6C                insb
0000013A  207365            and [bp+di+0x65],dh
0000013D  6E                outsb
0000013E  64207520          and [fs:di+0x20],dh
00000142  7468              jz 0x1ac
00000144  65207061          and [gs:bx+si+0x61],dh
00000148  7373              jnc 0x1bd
0000014A  776F              ja 0x1bb
0000014C  7264              jc 0x1b2
0000014E  2E44              cs inc sp
00000150  6F                outsw
00000151  6E                outsb
00000152  27                daa
00000153  7420              jz 0x175
00000155  7472              jz 0x1c9
00000157  7920              jns 0x179
00000159  61                popaw
0000015A  6E                outsb
0000015B  7920              jns 0x17d
0000015D  696E636F72        imul bp,[bp+0x63],word 0x726f
00000162  7265              jc 0x1c9
00000164  637420            arpl [si+0x20],si
00000167  7073              jo 0x1dc
00000169  772C              ja 0x197
0000016B  206974            and [bx+di+0x74],ch
0000016E  207769            and [bx+0x69],dh
00000171  6C                insb
00000172  6C                insb
00000173  206C6F            and [si+0x6f],ch
00000176  636B65            arpl [bp+di+0x65],bp
00000179  6420666F          and [fs:bp+0x6f],ah
0000017D  7265              jc 0x1e4
0000017F  7665              jna 0x1e6
00000181  7221              jc 0x1a4
00000183  0F                db 0x0f
00000184  0F                db 0x0f
00000185  0F                db 0x0f
00000186  0F                db 0x0f
00000187  0F                db 0x0f
00000188  0F                db 0x0f
00000189  0F                db 0x0f
0000018A  0F                db 0x0f
0000018B  0F                db 0x0f
0000018C  0F                db 0x0f
0000018D  0F                db 0x0f
0000018E  0F                db 0x0f
0000018F  0F                db 0x0f
00000190  0F                db 0x0f
00000191  0F                db 0x0f
00000192  0F                db 0x0f
00000193  0F                db 0x0f
00000194  0F                db 0x0f
00000195  0F                db 0x0f
00000196  0F                db 0x0f
00000197  0F                db 0x0f
00000198  0F                db 0x0f
00000199  0F                db 0x0f
0000019A  0F                db 0x0f
0000019B  0F                db 0x0f
0000019C  0F                db 0x0f
0000019D  0F                db 0x0f
0000019E  0F                db 0x0f
0000019F  0F                db 0x0f
000001A0  0F                db 0x0f
000001A1  0F                db 0x0f
000001A2  0F                db 0x0f
000001A3  0F                db 0x0f
000001A4  0F                db 0x0f
000001A5  0F                db 0x0f
000001A6  0F                db 0x0f
000001A7  0F                db 0x0f
000001A8  0F                db 0x0f
000001A9  0F                db 0x0f
000001AA  0F                db 0x0f
000001AB  0F                db 0x0f
000001AC  0F                db 0x0f
000001AD  0F                db 0x0f
000001AE  0F                db 0x0f
000001AF  0F                db 0x0f
000001B0  0F                db 0x0f
000001B1  0F                db 0x0f
000001B2  0F                db 0x0f
000001B3  0F                db 0x0f
000001B4  0F                db 0x0f
000001B5  0F                db 0x0f
000001B6  0F                db 0x0f
000001B7  0F                db 0x0f
000001B8  0F                db 0x0f
000001B9  0F                db 0x0f
000001BA  0F                db 0x0f
000001BB  0F                db 0x0f
000001BC  0F                db 0x0f
000001BD  0F                db 0x0f
000001BE  0F                db 0x0f
000001BF  0F                db 0x0f
000001C0  0F                db 0x0f
000001C1  0F                db 0x0f
000001C2  0F                db 0x0f
000001C3  0F                db 0x0f
000001C4  0F                db 0x0f
000001C5  0F                db 0x0f
000001C6  0F                db 0x0f
000001C7  0F                db 0x0f
000001C8  0F                db 0x0f
000001C9  0F                db 0x0f
000001CA  0F                db 0x0f
000001CB  0F                db 0x0f
000001CC  0F                db 0x0f
000001CD  0F                db 0x0f
000001CE  0F                db 0x0f
000001CF  0F                db 0x0f
000001D0  0F                db 0x0f
000001D1  0F                db 0x0f
000001D2  0F                db 0x0f
000001D3  0F                db 0x0f
000001D4  0F                db 0x0f
000001D5  0F                db 0x0f
000001D6  0F                db 0x0f
000001D7  0F                db 0x0f
000001D8  0F                db 0x0f
000001D9  0F                db 0x0f
000001DA  0F                db 0x0f
000001DB  0F                db 0x0f
000001DC  0F                db 0x0f
000001DD  0F                db 0x0f
000001DE  0F                db 0x0f
000001DF  0F                db 0x0f
000001E0  0F                db 0x0f
000001E1  0F                db 0x0f
000001E2  0F                db 0x0f
000001E3  0F                db 0x0f
000001E4  0F                db 0x0f
000001E5  0F                db 0x0f
000001E6  0F                db 0x0f
000001E7  0F                db 0x0f
000001E8  0F                db 0x0f
000001E9  0F                db 0x0f
000001EA  0F                db 0x0f
000001EB  0F                db 0x0f
000001EC  0F                db 0x0f
000001ED  0F                db 0x0f
000001EE  0F                db 0x0f
000001EF  0F                db 0x0f
000001F0  0F                db 0x0f
000001F1  0F                db 0x0f
000001F2  0F                db 0x0f
000001F3  0F                db 0x0f
000001F4  0F                db 0x0f
000001F5  0F                db 0x0f
000001F6  0F                db 0x0f
000001F7  0F                db 0x0f
000001F8  0F                db 0x0f
000001F9  0F                db 0x0f
000001FA  0F                db 0x0f
000001FB  0F                db 0x0f
000001FC  0F                db 0x0f
000001FD  0F                db 0x0f
000001FE  55                push bp
000001FF  AA                stosb
