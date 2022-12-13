.586
.MODEL FLAT, C
.CODE

PUBLIC C asm_func1
asm_func1 PROC C array: dword, arr_size: dword, result1: dword, Xmin: dword

push eax
push ebx
push ecx
push esi
push edi

mov esi, array
mov edi, result1
mov ecx, arr_size

spread_for_one:
	mov eax, [esi]
	sub eax, Xmin
	mov ebx, [edi+4*eax]
	inc ebx
	mov [edi+4*eax], ebx
	add esi, 4
	loop spread_for_one



pop edi
pop esi
pop ecx
pop ebx
pop eax

ret
asm_func1 endp
end