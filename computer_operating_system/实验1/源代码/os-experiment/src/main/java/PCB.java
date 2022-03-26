

import java.util.ArrayList;
import java.util.List;

public class PCB {
    String PID;
    Status status;
    PCB pcb_parent;
    List<PCB> pcb_child=new ArrayList<>();
    int priority;
    int[] other_resource=new int[5];
    List<Integer> request_resource=new ArrayList<>();

    public PCB(String PID, Status status, PCB pcb_parent, int priority){
        this.PID = PID;
        this.status = status;
        this.pcb_parent = pcb_parent;
        this.priority = priority;
    }

}
