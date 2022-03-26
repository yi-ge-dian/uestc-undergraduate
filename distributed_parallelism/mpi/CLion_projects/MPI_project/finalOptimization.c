#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
//The default cache size set 8MB
int main(int argc, char* argv[]){
    int count;                 /* Local prime count */
    double elapsed_time;       /* Parallel execution time */
    int global_count;          /* Global prime count */
    long long int high_value;  /* Highest value on this proc */
    int id;                    /* Process ID number */
    long long int index;       /* Index of current prime */
    long long int low_value;   /* Lowest value on this proc */
    char* marked;              /*The marked odd from 3 to n*/
    long long int n;           /* Sieving from 2, ..., 'n' */
    int p;                     /* Number of processes */
    long long int proc0_size;  /* Size of proc 0's subarray */
    char* labeled;              /*The signal from 2 to sqrt(n) with no even*/
    long long int* storage;    /*The prime store 2 to sqrt n*/
    long long int prime;       /* Current prime */
    long long int size;        /*The total size*/
    long long int i;           /*The cyclic variable i*/
    long long int j;           /*The cyclic variable j*/
    long long int k;           /*The cyclic variable k*/
    long long int cache_size;  /*The size of cache*/
    //Init
    MPI_Init(&argc, &argv);
    //Start the timer
    MPI_Comm_rank(MPI_COMM_WORLD, &id);
    MPI_Comm_size(MPI_COMM_WORLD, &p);
    MPI_Barrier(MPI_COMM_WORLD);
    int LEVEL1_CACHE_SIZE = 32768;      // default 32768,32KB
    int LEVEL2_CACHE_SIZE = 262144;     // default 262144,256KB
    int LEVEL3_CACHE_SIZE = 8388608;    // default 8388608,8MB

    elapsed_time = -MPI_Wtime();
    if (argc == 2) {
        cache_size=LEVEL3_CACHE_SIZE;
    } else if (argc==3){
        cache_size=atoll(argv[2]);
    } else{
        if (!id) printf("Command line: %s <m>\n", argv[0]);
        MPI_Finalize();
        exit(1);
    }
    n = atoi(argv[1]);
    ++n;
    //Too many processors
    proc0_size = (n - 1) / p;
    if ((2 + proc0_size) < (int) sqrt((double) n)) {
        if (!id) {
            printf("Too many processes\n");
        }
        MPI_Finalize();
        exit(1);
    }
    long long int number= (long long int)sqrt((double)n);
//    printf("%lld\n",number);
    long long int local_size = number / 2;
//    printf("%lld",local_size);
    labeled =(char*)malloc(local_size);
    if (labeled == NULL)
    {
        printf("Cannot allocate enough memory \n");
        MPI_Finalize();
        exit(1);
    }
    memset(labeled, 0, local_size);
    prime = 3;//Search from prime 3
    index = 0;
    do{
        for (i = index + prime; i < local_size; i += prime) labeled[i] = 1;
        while (labeled[++index]);
        prime = 2 * index + 3;
    } while (prime <= number);

    //第一轮筛选
    int count0=0;
    for (i = 0; i < local_size; i++){
        if (!labeled[i]) count0++;
    }
    storage = (long long int*)malloc(sizeof(long long int) * count0);
    if (storage == NULL){
        printf("Cannot allocate enough memory \n");
        MPI_Finalize();
        exit(1);
    }
    count0 = 0;
    for (i = 0; i < local_size; i++){
        if (!labeled[i]) storage[count0++] = 2 * i + 3;
    }
    size = (n - 2) / 2;
    long long int num=size / cache_size;
    long long int low;
    long long int first;
    long long int res;
    long long int blo_size;
    count = 0;
    for (i = 0; i < num; i++){
        low = i * cache_size;
        low_value = low + (id * (cache_size)) / (p);
        high_value = low + (((id + 1) * (cache_size)) / (p)) - 1;
        blo_size = high_value - low_value + 1;
        low_value = 2 * low_value + 3;
        high_value = 2 * high_value + 3;
        marked = (char*)malloc(sizeof(char*) * blo_size);
        if (marked == NULL){
            printf("Cannot allocate enough memory\n");
            MPI_Finalize();
            exit(1);
        }
        memset(marked, 0, blo_size);
        for (j = 0; j < count0; j++){
            prime = storage[j];
            if (prime * prime > low_value) first = (prime * prime - low_value) / 2;
            else{
                res = low_value % prime;
                if (res == 0) first = 0;
                else{
                    if (res % 2 == 0) first = prime - res / 2;
                    else first = (prime - res) / 2;
                }
            }
            for (k = first; k < blo_size; k += prime) marked[k] = 1;
        }
        for (j = 0; j < blo_size; j++){
            if (!marked[j]){
                count++;
            }
        }
    }
    low = num * cache_size;
    long long int remain;
    remain = size - low;
    low_value = low + (id * (remain)) / (p);
    high_value = low + (((id + 1) * (remain)) / (p)) - 1;
    blo_size = high_value - low_value + 1;
    low_value = 2 * low_value + 3;
    high_value = 2 * high_value + 3;
    marked = (char*)malloc(sizeof(char) * blo_size);
    if (marked == NULL){
        printf("Cannot allocate enough memory\n");
        MPI_Finalize();
        exit(1);
    }
    memset(marked, 0, blo_size);

    for (i = 0; i < count0; i++){
        prime = storage[i];
        if (prime * prime > low_value) first = (prime * prime - low_value) / 2;
        else{
            res = low_value % prime;
            if (res == 0) first = 0;
            else{
                if (res % 2 == 0) first = prime - res / 2;
                else first = (prime - res) / 2;
            }
        }
        for (j = first; j < blo_size; j += prime) marked[j] = 1;
    }
    for (i = 0; i < blo_size; i++){
        if (!marked[i]){
            count++;
        }
    }
    MPI_Reduce(&count, &global_count, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);
    //Stop timing
    elapsed_time += MPI_Wtime();
    --n;
    if (n>=2)
    global_count = global_count + 1;//Add the prime 2
    if (!id)
    {
        printf("There are %d primes less than or equal to %d\n", global_count, n);
        printf("SIEVE (%d) %10.6f\n", p, elapsed_time);
    }
    free(labeled);
    free(storage);
    free(marked);
    MPI_Finalize();
    return 0;

}