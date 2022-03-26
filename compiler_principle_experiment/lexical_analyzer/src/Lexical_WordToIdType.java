/**
 * @author YiGeDian
 * @date 2021/5/21 11:11
 */
public class Lexical_WordToIdType {
    public static String wordToIdType (String string) {
        switch (string) {
            case "begin":
                return "01";
            case "end":
                return "02";
            case "integer":
                return "03";
            case "if":
                return "04";
            case "then":
                return "05";
            case "else":
                return "06";
            case "function":
                return "07";
            case "read":
                return "08";
            case "write":
                return "09";
            case "=":
                return "12";
            case "<>":
                return "13";
            case "<=":
                return "14";
            case "<":
                return "15";
            case ">=":
                return "16";
            case ">":
                return "17";
            case "-":
                return "18";
            case "*":
                return "19";
            case ":=":
                return "20";
            case "(":
                return "21";
            case ")":
                return "22";
            case ";":
                return "23";
            default:
                if (string.matches("[0-9]+")) {
                    return "11";//常量
                } else {
                    return "10";//标识符
                }
        }
    }
}
