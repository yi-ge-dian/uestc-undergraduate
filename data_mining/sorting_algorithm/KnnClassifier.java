import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

/**
 * @Description TODO KNN classifier
 * @Author YiGeDian
 * @Date 2021/11/18 15:07
 **/
public class KnnClassifier {
    //数据类，封装数据
    private class Data {
        double[] data;
        String label;

        Data(double[] data, String label) {
            this.data = data;
            this.label = label;
        }
    }

    //结果输出
    ArrayList<Data> trainSet;
    ArrayList<Data> testSet;
    int k;

    public static void main(String[] args) throws Exception {
        KnnClassifier knn = new KnnClassifier("E:\\IDEA_projects\\sorting_algorithm\\train.arff", 2);
        knn.predict("E:\\IDEA_projects\\sorting_algorithm\\test.arff");
    }

    public KnnClassifier(String filePath, int k) {
        trainSet = loadDataSet(filePath);
        this.k = k;
    }

    /**
     * 读入训练数据
     *
     * @param filePath
     * @return
     * @throws Exception
     */
    public ArrayList<Data> loadDataSet(String filePath) {
        ArrayList<Data> dataSet = new ArrayList<Data>();
        File file = new File(filePath);
        FileReader fr;
        try {
            fr = new FileReader(file);
            BufferedReader bis = new BufferedReader(fr);
            String line = null;
            while ((line = bis.readLine()) != null) {
                if (line.startsWith("@data")) {
                    while ((line = bis.readLine()) != null) {
                        String[] str = line.trim().split(",");
                        double[] data = new double[str.length - 1];
                        for (int i = 0; i < str.length - 1; i++) {
                            data[i] = Double.parseDouble(str[i]);
                        }
                        Data dataObject = new Data(data, str[str.length - 1]);
                        dataSet.add(dataObject);
                    }
                } else {
                    continue;
                }
            }
            bis.close();
            return dataSet;
        } catch (IOException el) {
            el.printStackTrace();
            return null;
        }
    }


    /**
     * 训练新数据
     *
     * @param testPath
     * @throws Exception
     */
    public void predict(String testPath) throws Exception {
        testSet = this.loadDataSet(testPath);
        int correct = 0;
        for (int n = 0; n < testSet.size(); n++) {
            Data data = testSet.get(n);
            String predict = classify(data);
            boolean flag;
            if (flag = predict.equals(data.label)) {
                correct++;
            }
            System.out.println(flag + ":\t***Predicted label:" + predict + "\tdata label:" + data.label + "***");
        }
        System.out.println("Accuracy: " + correct * 100.0 / testSet.size() + "%");
    }

    /**
     * 预测函数
     *
     * @param test
     * @return
     * @throws Exception
     */
    public String classify(Data test) throws Exception {
        double[] distances = new double[trainSet.size()];
        //获得测试点离训练点的距离
        for (int n = 0; n < trainSet.size(); n++) {
            distances[n] = getDist(test, trainSet.get(n));
        }
        HashMap<String, Integer> voteMap = new HashMap<String, Integer>();
        //循环k次，取前k次最小距离，进行投票
        for (int n = 0; n < k; n++) {
            double min = Integer.MAX_VALUE;
            int minlndex = -1;
            for (int m = 0; m < trainSet.size(); m++) {
                if (distances[m] < min) {
                    min = distances[m];
                    minlndex = m;
                }
            }
            if (minlndex == -1) {
                System.out.println("error");
                System.exit(0);
            }
            distances[minlndex] = Integer.MAX_VALUE;
            String key = trainSet.get(minlndex).label;
            if (voteMap.containsKey(key)) {
                Integer value = voteMap.get(trainSet.get(minlndex).label);
                voteMap.put(trainSet.get(minlndex).label, value + 1);
            } else {
                voteMap.put(key, 1);
            }
        }
        //投票结果的计算
        Iterator<String> i = voteMap.keySet().iterator();
        String predict = null;
        int maxVote = 0;
        while (i.hasNext()) {
            String key = i.next();
            if (voteMap.get(key) > maxVote) {
                maxVote = voteMap.get(key);
                predict = key;
            }
        }
        return predict;
    }

    /**
     * 计算欧式距离
     *
     * @param test
     * @param data
     * @return
     * @throws Exception
     */
    private double getDist(Data test, Data data) throws Exception {
        double sum = 0;
        for (int n = 0; n < test.data.length; n++) {
            sum += (test.data[n] - data.data[n]) * (test.data[n] - data.data[n]);
        }
        return Math.sqrt(sum);
    }

}
