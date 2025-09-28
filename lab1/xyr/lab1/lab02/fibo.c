#include <stdio.h>

int add(int a, int b)
{
    return a + b;
}

int main()
{
    int a, b, i, t, n;
    a = 0;
    b = 1;
    i = 1;
    scanf("%d", &n);
    printf("%d\n", a);
    printf("%d\n", b);
    
    while (i < n)
    {
        t = b;
        b = add(a, b);
        if (b % 2 == 0)
            printf("%d\n", b);
        a = t;
        i = i + 1;
    }
    
    return 0;
}