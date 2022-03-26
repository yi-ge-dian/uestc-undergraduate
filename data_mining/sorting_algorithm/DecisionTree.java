import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @Description TODO
 * @Author YiGeDian
 * @Date 2021/11/25 16:19
 **/
public class DecisionTree {
    //储存原始属性的名称
    private ArrayList<String> attribute = new ArrayList<String>();
    //储存每个属性的取值
    private ArrayList<ArrayList<String>> attributeValue = new ArrayList<ArrayList<String>>();
    //原始数据
    private ArrayList<String[]> dataSet = new ArrayList<String[]>();

    /**
     * 主函数
     * @param args
     * @throws Exception
     */
    public static void main(String[] args) throws Exception {
        //读取数据集
        DecisionTree d = new DecisionTree("D:\\weka\\Weka-3-8-5\\data\\weather.nominal.arff");
        //保存树结构，key 父节点 value 子树
        HashMap<String, HashMap<String, Object>> t = d.createTree(d.dataSet, (ArrayList<String>) d.attribute.clone());
        //打印数据
        String label = d.classify(t, new String[]{"no", "yse"});
        System.out.print(label);
    }

    /**
     * 构造函数
     * @param filePath
     * @throws IOException
     */
    public DecisionTree(String filePath) throws IOException {
        readARFF(new File(filePath));
    }

    /**
     * 读文件
     * @param file
     * @throws IOException
     */
    public void readARFF(File file) throws IOException {
        //匹配属性头部的正则 字符串
        String patternString = "@attribute(.* )[{](.*)[}]";
        FileReader fr = new FileReader(file);
        BufferedReader br = new BufferedReader(fr);
        String line;
        //创建正则表达式
        Pattern pattern = Pattern.compile(patternString);
        while ((line = br.readLine()) != null) {
            if (line.startsWith("%") || line.equals("")) { continue; }
            // matcher实例 提供对正则表达式的分组支持和多次匹配支持
            Matcher matcher = pattern.matcher(line);
            //如果匹配成功 读取属性名
            if (matcher.find()) {
                attribute.add(matcher.group(1).trim());
                String[] values = matcher.group(2).split(",");
                ArrayList<String> al = new ArrayList<String>(values.length);
                for (String value : values) { al.add(value.trim()); }
                attributeValue.add(al);
            }
            //读取data
            else if (line.startsWith("@data")) {
                while ((line = br.readLine()) != null) {
                    if (line == "")
                        continue;
                    line = line.replace("'", "");
                    String[] row = line.split(",");
                    dataSet.add(row);
                }
            } else {
                continue;
            }
        }
        br.close();
}

    /**
     * 计算父类节点的信息熵
     * @param data
     * @return
     */
    public double calcShannonEnt(ArrayList<String[]> data) {
        double shannonEnt = 0;
        int numEntries = data.size();
        HashMap<String, Integer> labelCounts = new HashMap<String, Integer>();
        //为所有可能的分类创建数据字典
        for (int i = 0; i < data.size(); i++) {
            String currentLabel = data.get(i)[data.get(i).length - 1];
            if (!labelCounts.containsKey(currentLabel)) {
                labelCounts.put(currentLabel, 1);
            } else {
                labelCounts.put(currentLabel, labelCounts.get(currentLabel) + 1);
            }
        }
        //计算每个可能分类的支持度
        Iterator<String> iterator = labelCounts.keySet().iterator();
        while (iterator.hasNext()) {
            String key = iterator.next();
            double prob = 1.0 * labelCounts.get(key) / numEntries;
            //计算父类节点的信息熵
            shannonEnt -= prob * log(prob, 2);
        }
        return shannonEnt;
    }

    static public double log(double value, double base) {
        return Math.log(value) / Math.log(base);
    }

    /**
     * 将子树进行分割
     * @param data
     * @param feature
     * @param value
     * @return
     */
    public ArrayList<String[]> splitDataSet(ArrayList<String[]> data, int feature, String value) {
        ArrayList<String[]> subDataSet = new ArrayList<String[]>();
        //返回数据集子集,包含feature维特征取值为value的数据，删除维度的feature
        for (int i = 0; i < data.size(); i++) {
            String[] currentFeat = data.get(i);
            if (currentFeat[feature].equals(value)) {
                String[] reducedFeature = new String[currentFeat.length - 1];
                if (feature == 0) {
                    System.arraycopy(currentFeat, 1, reducedFeature, 0, currentFeat.length - 1);
                } else {
                    System.arraycopy(currentFeat, 0, reducedFeature, 0, feature);
                    System.arraycopy(currentFeat, feature + 1, reducedFeature, feature,
                            currentFeat.length - 1 - feature);
                }
                subDataSet.add(reducedFeature);
            }
        }
        return subDataSet;
    }

    /**
     * 选取最佳的分类特征
     * @param data
     * @return
     */
    int chooseBestFeatureToSplit(ArrayList<String[]> data) {
        int numFeatures = data.get(0).length - 1;
        //计算父类节点的信息熵
        double baseEntrop = calcShannonEnt(data);
        //最大的信息增益
        double bestlnfoGain = 0;
        int bestFeature = -1;
        //计算每个属性的信息增益，返回最佳属性
        for (int i = 0; i < numFeatures; i++) {
            double newEntropy = 0;
            double infoGain = 0;
            //父节点下的子树的label
            Set<String> uniqueValsSet = new HashSet<String>();
            for (int j = 0; j < data.size(); j++) {
                uniqueValsSet.add(data.get(j)[i]);
            }
            //计算在子条件已经发生的情况下父类的信息熵
            for (String value : uniqueValsSet) {
                ArrayList<String[]> subSetData = splitDataSet(data, i, value);
                double prob = 1.0 * subSetData.size() / data.size();
                newEntropy += prob * calcShannonEnt(subSetData);
            }
            //计算信息增益
            infoGain = baseEntrop - newEntropy;
            if (infoGain > bestlnfoGain) {
                bestlnfoGain = infoGain;
                bestFeature = i;
            }
        }
        return bestFeature;
    }

    /**
     * 进行计数
     * @param classList
     * @return
     */
    String majorityCount(Vector<String> classList) {
        HashMap<String, Integer> classCount = new HashMap<String, Integer>();
        int maxVote = 0;
        String majorityClass = null;
        for (String classType : classList) {
            if (!classCount.containsKey(classType)) {
                classCount.put(classType, 1);
            } else {
                classCount.put(classType, classCount.get(classType) + 1);
            }
        }
        Iterator<String> iterator = classCount.keySet().iterator();
        while (iterator.hasNext()) {
            String key = iterator.next();
            if (classCount.get(key) > maxVote) {
                maxVote = classCount.get(key);
                majorityClass = key;
            }
        }
        return majorityClass;
    }

    /**
     * 构建决策树
     * @param data
     * @param attributeLabels
     * @return
     * @throws Exception
     */
    HashMap<String, HashMap<String, Object>> createTree(ArrayList<String[]> data, ArrayList<String> attributeLabels) throws Exception {
        Vector<String> classList = new Vector<String>();
        int bestFeature = -1;
        String bestFeatureLabel = null;
        HashMap<String, HashMap<String, Object>> myTree = new HashMap<String, HashMap<String, Object>>();
        //classList 储存属性的所有值
        for (int i = 0; i < data.size(); i++) {
            String[] ithData = data.get(i);
            classList.add(ithData[ithData.length - 1]);
        }
        //判断该分枝下的实例类别是否全部相同，相同则停止划分，返回该类别
        int count = 0;
        for (int i = 0; i < classList.size(); i++) {
            if (classList.get(i).equals(classList.get(0))) {
                count++;
            }
        }
        if (count == classList.size()) {
            myTree.put(classList.get(0), null);
            return myTree;
        }
        //遍历完所有划分数据集的属性，使用多数表决返回类别
        if (data.get(0).length == 1) {
            myTree.put(majorityCount(classList), null);
            return myTree;
        }
        //选取最佳的划分特征
        bestFeature = chooseBestFeatureToSplit(data);
        bestFeatureLabel = attributeLabels.get(bestFeature);
        myTree.put(bestFeatureLabel, new HashMap<String, Object>());
        attributeLabels.remove(bestFeature);
        //递归地构建决策树
        Set<String> uniqueValsSet = new HashSet<String>();
        for (int i = 0; i < data.size(); i++) {
            uniqueValsSet.add(data.get(i)[bestFeature]);
        }
        for (String value : uniqueValsSet) {
            ArrayList<String> subLabels = new ArrayList<String>(attributeLabels);
            ArrayList<String[]> subDataSet = splitDataSet(data, bestFeature, value);
            //创建子树
            HashMap<String, HashMap<String, Object>> subTree = createTree(subDataSet, subLabels);
            //加入原树
            myTree.get(bestFeatureLabel).put(value, subTree);
        }
        return myTree;
    }

    /**
     * 进行测试集的分类
     * @param tree
     * @param testData
     * @return
     */
    String classify(HashMap<String, HashMap<String, Object>> tree, String[] testData) {
        String root = tree.keySet().iterator().next();
        HashMap<String, Object> secondLayer = tree.get(root);
        int featurelndex = attribute.indexOf(root);
        String classLabel = null;
        //如果没有子树返回 root
        if (secondLayer == null) {
            return root;
        }
        System.out.println(secondLayer);
        //递归求所属的类别
        for (String key : secondLayer.keySet()) {
            if (testData[featurelndex].equals(key)) {
                classLabel = classify((HashMap<String, HashMap<String, Object>>) secondLayer.get(key), testData);
            }
        }
        return classLabel;
    }
}
