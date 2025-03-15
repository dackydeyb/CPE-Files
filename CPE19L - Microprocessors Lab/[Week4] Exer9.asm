.model small
.data

              ;0123456789012345678901234567890123456789012345678901234567890123456789012345678
    line01 db '______________________________________________________________________________|', 13, 10, '$'
    line02 db '|             .",;::::;,".                                                    |', 13, 10, '$'
    line03 db '|         .";:cccccccccccc:;,.                                                |', 13, 10, '$'
    line04 db '|      .;cccccccccccccccccccccc;.           Hon. Dave Jhared G. Paduada       |', 13, 10, '$'
    line05 db '|    .:cccccccccccccccccccccccccc:.                                           |', 13, 10, '$'
    line06 db '|  .;ccccccccccccc;.:dddl:.;ccccccc;.         Cloud Security Architect        |', 13, 10, '$'
    line07 db '| .:ccccccccccccc;OWMKOOXMWd;ccccccc;.                                        |', 13, 10, '$'
    line08 db '|.:ccccccccccccc;KWMMc;cc;xMMc:cccccc:.                                       |', 13, 10, '$'
    line09 db '|,cccccccccccccc;MMM.;cc;;WW::cccccccc,                                       |', 13, 10, '$'
    line10 db '|:cccccccccccccc;MMMMMMNMWWccccccccccc:                                       |', 13, 10, '$'
    line11 db '|:ccccccc;cccccc;MMM.;cccccccccccccccc:  Office No.: (212) 270-6000           |', 13, 10, '$'
    line12 db '|cccccc:0MMK;ccc;MMM.;cccccccccccccccc;                                       |', 13, 10, '$'
    line13 db '|ccccc:XM0";cccc;MMM.;cccccccccccccccc"  FAX No.:    8885-7910                |', 13, 10, '$'
    line14 db '|ccccc;MMo;ccccc;MMW.;ccccccccccccccc;                                        |', 13, 10, '$'
    line15 db '|ccccc;0MNc.ccc.xMMd:ccccccccccccccc;    RES. No.:   (563)547-923             |', 13, 10, '$'
    line16 db '|cccccc;dNMWXXXWMO::ccccccccccccccc:,                                         |', 13, 10, '$'
    line17 db '|ccccccc;.:odl".;cccccccccccccccc:,.     Mobile No.: 0928-989-7123            |', 13, 10, '$'
    line18 db '|:cccccccccccccccccccccccccccccc:".                                           |', 13, 10, '$'
    line19 db '|.:cccccccccccccccccccccccc:;,..         Email Address: paduada.dave@gmail.com|', 13, 10, '$'
    line20 db '|  "::ccccccccccccccccc::;,.                                                  |', 13, 10, '$'
    line21 db '|                                                                             |', 13, 10, '$'
    line22 db '|       J.P. Morgan                                                           |', 13, 10, '$'
    line23 db '|  https://www.jpmorgan.com/                                                  |', 13, 10, '$'
    line24 db '|_____________________________________________________________________________|', 13, 10, '$'
   
    
   
.code

start:
mov ax, @data
mov ds, ax

mov cx, 18h
mov si, 1

c:
    mov dx, offset line01 - 52h
    mov di, cx
    mov cx, si
    
    d:
        add dx, 52h
        loop d
    mov cx, di
    mov ah, 09h
    int 21h
    inc si
    loop c
    
mov ah, 4ch
int 21h

end start