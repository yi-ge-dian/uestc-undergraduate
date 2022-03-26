

import java.util.ArrayList;
import java.util.List;

public class RCB {
    int RID;       
    int number;     
    List<PCB> list;

    public RCB(int RID) {
        this.RID = RID;
        this.number = RID;
        this.list = new ArrayList<>();
    }
}
