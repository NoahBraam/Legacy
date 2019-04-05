#include <stdlib.h>
#include <stdio.h>
/*
 * Noah Braam
 * 0960202
 * This is a C version of the spigot algorithm
 * originally given to us in Pascal.
 */

int main (void) {
    // Get file and open it
    char fileName[200];
    printf("Enter an output file: ");
    scanf("%s", fileName);
    FILE* fp = fopen(fileName, "w+");

    // Define variables needed for the algorithm
    const int n = 1000;
    const int len = 10*n /3;
    int i, j, k, q, x, nines, predigit;
    long a[len];

    // Initialize array to 2
    for (i = 0; i<len; i++) {
        a[i] = 2;
    }
    nines = 0;
    predigit = 0;
    for (j = 0; j< n; j++) {
        q = 0;

        // Calculate q
        for (i = len-1; i >0; i--) {
            x = 10*a[i] + q*i;
            int tmp = 2*i -1;
            a[i] = x % tmp;
            q = x / tmp;
        }
        a[1] = q % 10;
        q = q/10;
        // Print needed value of Pi
        if (q == 9) {
            nines = nines + 1;
        } else if (q == 10) {
            fprintf(fp, "%d", predigit + 1);
            for (k = 0; k<nines; k++) {
                fprintf(fp, "%d", 0);
            }
            predigit = 0;
            nines = 0;
        } else {
            fprintf(fp, "%d", predigit);
            predigit = q;
            if (nines != 0) {
                for (k = 0; k<nines; k++) {
                    fprintf(fp, "%d", 9);
                }
                nines = 0;
            }
        }
    }
    // Print final value of Pi
    fprintf(fp, "%d", predigit);
    fclose(fp);
}