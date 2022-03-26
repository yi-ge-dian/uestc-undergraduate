

public class ResourceManage {
    //RI=I(1=<I<=4)
    static RCB R1;
    static RCB R2;
    static RCB R3;
    static RCB R4;
    static {
        R1 = new RCB(1);
        R2 = new RCB(2);
        R3 = new RCB(3);
        R4 = new RCB(4);
    }

    public static boolean requestResources(String resourceName, int count, PCB process) {
        if ("R1".equals(resourceName)) {
            if (R1.RID >= count) {
                if (R1.number >= count){
                    R1.number -= count;
                    return true;
                }else {
                    PCB nowProcess = ProcessManage.changeToBlock(process, count);
                    R1.list.add(nowProcess);
                }
            }else {
                System.out.println("The number of resources applied exceeds the total number of resources");
            }
        }else if ("R2".equals(resourceName)) {
            if (R2.RID >= count) {
                if (R2.number >= count){
                    R2.number -= count;
                    return true;
                }else {
                    PCB nowProcess = ProcessManage.changeToBlock(process, count);
                    R2.list.add(nowProcess);
                }
            }else {
                System.out.println("The number of resources applied exceeds the total number of resources");
            }
        }else if ("R3".equals(resourceName)) {
            if (R3.RID >= count) {
                if (R3.number >= count){
                    R3.number -= count;
                    return true;
                }else {
                    PCB nowProcess = ProcessManage.changeToBlock(process, count);
                    R3.list.add(nowProcess);
                }
            }else {
                System.out.println("The number of resources applied exceeds the total number of resources");
            }
        }else if ("R4".equals(resourceName)) {
            if (R4.RID >= count) {
                if (R4.number >= count){
                    R4.number -= count;
                    return true;
                }else {
                    PCB nowProcess = ProcessManage.changeToBlock(process, count);
                    R4.list.add(nowProcess);
                }
            }else {
                System.out.println("The number of resources applied exceeds the total number of resources");
            }
        }
        return false;
    }

    public static void releaseResources(PCB Process, String resourceName, int count) {
        if ("R1".equals(resourceName)) {    
            /*System.out.println(Process.PID + " release R1 " + count);*/
            R1.number += count;
            if (R1.list.size() > 0) {
                int req_num = R1.list.get(0).other_resource[0];
                int index = 0;
                while ( index < R1.list.size() && R1.number >= req_num ) {
                    req_num = R1.list.get(index).other_resource[0];
                    /*System.out.print("wake up process "+R1.list.get(index).PID + ". ");*/
                    R1.number -= req_num;
                    ProcessManage.changeToReady(R1.list.get(index), 1);
                    R1.list.get(index).other_resource[1] = req_num;
                    R1.list.remove(index);
                    index++;
                }
                /* System.out.println();*/
            }
        }else if ("R2".equals(resourceName)) {
            /*System.out.println(Process.PID + " release R2 " + count);*/
            R2.number += count;
            if (R2.list.size() > 0) {
                int req_num = R2.list.get(0).other_resource[0];
                int index = 0;
                while ( index < R2.list.size() && R2.number >= req_num ) {
                    req_num = R2.list.get(index).other_resource[0];
                    /*System.out.print("wake up process "+R2.list.get(index).PID + ". ");*/
                    R2.number -= req_num;
                    ProcessManage.changeToReady(R2.list.get(index), 2);
                    R2.list.get(index).other_resource[2] = req_num;
                    R2.list.remove(index);
                    index++;
                }
               /* System.out.println();*/
            }
        }else if ("R3".equals(resourceName)) {
            /*System.out.println(Process.PID + " release R3 " + count);*/
            R3.number += count;
            if (R3.list.size() > 0) {
                int req_num = R3.list.get(0).other_resource[0];
                int index = 0;
                while ( index < R3.list.size() && R3.number >= req_num ) {
                    req_num = R3.list.get(index).other_resource[0];
                    /*System.out.print("wake up process "+R3.list.get(index).PID + ". ");*/
                    R3.number -= req_num;
                    ProcessManage.changeToReady(R3.list.get(index), 3);
                    R3.list.get(index).other_resource[3] = req_num;
                    R3.list.remove(index);
                    index++;
                }
               /* System.out.println();*/
            }
        }else if ("R4".equals(resourceName)) {
            /*System.out.println(Process.PID + " release R4 " + count);*/
            R4.number += count;
            if (R4.list.size() > 0) {
                int req_num = R4.list.get(0).other_resource[0];
                int index = 0;
                while ( index < R4.list.size() && R4.number >= req_num ) {
                    req_num = R4.list.get(index).other_resource[0];
                    /*System.out.print("wake up process "+R4.list.get(index).PID + ". ");*/
                    R4.number -= req_num;
                    ProcessManage.changeToReady(R4.list.get(index), 4);
                    R4.list.get(index).other_resource[4] = req_num;
                    R4.list.remove(index);
                    index++;
                }
               /* System.out.println();*/
            }
        }
    }


    public static void clearDestroyProcess(String pid) {
        for (int i = 0; i < R1.list.size(); i++) {
            if (pid.equals(R1.list.get(i).PID)) {
                R1.list.remove(i);
                break;
            }
        }
        for (int i = 0; i < R2.list.size(); i++) {
            if (pid.equals(R2.list.get(i).PID)) {
                R2.list.remove(i);
                break;
            }
        }
        for (int i = 0; i < R3.list.size(); i++) {
            if (pid.equals(R3.list.get(i).PID)) {
                R3.list.remove(i);
                break;
            }
        }
        for (int i = 0; i < R4.list.size(); i++) {
            if (pid.equals(R4.list.get(i).PID)) {
                R4.list.remove(i);
                break;
            }
        }
    }
    
    public static void listResources() {
        System.out.println("R1 "+R1.number);
        System.out.println("R2 "+R2.number);
        System.out.println("R3 "+R3.number);
        System.out.println("R4 "+R4.number);
    }

    public static void listBlock() {
        System.out.print("R1 ");
        for (int i = 0; i < R1.list.size(); i++) {
            System.out.print(R1.list.get(i).PID+" ");
        }
        System.out.println();

        System.out.print("R2 ");
        for (int i = 0; i < R2.list.size(); i++) {
            System.out.print(R2.list.get(i).PID+" ");
        }
        System.out.println();

        System.out.print("R3 ");
        for (int i = 0; i < R3.list.size(); i++) {
            System.out.print(R3.list.get(i).PID+" ");
        }
        System.out.println();

        System.out.print("R4 ");
        for (int i = 0; i < R4.list.size(); i++) {
            System.out.print(R4.list.get(i).PID+" ");
        }
        System.out.println();
    }


}
