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
    int low_index;          /* Lowest index on this proc */
    int high_index;         /* Highest index on this proc */
    //Init，MPI程序启动时“自动”建立两个通信器：MPI_COMM_WORLD:包含程序中所有MPI进程，MPI_COMM_SELF：有单个进程独自构成，仅包含自己
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
    //计算3到N之间的数
    n = atoi(argv[1]);

    /* Figure out this process's share of the array, as
       well as the integers represented by the first and
       last array elements */
    int N = (n - 1) / 2;
    low_index = id * (N / p) + MIN(id, N % p); // 进程的第一个数的索引
    high_index = (id + 1) * (N / p) + MIN(id + 1, N % p) - 1; // 进程的最后一个数的索引
    low_value = low_index * 2 + 3; //进程的第一个数
    high_value = (high_index + 1) * 2 + 1;//进程的最后一个数
    size = (high_value - low_value) / 2 + 1;    //进程处理的数组大小


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
    if (marked == NULL) {
        printf("Cannot allocate enough memory\n");
        MPI_Finalize();
        exit(1);
    }

    for (i = 0; i < size; i++) marked[i] = 0;

    if (!id) index = 0;
    prime = 3;
    do {
        if (prime * prime > low_value) {
            first = (prime * prime - low_value)/2;

        } else {
            if (!(low_value % prime)) first = 0;
            else if (low_value % prime % 2 == 0)
                first = prime - ((low_value % prime)/2);
            else
                first=(prime- (low_value % prime)) /2;

        }
        //筛选奇数
        for (i = first; i < size; i += prime) marked[i] = 1;
        if (!id) {
            while (marked[++index]);
            prime = index*2+3;
        }
        if (p > 1)
            MPI_Bcast(&prime, 1, MPI_INT, 0, MPI_COMM_WORLD);
    } while (prime * prime <= n);
    //分别计算局部数组中素数的个数
    count = 0;
    for (i = 0; i < size; i++) {
        if (!marked[i]) count++;
    }
    if (p > 1)
        MPI_Reduce(&count, &global_count, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);
    else
        global_count = count;
    if (n>=2)
        global_count++;

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
