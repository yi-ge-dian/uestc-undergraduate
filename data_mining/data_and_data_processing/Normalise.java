/**
 * @Description TODO data_and_processing
 * @Author YiGeDian
 * @Date 2021/11/4 14:56
 **/

import weka.core.Attribute;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.converters.ConverterUtils;
import weka.core.converters.ConverterUtils.DataSource;
import weka.filters.Filter;

public class Normalise {
    public static void main(String[] args) throws Exception {
        //读取数据
        System.out.println("Step 1. 读取数据...");
        DataSource source = new DataSource("D:/weka/Weka-3-8-5/data/iris.arff");
        Instances instances = source.getDataSet();
        //归一化
        System.out.println("Step 2. 归一化...");
        weka.filters.unsupervised.attribute.Normalize norm = new weka.filters.unsupervised.attribute.Normalize();
        norm.setInputFormat(instances);
        Instances newInstances = Filter.useFilter(instances, norm);

        //打印或者保存
        System.out.println("Step 3. 归一化之后的数据（打印）..");
        //打印属性名
        int numOfAttributes = newInstances.numAttributes();
        for (int i = 0; i < numOfAttributes; ++i) {
            Attribute attribute = newInstances.attribute(i);
            System.out.print(attribute.name() + " ");
        }
        System.out.println();
        //打印实例
        int numOfInstance = newInstances.numInstances();
        for (int i = 0; i < numOfInstance; ++i) {
            Instance instance = newInstances.instance(i);
            System.out.print(instance.toString() + " ");
            System.out.println();
        }
        //保存归一化后的数据到新文件
        System.out.println("Step 4. 保存归一化之后的数据到新文件..");
        ConverterUtils.DataSink.write("D:/weka/Weka-3-8-5/data/iris_norm.arff", newInstances);
        System.out.println("Finish.");
    }

}

