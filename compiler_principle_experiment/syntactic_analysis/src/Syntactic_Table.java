/**
 * @author YiGeDian
 * @date 2021/6/9 16:10
 */
public class Syntactic_Table {


    static class VarTable{
        String vname;//变量名
        String vproc;//所说过程
        String vtype;//分类，0变量，1形参
        int vkind;//变量类型
        int vlev;//变量层次
        int vadr;//变量在变量表中的位置，相对第一个变量而言
        VarTable() {}
        VarTable(String vname, String vproc, String vtype, int vkind, int vlev, int vadr) {
            this.vname = vname;
            this.vproc = vproc;
            this.vtype = vtype;
            this.vkind = vkind;
            this.vlev = vlev;
            this.vadr = vadr;
        }
    }

    static class ProTable{
        String pname;
        String ptype;
        int plev;
        int fadr;
        int ladr;
        ProTable() {}
        ProTable(String pname, String ptype, int plev, int fadr, int ladr) {
            this.pname = pname;
            this.ptype = ptype;
            this.plev = plev;
            this.fadr = fadr;
            this.ladr = ladr;
        }
    }

}
