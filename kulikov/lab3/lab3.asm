a EQU 1
b EQU 2
i EQU 3
k EQU 4

AStack SEGMENT STACK
 DW 12 DUP(?)
AStack ENDS
    
DATA SEGMENT
    i1 dw 0
    i2 dw 0
    res dw 0
DATA ENDS

;	/ - (4*i+3) , при a>b
; (f2)f1 = <
;	\ 6*i -10 , при a<=b
;
;	/ 7 - 4*i , при a>b
; (f3)f2 = <
; 	\ 8 -6*i , при a<=b
;
;	/ |i1| - |i2|, при k<0
; (f8)f3 = <
; 	\ max(4,|i2|-3), при k>=0

CODE SEGMENT
 ASSUME CS:CODE, DS:DATA, SS:AStack

Main PROC FAR
    push DS
    sub AX,AX
    push AX
    mov AX,DATA
    mov DS,AX

    mov ax,i
    shl ax,1
    mov i1,ax
    add ax,i
    mov i2,ax
    mov ax,a
    cmp ax,b
    jg if_a_greater

    shl i2,1
    mov dx,i2
    mov i1,dx
    sub i1,10
    neg i2
    add i2,8
    jmp func_3

if_a_greater:
    shl i1,1
    add i1,3
    neg i1

    mov ax,i1
    mov i2,ax
    add i2,10

func_3:
    cmp i1,0
    jg i1_after_neg
    neg i1
   
i1_after_neg:
    cmp i2,0
    jg k_comparing
    neg i2
    
k_comparing:
    mov dx,k   ;переношу в dx так как k нельзя использовать в cmp с нулем
    cmp dx,0
    jl k_less
    sub i2,3
    cmp i2,4
    jl i2_less
    mov ax,i2
    mov res,ax
    ret

i2_less:
    mov res,4
    ret

k_less:
    mov ax,i1
    sub ax,i2
    mov res,ax
    
Main ENDP
CODE ENDS
 END Main