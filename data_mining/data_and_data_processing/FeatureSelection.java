/**
 * @Description TODO select the feature
 * @Author YiGeDian
 * @Date 2021/11/4 16:06
 **/

import weka.attributeSelection.ASEvaluation;
import weka.attributeSelection.InfoGainAttributeEval;
import weka.attributeSelection.Ranker;
import weka.core.Instances;
import weka.core.converters.ConverterUtils;
import weka.core.converters.ConverterUtils.DataSource;
import weka.core.converters.ConverterUtils.DataSink;
import weka.filters.Filter;
import weka.filters.supervised.attribute.AttributeSelection;


public class FeatureSelection {
    public static void main(String[] args) throws Exception {
        System.out.println("-----------Example3 :Feature Selection via weka");
        System.out.println("Step 1.读取数据...");
        String fn="D:/weka/Weka-3-8-5/data/iris.arff";
        ConverterUtils.DataSource source=new DataSource(fn);
        Instances instances=source.getDataSet();

        System.out.println("Step 2.特征筛选...");
        //从数据中筛选特征
        int k=3;
        //特征筛选类
        AttributeSelection as=new AttributeSelection();
        //排序
        Ranker rank =new Ranker();
        //参数设置，筛选大于某阈值的特征
        rank.setThreshold(0.0);
        //选择特征数
        rank.setNumToSelect(k);

        ASEvaluation ae=new InfoGainAttributeEval();//不同的特征选择
        as.setEvaluator(ae);
        as.setSearch(rank);
        as.setInputFormat(instances);
        Instances reductData =Filter.useFilter(instances, as);

        System.out.println("Step 3. 保存规约后的数据到新文件...");
        DataSink.write(fn.substring(0,fn.length()-6)+"_reducted.arff",reductData);
        System.out.println("Finish.");
    }

}
