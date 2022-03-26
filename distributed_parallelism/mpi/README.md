1.实验报告word版本在此目录下

2.实验报告pdf版本在此目录下

3.实验代码在`./CLion_projects/MPI_project`目录下。

- main.c：基准程序代码

- removeEven.c：单独去除偶数代码

- eliminateBrodcast.c：单独消除广播代码

- cacheOptimization.c：(前两步优化后)cache优化

- finalOptimization.c：最终优化代码

  为了防止测试数据过大，在此文件中我将部分变量int变为了long long int 。
  
  若仍需要int类型，可以对cacheOptimization.c进行测试。

4.对应文件的exe文件则为可执行文件。

5.对于cacheOptimization和finalOptimization可以输入cache的大小，不输入默认为我做实验时的3级cache大小（8MB）

