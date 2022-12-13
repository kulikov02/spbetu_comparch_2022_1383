#include <iostream>
#include <random>
#include <fstream>
#include <windows.h>
#include <time.h>


extern "C" void asm_func1(int* arr, int arr_size, int* result1, int Xmin);
extern "C" void asm_func2(int single_arrange,int tmp, int* result1, int* result2, int* LGrInt, int Nint, int Xmin);

int cmp(const void* a, const void* b)
{
    return (*(int*)a - *(int*)b);
}

int main() {
    SetConsoleOutputCP(1251);
    SetConsoleCP(1251);
    int arr_size, Nint, Xmin,Xmax;
    int* arr;
    int* LGrInt;
    int* result1;
    int* result2;

    std::cout << "Введите размер длины массива псевдослучайных чисел: \n";
    std::cin >> arr_size;
    if (arr_size <= 0 || arr_size > 16 * 1024) {
        printf("Вы ввели неверную длину массива.\n");
        return 0;
    }
    arr = new int[arr_size];

    std::cout << "Введите левую границу массива\n";
    std::cin >> Xmin;

    std::cout << "Введите правую границу массива\n";
    std::cin >> Xmax;

    if (Xmin > Xmax) {
        printf("Введенный диапазон чисел некорректен\n");
        return 0;
    }

    std::cout << "Введите количество интервалов разбиения\n";
    std::cin >> Nint;

    if (Nint <= 0) {
        printf("Введенное количество интервалов разбиения некорректное\n");
        return 0;
    }

    LGrInt = new int[Nint];
    std::cout << "Введите левые границы интервалов разбиения \n";
    for (int i = 0; i < Nint; i++) {
        std::cin >> LGrInt[i];
        if (LGrInt[i] < Xmin || LGrInt[i] > Xmax) {
            printf("Введенныt границы некорректны\n");
            return 0;
        }
    }
    
    qsort(LGrInt, Nint, sizeof(int), cmp);
   

    result1 = new int[abs(Xmax - Xmin) + 1];
    result2 = new int[Nint];
    int single_arrange = abs(Xmax - Xmin) + 1;
    for (int i = 0; i < single_arrange; i++) {
        result1[i] = 0;
    }
    for (int i = 0; i < Nint; i++) {
        result2[i] = 0;
    }

    std::cout << "Случайно сгенерированные числа: \n";
    srand(time(NULL));
    for (int i = 0; i < arr_size; i++) {
        arr[i] = Xmin + rand() % (Xmax - Xmin + 1);
        std::cout << arr[i] << " ";
    }

    asm_func1(arr, arr_size, result1, Xmin);
    

    std::cout << "\nПромежуточное распределение с единичным интервалом: \n";
    for (int i = 0; i < single_arrange; i++) {
        std::cout << result1[i] <<" ";
    }
    
    int tmp = Xmin;
    asm_func2(single_arrange,tmp,result1, result2, LGrInt, Nint, Xmin);
    std::cout << "\n";

    std::cout << "Частотное распределение чисел по интервалам: \n";

    for (int i = 0; i < Nint; i++) {
        std::cout << i << " " << LGrInt[i] << " " << result2[i] << "\n";
    }
    std::ofstream file("output.txt");
    for (int i = 0; i < Nint; i++) {
        file << i << " " << LGrInt[i] << " " << result2[i] << "\n";
    }
    file.close();
    }


















