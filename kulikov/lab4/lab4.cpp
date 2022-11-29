#include <iostream>
#include <Windows.h>
#include <fstream>
char input_line[81];
char output_line[161];

int main() {
    SetConsoleCP(1251);
    SetConsoleOutputCP(1251);
    std::cout << "Куликов Максим 1383 - Преобразование введенных во входной строке десятичных цифр в восьмеричную СС,\nостальные символы входной строки передаются в выходную строку непосредственно.\n";
    std::cin.getline(input_line, 81);
   
    
    _asm {
        mov esi, offset input_line
        mov edi, offset output_line


        first_check:
            cmp[esi], '\0'
            je asm_end
        
        
        lodsb
        cmp al,56
        je eight
        cmp al,57
        je nine
        stosb
        jmp first_check
        
        eight:
            mov al,49
            stosb
            mov al,48
            stosb
            jmp first_check
        
        nine:
            mov al,49
            stosb
            stosb
            jmp first_check
        


        asm_end:

    }
    std::ofstream file("output.txt");
    std::cout << output_line << std::endl;
    file << output_line;
    file.close();
    return 0;
}
