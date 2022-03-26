#include "mpi.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

#define MIN(a, b)  ((a)<(b)?(a):(b))

int main(int argc, char *argv[]) {
    int count;        /* Local prime count */
    double elapsed_time; /* Parallel execution time */
    int first;        /* Index of first multiple */
    int global_count; /* Global prime count */
    int high_value;   /* Highest value on this proc */
    int i;
    int id;           /* Process ID number */
    int index;        /* Index of current prime */
    int low_value;    /* Lowest value on this proc */
    char *marked;       /* Portion of 2,...,'n' */
    int n;            /* Sieving from 2, ..., 'n' */
    int p;            /* Number of processes */
    int proc0_size;   /* Size of proc 0's subarray */
    int prime;        /* Current prime */
    int size;         /* Elements in 'marked' */
    char *marked_sub;    /*the marked array*/
    int first_sub;      /*Subject of adjunct array*/
    int num;            /*the num of 2 to n*/
    int sqrt_n;

    MPI_Init(&argc, &argv);
    /* Start the timer */
    MPI_Comm_rank(MPI_COMM_WORLD, &id);
    MPI_Comm_size(MPI_COMM_WORLD, &p);
    MPI_Barrier(MPI_COMM_WORLD);
    //开始计时
    elapsed_time = -MPI_Wtime();
    //判断参数是否为2，第一个参数为文件名字，第二个参数为要寻找n以内的数
    if (argc != 2) {
        if (!id) {
            // 结束MPI系统
            printf("Command line: %s <m>\n", argv[0]);
        }
        MPI_Finalize();
        exit(1);
    }

    n = atoi(argv[1]);
    sqrt_n=(int) sqrt((double )n);

    /* Figure out this process's share of the array, as
       well as the integers represented by the first and
       last array elements */

    low_value = 2 + id * (n - 1) / p;//进程的第一个数
    high_value = 1 + (id + 1) * (n - 1) / p;//进程的最后一个数
    size = high_value - low_value + 1;//进程处理的大小
    num=(int) sqrt(high_value);

    /* Bail out if all the primes used for sieving are
       not all held by process 0 */

    //进程如果太多
    proc0_size = (n - 1) / p;
    if ((2 + proc0_size) < (int) sqrt((double) n)) {
        if (!id) {
            printf("Too many processes\n");
        }
        MPI_Finalize();
        exit(1);
    }

    /* Allocate this process's share of the array. */

    marked = (char *) malloc(size);
    marked_sub = (char *) malloc(num);
    if (marked == NULL||marked_sub==NULL) {
        printf("Cannot allocate enough memory\n");
        MPI_Finalize();
        exit(1);
    }

    for (i = 0; i < size; i++) marked[i] = 0;
    for (i = 0; i < num; i++) marked_sub[i] = 0;

    index = 0;

    prime = 2;
    do {
        //寻找到第一个素数倍数的索引first
        if (prime * prime > low_value) {
            first = prime * prime - low_value;//索引值为prime*prime-low_value

        } else {
            if (!(low_value % prime)) first = 0;//若low_value就是素数的倍数，索引值为0
            else first = prime - (low_value % prime);//若low_value不是素数的倍数，索引值为prime-(low_value%prime)
        }

        // 从第一个素数的倍数开始，标记该素数的倍数为非素数
        for (i = first; i < size; i += prime) marked[i] = 1;
        first_sub =(prime*prime-2);
        for(i=first_sub;i<num;i+=prime) marked_sub[i]=1;
        while (marked_sub[++index]);
        prime = index + 2;
        //若processors的数量大于1，id=0的processor把素数广播出去。
    } while (prime <=sqrt_n);

    count = 0;
    for (i = 0; i < size; i++) {
        if (!marked[i]) count++;
    }
    //若processors的数量大于1，id=0的processor复杂接受其他id的processor的count，并合为global_count
    if (p > 1) {
        MPI_Reduce(&count, &global_count, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);
    } else {
        global_count = count;
    }

    /* Stop the timer */
    elapsed_time += MPI_Wtime();
    /* Print the results */
    if (!id) {
        printf("There are %d primes less than or equal to %d\n", global_count, n);
        printf("SIEVE (%d) %10.6f\n", p, elapsed_time);
    }
    MPI_Finalize();
    return 0;
}
