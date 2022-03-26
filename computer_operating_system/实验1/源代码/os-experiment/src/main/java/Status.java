

import java.util.List;

public class Status {

    static final int RUNNING=1;
    static final int READY = 2;
    static final int BLOCK = 3;
    static final int DEAD=-100;

    int state;
    List<PCB> list;

    public Status(int state,List<PCB> list) {
        this.state = state;
        this.list = list;
    }
}
