.586
.MODEL FLAT, C
.CODE

PUBLIC C asm_func2
asm_func2 PROC C single_arrange: dword, tmp: dword,result1: dword, result2: dword, LGrInt: dword, Nint: dword, Xmin: dword

push eax
push ebx
push ecx
push esi
push edi

mov esi, LGrInt
mov edi, result2
mov ecx, Nint


cmp_loop:
	mov eax,[esi]
	mov ebx,[esi+4]

	push esi
	mov esi,result1
	compare:
		cmp tmp,eax
		jl lower_or_addited
		cmp ecx,1
		je addition
		cmp tmp,ebx
		je next_cycle
	addition:
		push eax
		mov eax,tmp
		sub eax,Xmin
		push ebx
		mov ebx,[esi+4*eax]
		add [edi],ebx
		pop ebx
		pop eax
		cmp ecx,1
		jne lower_or_addited
		dec single_arrange
		inc tmp
		cmp single_arrange,0
		jne addition
		jmp next_cycle
	

	lower_or_addited:
		dec single_arrange
		inc tmp
		jmp compare

	




	next_cycle:
		pop esi
		add esi,4
		add edi,4
		loop cmp_loop


		

pop edi
pop esi
pop ecx
pop ebx
pop eax

ret
asm_func2 endp
end