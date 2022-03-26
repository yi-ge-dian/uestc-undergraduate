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
    //Init，MPI程序启动时“自动”建立两个通信器：MPI_COMM_WORLD:包含程序中所有MPI进程，MPI_COMM_SELF：有单个进程独自构成，仅包含自己
    MPI_Init(&argc, &argv);
    /* Start the timer */
    //MPI_COMM_RANK 得到本进程的进程号，进程号取值范围为 0, …, np-1
    MPI_Comm_rank(MPI_COMM_WORLD, &id);
    // MPI_COMM_SIZE 得到所有参加运算的进程的个数
    MPI_Comm_size(MPI_COMM_WORLD, &p);
    // MPI_Barrier是MPI中的一个函数接口,表示阻止调用直到communicator中所有进程完成调用
    MPI_Barrier(MPI_COMM_WORLD);
    //表示从过去某一时刻到调用时刻所经历的时间
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

    /* Figure out this process's share of the array, as
       well as the integers represented by the first and
       last array elements */

    low_value = 2 + id * (n - 1) / p;//进程的第一个数
    high_value = 1 + (id + 1) * (n - 1) / p;//进程的最后一个数
    size = high_value - low_value + 1;//进程处理的大小

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
    //假设所有的数都为素数，mark数组全部置为0
    for (i = 0; i < size; i++) {
        marked[i] = 0;
    }

    //id=0的processor的index置位0
    if (!id) {
        index = 0;
    }

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
        for (i = first; i < size; i += prime) {
            marked[i] = 1;
        }
        //id=0的processor直到mark数组中的标志为0，index+2赋值给prime，因为index从0开始，prime从2开始
        if (!id) {
            while (marked[++index]);
            prime = index + 2;
        }
        //若processors的数量大于1，id=0的processor把素数广播出去。
        if (p > 1) {
            MPI_Bcast(&prime, 1, MPI_INT, 0, MPI_COMM_WORLD);
        }
    } while (prime * prime <= n);

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
