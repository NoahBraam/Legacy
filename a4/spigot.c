#include <stdlib.h>
#include <stdio.h>

int main (void) {
    printf("Enter an output file: ");
    printf("\n");
    const int n = 1000;
    int len = 10*n /3;
    int i, j, k, q, x, nines, predigit;
    long a[len];
    for (i = 0; i<len; i++) {
        a[i] = 2;
    }
    nines = 0;
    predigit = 0;
    for (j = 0; j< n; j++) {
        q = 0;
        for (i = len-1; i >0; i--) {
            x = 10*a[i] + q*i;
            int tmp = 2*i -1;
            a[i] = x % tmp;
            q = x / tmp;
        }
        a[1] = q % 10;
        q = q/10;
        if (q == 9) {
            nines = nines + 1;
        } else if (q == 10) {
            printf("%d", predigit + 1);
            for (k = 0; k<nines; k++) {
                printf("%d", 0);
            }
            predigit = 0;
            nines = 0;
        } else {
            printf("%d", predigit);
            predigit = q;
            if (nines != 0) {
                for (k = 0; k<nines; k++) {
                    printf("%d", 9);
                }
                nines = 0;
            }
        }
    }
    printf("%d", predigit);
}