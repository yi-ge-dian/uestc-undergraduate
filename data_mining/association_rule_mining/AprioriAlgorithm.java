/**
 * @Description TODO complete association rule mining
 * @Author YiGeDian
 * @Date 2021/11/11 16:26
 **/

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;


public class AprioriAlgorithm {

    private Map<Integer, Set<String>> txDataBase;//数据库
    private Float minSup;//最小支持度
    private Float minConf;//最小置信度
    private Integer txDateBaseCount;//事务数

    private Map<Integer, Map<Set<String>, Float>> freqItemSets;//频繁项集集合
    private Map<Set<String>, Set<Map<Set<String>, Float>>> associationRules;//频繁关联规则集合

    public AprioriAlgorithm(Map<Integer, Set<String>> txDataBase, float minSup, float minConf) {
        this.txDataBase = txDataBase;
        this.minSup = minSup;
        this.minConf = minConf;
        this.txDateBaseCount = txDataBase.size();
        freqItemSets = new TreeMap<Integer, Map<Set<String>, Float>>();
        associationRules = new HashMap<Set<String>, Set<Map<Set<String>, Float>>>();
    }

    public static void main(String[] args) throws IOException {
        String fn = "E:/IDEA_projects/association_rule_mining/weather.nominal.arff";
        float minSup = 0.1f;
        float minConf = 0.9f;
        File file = new File(fn);
        FileReader fr = new FileReader(file);
        BufferedReader br = new BufferedReader(fr);
        Map<Integer, Set<String>> DB = new HashMap<Integer, Set<String>>();
        String line;
        String sp = ",";
        int num = 0;
        while ((line = br.readLine()) != null) {
            String[] temp = line.trim().split(sp);
            Set<String> set = new TreeSet<String>();
            for (int i = 1; i < temp.length; i++) {
                set.add(temp[i].trim());
            }
            num++;
            DB.put(num, set);
        }
        br.close();fr.close();
        AprioriAlgorithm apr = new AprioriAlgorithm(DB, minSup, minConf);
        apr.findAllFreqItemSet();
        apr.findAssociationRules();
    }

    /**
     * 寻找频繁项集
     */
    public void findAllFreqItemSet() {
        //频繁1项集
        Map<Set<String>, Float> freqOneItemSet = this.find_Frequent_One_Itemsets();
        freqItemSets.put(1, freqOneItemSet);
        System.out.println("频繁1-项集:" + freqOneItemSet);
        System.out.println("频繁1-项集:"+freqOneItemSet.size());
        //频繁k项集
        int k = 2;
        while (true) {
            Set<Set<String>> candFreItemsets = apriori_Gen(k, freqItemSets.get(k - 1).keySet());
            Map<Set<String>, Float> freqKItemSetMap = getFreqKItemSet(k, candFreItemsets);
            if (!freqKItemSetMap.isEmpty()) {
                freqItemSets.put(k, freqKItemSetMap);
            } else {
                break;
            }
            System.out.println("频繁" + k + "-项集:" + freqKItemSetMap);
            System.out.println("频繁" + k + "-项集:" + freqKItemSetMap.size());
            k++;
        }
    }

    /**
     * 频繁1项集函数
     * @return
     */
    public Map<Set<String>, Float> find_Frequent_One_Itemsets() {
        Map<Set<String>, Float> L1 = new HashMap<Set<String>, Float>();
        Map<Set<String>, Integer> item1SetMap = new HashMap<Set<String>, Integer>();
        Iterator<Map.Entry<Integer, Set<String>>> it = txDataBase.entrySet().iterator();
        //支持计数，生成候选频繁1-项集
        while (it.hasNext()) {
            Map.Entry<Integer, Set<String>> entry = it.next();
            Set<String> itemSet = entry.getValue();
            for (String item : itemSet) {
                Set<String> key = new HashSet<String>();
                key.add(item.trim());
                if (!item1SetMap.containsKey(key)) {
                    item1SetMap.put(key, 1);
                } else {
                    int value = 1 + item1SetMap.get(key);
                    item1SetMap.put(key, value);
                }
            }
        }
        //找出支持度大于1minSup的频繁1项集
        Iterator<Map.Entry<Set<String>, Integer>> iter = item1SetMap.entrySet().iterator();
        while (iter.hasNext()) {
            Map.Entry<Set<String>, Integer> entry = iter.next();
            // 计算支持度
            Float support = new Float(entry.getValue().toString()) / new Float(txDateBaseCount);
            if (support >= minSup)
                L1.put(entry.getKey(), support);
        }
        return L1;
    }

    /**
     * 从K项频繁项集中候选K+1项集函数
     * @param k
     * @param freqKItemSet
     * @return
     */
    public Set<Set<String>> apriori_Gen(int k, Set<Set<String>> freqKItemSet) {
        Set<Set<String>> candFreqKItemSet = new HashSet<Set<String>>();
        Iterator<Set<String>> it1 = freqKItemSet.iterator();
        while (it1.hasNext()) {
            Set<String> itemSet1 = it1.next();
            Iterator<Set<String>> it2 = freqKItemSet.iterator();
            while (it2.hasNext()) {
                Set<String> itemSet2 = it2.next();
                if (!itemSet1.equals(itemSet2)) {
                    Set<String> commItems = new HashSet<String>();
                    commItems.addAll(itemSet1);
                    commItems.retainAll(itemSet2);
                    if (commItems.size() == k - 2) {
                        Set<String> candiItems = new HashSet<String>();
                        candiItems.addAll(itemSet1);
                        candiItems.removeAll(itemSet2);
                        candiItems.addAll(itemSet2);
                        if (!has_infrequent_subset(candiItems, freqKItemSet)) {
                            candFreqKItemSet.add(candiItems);
                        }
                    }
                }
            }
        }
        return candFreqKItemSet;
    }

    /**
     * 判断一个候选是否应该剪枝
     * @param itemSet
     * @param freqKItemSet
     * @return
     */
    private boolean has_infrequent_subset(Set<String> itemSet, Set<Set<String>> freqKItemSet) {
        //获取itemSet的所有k-1子集
        Set<Set<String>> subItemSet = new HashSet<Set<String>>();
        Iterator<String> itr = itemSet.iterator();
        while (itr.hasNext()) {
            //深层拷贝
            Set<String> subItem = new HashSet<String>();
            Iterator<String> it = itemSet.iterator();
            while (it.hasNext()) {
                subItem.add(it.next());
            }
            //去掉一个项后即为k-1子集
            subItem.remove(itr.next());
            subItemSet.add(subItem);
        }
        Iterator<Set<String>> it = subItemSet.iterator();
        while (it.hasNext()) {
            if (!freqKItemSet.contains(it.next()))
                return true;
        }
        return false;
    }

    /**
     * 获得频繁项目集
     * @param k
     * @param candFreqKItemSet
     * @return
     */
    public Map<Set<String>, Float> getFreqKItemSet(int k, Set<Set<String>> candFreqKItemSet) {
        Map<Set<String>, Integer> candFreqKItemSetMap = new HashMap<Set<String>, Integer>();
        //扫描事务数据库
        Iterator<Map.Entry<Integer, Set<String>>> it = txDataBase.entrySet().iterator();
        //统计支持数
        while (it.hasNext()) {
            Map.Entry<Integer, Set<String>> entry = it.next();
            Iterator<Set<String>> iter = candFreqKItemSet.iterator();
            while (iter.hasNext()) {
                Set<String> s = iter.next();
                if (entry.getValue().containsAll(s)) {
                    if (!candFreqKItemSetMap.containsKey(s)) {
                        candFreqKItemSetMap.put(s, 1);
                    } else {
                        int value = 1 + candFreqKItemSetMap.get(s);
                        candFreqKItemSetMap.put(s, value);
                    }
                }
            }
        }
        //System.out.println(candFreqKItemSetMap.size());
        Map<Set<String>, Float> freqKItemSetMap = new HashMap<Set<String>, Float>();
        Iterator<Map.Entry<Set<String>, Integer>> itr = candFreqKItemSetMap.entrySet().iterator();
        while (itr.hasNext()) {
            Map.Entry<Set<String>, Integer> entry = itr.next();
            //计算支持数
            float support = new Float(entry.getValue().toString()) / txDateBaseCount;
            if (support < minSup) {
                itr.remove();
            } else {
                freqKItemSetMap.put(entry.getKey(), support);
            }
        }
        return freqKItemSetMap;
    }

    /**
     * 从频繁项集中找到关联规则
     */
    public void findAssociationRules() {
        Iterator<Map.Entry<Integer, Map<Set<String>, Float>>> it = freqItemSets.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry<Integer, Map<Set<String>, Float>> entry = it.next();
            for (Set<String> itemSet : entry.getValue().keySet()) {
                //对每个频繁项集进行关联规则的挖掘
                int n = itemSet.size() / 2;//集合对称性
                for (int i = 1; i <= n; i++) {
                    //得到频繁项集元素itemSet的条件作为条件的真子集集合
                    Set<Set<String>> subset = ProperSubsetCombination.getProperSubset(i, itemSet);
                    //对条件的真子集集合中的每个条件项集，获取对应的结论项集，从而进一步挖掘关联规则
                    for (Set<String> conditionSet : subset) {
                        Set<String> conclusionSet = new HashSet<String>();
                        conclusionSet.addAll(itemSet);
                        conclusionSet.removeAll(conditionSet);//删除条件中存在的频繁项
                        int s1 = conditionSet.size();
                        int s2 = conclusionSet.size();
                        float sup1 = freqItemSets.get(s1).get(conditionSet);
                        float sup2 = freqItemSets.get(s2).get(conclusionSet);
                        float sup = freqItemSets.get(s1 + s2).get(itemSet);
                        float conf1 = sup / sup1;
                        float conf2 = sup / sup2;
                        if (conf1 >= minConf) {
                            if (associationRules.get(conditionSet) == null) {
                                Set<Map<Set<String>, Float>> conclusionSetSet = new HashSet<Map<Set<String>, Float>>();
                                Map<Set<String>, Float> sets = new HashMap<Set<String>, Float>();
                                sets.put(conclusionSet, conf1);
                                conclusionSetSet.add(sets);
                                associationRules.put(conditionSet, conclusionSetSet);
                            } else {
                                Map<Set<String>, Float> sets = new HashMap<Set<String>, Float>();
                                sets.put(conclusionSet, conf1);
                                associationRules.get(conditionSet).add(sets);
                            }
                        }
                        if (conf2 >= minConf) {
                            if (associationRules.get(conclusionSet) == null) {
                                Set<Map<Set<String>, Float>> conclusionSetSet =
                                        new HashSet<Map<Set<String>, Float>>();
                                Map<Set<String>, Float> sets = new HashMap<Set<String>, Float>();
                                sets.put(conclusionSet, conf2);
                                conclusionSetSet.add(sets);
                                associationRules.put(conclusionSet, conclusionSetSet);
                            } else {
                                Map<Set<String>, Float> sets = new HashMap<Set<String>, Float>();
                                sets.put(conditionSet, conf2);
                                associationRules.get(conclusionSet).add(sets);
                            }
                        }
                    }
                }
            }
        }
        System.out.println("关联规则（强）：");

        for (Map.Entry<Set<String>, Set<Map<Set<String>, Float>>> entry : associationRules.entrySet()) {
            Set<String> key = entry.getKey();
            Set<Map<Set<String>, Float>> value = entry.getValue();
            System.out.print(key);
            System.out.print(" : ");
            System.out.println(value);
        }
    }


}
