

import java.util.ArrayList;
import java.util.List;

public class ProcessManage {
    static PCB currentProcess = null;
    static List<PCB>[] ready_list = new List[3];
    static List<PCB> block_list;
    static {
        for (int i = 0; i < 3; i++) {
            ready_list[i] = new ArrayList<PCB>();
            block_list = new ArrayList<PCB>();
        }
    }

    public static void Init() {
        PCB initProcess = new PCB("init", new Status(Status.RUNNING, ready_list[0]), null, 0);
        currentProcess = initProcess;
        ready_list[0].add(currentProcess);
    }
  
    public static void CreateProcess(String PID, Integer priority) {
        PCB createProcess = new PCB(PID, new Status(Status.READY, ready_list[priority]), currentProcess, priority);
        currentProcess.pcb_child.add(createProcess);
        ready_list[priority].add(createProcess);
        schedule();
    }

  
    public static void timeout() {
        int flag = -1;
        for (int i = 2; i >= 0; i--) {
            if (ready_list[i].size() > 0) {
                for (int j = 0; j < ready_list[i].size(); j++) {
                    PCB nextProcess = ready_list[i].get(j);
                    if (nextProcess.status.state != Status.RUNNING && nextProcess.status.state != Status.BLOCK) {
                        if (nextProcess.priority >= currentProcess.priority || currentProcess.status.state != Status.RUNNING || currentProcess == null) {
                            /*System.out.println("process "+nextProcess.PID+" is running. process "+currentProcess.PID+" is ready");*/
                            flag = 1;
                            preempt(nextProcess);
                            break;
                        }
                    }
                }
            }
        }
        if (flag == -1) {
            /*System.out.println("process "+currentProcess.PID+" is running.");*/
        }
    }
    
    public static void changeToReady(PCB process, Integer resourceIndex) {
        process.other_resource[0] = 0;
        block_list.remove(process);
        process.status.state = Status.READY;
        process.status.list = ready_list[process.priority];
        process.request_resource.add(resourceIndex);
        ready_list[process.priority].add(process);
        schedule();
    }

 
   
    public static PCB changeToBlock(PCB process, int count) {
        process.other_resource[0] = count;
        ready_list[process.priority].remove(process);
        process.status.state = Status.BLOCK;
        process.status.list = block_list;
        block_list.add(process);
        return process;
    }
  
    public static void deleteProcess(String PID) {
        PCB deleteProcess = null;
        for (int i = 0; i < 3; i++) {   
            for (int j = 0; j < ready_list[i].size(); j++) {
                if (ready_list[i].get(j).PID.equals(PID)) {
                    deleteProcess = ready_list[i].get(j);
                    ready_list[i].remove(j);
                    break;
                }
            }
        }
        for (int i = 0; i < block_list.size(); i++) {  
            if (block_list.get(i).PID.equals(PID)) {
                deleteProcess = block_list.get(i);
                block_list.remove(i);
                break;
            }
        }
        if (deleteProcess != null) {           
            deleteProcess.status.state = Status.DEAD;
            List<String> children = new ArrayList<>();
            for (int i = 0; i < deleteProcess.pcb_child.size(); i++) {
                children.add(deleteProcess.pcb_child.get(i).PID);
            }
            ResourceManage.clearDestroyProcess(deleteProcess.PID);
            for (int i = 0; i < children.size(); i++) {
                deleteProcess(children.get(i));
            }
            deleteProcess.pcb_parent.pcb_child.remove(deleteProcess);
            for (int i = 0; i < deleteProcess.request_resource.size(); i++) {
                Integer releaseResourceIndex = deleteProcess.request_resource.get(i);
                ResourceManage.releaseResources(deleteProcess, "R"+releaseResourceIndex,
                        deleteProcess.other_resource[releaseResourceIndex]);
            }
        }else {
            System.out.println("no this process");
        }

        int isReleaseRoot = 0;
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < ready_list[i].size(); j++) {
                if (deleteProcess.pcb_parent != null && ready_list[i].get(j).PID.equals(deleteProcess.pcb_parent.PID)) {
                    isReleaseRoot = 1;
                    break;
                }
            }
        }

        for (int i = 0; i < block_list.size(); i++) {
            if (deleteProcess.pcb_parent != null && block_list.get(i).PID.equals(deleteProcess.pcb_parent.PID)) {
                isReleaseRoot = 1;
                break;
            }
        }
        if (isReleaseRoot == 1) {
            for (int i = 2; i >= 0; i--) {
                if (ready_list[i].size() > 0) {
                    PCB nextProcess = ready_list[i].get(0);
                    nextProcess.status.state = Status.RUNNING;
                    currentProcess = nextProcess;
                    break;
                }
            }
        }
    }

    public static void schedule() {
        for (int i = 2; i >= 0; i--) {
            if (ready_list[i].size() > 0) {
                PCB nextProcess = ready_list[i].get(0);
                if (currentProcess.status.state == Status.DEAD) {
                    ready_list[currentProcess.priority].remove(currentProcess);
                    nextProcess.status.state = Status.RUNNING;
                    currentProcess = nextProcess;
                }else if (nextProcess.priority > currentProcess.priority || currentProcess.status.state != Status.RUNNING || currentProcess == null) {
                    preempt(nextProcess);
                }
            }
        }
    }


    private static void preempt(PCB nextProcess) {
        ready_list[currentProcess.priority].remove(currentProcess);
        currentProcess.status.state = Status.READY;
        ready_list[currentProcess.priority].add(currentProcess);
        nextProcess.status.state = Status.RUNNING;
        currentProcess = nextProcess;
    }

    public static void showCurrentProcess() {
        System.out.print(currentProcess.PID+" ");
    }

    public static void listReady() {
        for (int i = 2; i >= 0; i--) {
            System.out.print(i + ":");
            for (int j = 0; j < ready_list[i].size(); j++) {
                if (!(ready_list[i].get(j).status.state == Status.RUNNING)) {
                    if (j == (ready_list[i].size()-1)) {
                        System.out.print(ready_list[i].get(j).PID );
                    }else {
                        System.out.print(ready_list[i].get(j).PID+"-");
                    }
                }
            }
            System.out.print(" ");
        }
    }


    public static void requestResource(String resourceName, Integer count) {
        int resource_index = -1;
        switch (resourceName.charAt(1)) {
            case '1': resource_index = 1; break;
            case '2': resource_index = 2; break;
            case '3': resource_index = 3; break;
            case '4': resource_index = 4; break;
        }
        boolean flag = ResourceManage.requestResources(resourceName, count, currentProcess);
        if (!flag) {
           
            for (int i = 2; i >= 0; i--) {
                if (ready_list[i].size() > 0) {
                    for (int j = 0; j < ready_list[i].size(); j++) {
                        PCB nextProcess = ready_list[i].get(j);
                        if (nextProcess.status.state != Status.RUNNING) {
                            if (nextProcess.priority >= currentProcess.priority || currentProcess.status.state != Status.RUNNING || currentProcess == null) {
                                /*System.out.println("process "+nextProcess.PID+" is running. process "+currentProcess.PID+" is blocked");*/

                                ready_list[currentProcess.priority].remove(currentProcess);
                                nextProcess.status.state = Status.RUNNING;
                                currentProcess = nextProcess;
                                break;
                            }
                        }
                    }
                }
            }
        }else {
            currentProcess.other_resource[resource_index] += count;
            currentProcess.request_resource.add(resource_index);
           /* System.out.println("process " + currentProcess.PID + " request " + count  + " R" + resource_index );*/
        }
    }

    public static void releaseResource(String resourceName, Integer count) {
        int resource_index = -1;
        switch (resourceName.charAt(1)) {
            case '1': resource_index = 1; break;
            case '2': resource_index = 2; break;
            case '3': resource_index = 3; break;
            case '4': resource_index = 4; break;
        }
        currentProcess.other_resource[resource_index] -= count;
        if (currentProcess.other_resource[resource_index] <= 0) {
            currentProcess.request_resource.remove((Object)resource_index);
        }
        ResourceManage.releaseResources(currentProcess, resourceName, count);
    }

}
