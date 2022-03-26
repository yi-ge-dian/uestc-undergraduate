/**
 * @Description TODO handle the missing value
 * @Author YiGeDian
 * @Date 2021/11/4 15:57
 **/

import weka.core.Instances;
import weka.core.converters.ConverterUtils.DataSink;
import weka.core.converters.ConverterUtils.DataSource;

public class MissingValue {
    public static void main(String[] args) throws Exception {
        System.out.println("++++++++++++++Example 2: Missing Value Handing. +++++++++++++");

        System.out.println("Step 1. 读取数据...........");
        String fn = "D:/weka/Weka-3-8-5/data/labor.arff";
        DataSource source = new DataSource(fn);//使用给定的数据集初始化数据源。
        Instances instances = source.getDataSet();//返回完整的数据集，出错时可以为空。

        System.out.println("Step 2.缺失值处理...");
        int numOfAttributes = instances.numAttributes();//返回属性数。
        int numOfInstances = instances.numInstances();//返回数据集中的实例数。

        //计算全局平均数
        double[] meanV = new double[numOfInstances];
        for (int i = 0; i < numOfAttributes; i++) {
            meanV[i] = 0;
            int count = 0;
            for (int j = 0; j < numOfInstances; j++) {
                if (!instances.instance(j).isMissing(i)) {
                    meanV[i] += instances.instance(j).value(i);
                    count++;
                }
            }
            meanV[i] = meanV[i] / count;
        }
        for (int i = 0; i < numOfAttributes; i++) {
            for (int j = 0; j < numOfInstances; j++) {
                if (instances.instance(j).isMissing(i)) {
                    instances.instance(j).setValue(i, meanV[i]);
                }
            }
        }
        System.out.println("Step 3. 保存数据到新文件...");
        DataSink.write(fn.substring(0, fn.length() - 5) + "_handle.arff", instances);
        System.out.println("Finish.");
    }
}

