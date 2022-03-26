
import java.io.*;
import java.util.Scanner;


public class TestShell {
    public static void main(String[] args) throws IOException {
        ProcessManage.Init();
        System.out.print("init"+" ");
        // loadFile(args[0]);
            System.out.println();
            Scanner scanner = new Scanner(System.in); //scanner接收输入
            while (scanner.hasNextLine()) {
                String input = scanner.nextLine();
                if (input.trim().equals("")) { //空命令时继续接收
                    continue;
                }
                exec(input);
            }
        }
    /*private static void loadFile(String filePath) throws IOException {
        new FileInputStream(filePath);
        LineNumberReader reader = new LineNumberReader(new FileReader(filePath));
        String cmd = null;

        while((cmd = reader.readLine()) != null) {
            if (!"".equals(cmd)) {
                exec(cmd);
            }
        }

    }*/
    public static void exec(String input) {
        String[] commands = new String[]{input};
        for (String command : commands) { //对不同的输入命令进行处理
            String[] cmds = command.split("\\s+");
            switch (cmds.length) {
                case 1:
                    if ("init".equals(cmds[0])) {
                        ProcessManage.Init();
                    }else if ("to".equals(cmds[0])) {
                        ProcessManage.timeout();
                    }else {
                        System.out.println("please input the correct command");
                    }
                    break;
                case 2:
                    if ("de".equals(cmds[0])) {
                        ProcessManage.deleteProcess(cmds[1]);
                    }else if ("list".equals(cmds[0])) {
                        if ("ready".equals(cmds[1])) {
                            ProcessManage.listReady();
                        }else if ("block".equals(cmds[1])) {
                            ResourceManage.listBlock();
                        }else if ("res".equals(cmds[1])){
                            ResourceManage.listResources();
                        }
                        else {
                            System.out.println("please input the correct command");
                        }
                    }else {
                        System.out.println("please input the correct command");
                    }
                    break;
                case 3:
                    if ("cr".equals(cmds[0])) {
                        ProcessManage.CreateProcess(cmds[1], Integer.valueOf(cmds[2]));
                    }else if ("req".equals(cmds[0])) {
                        ProcessManage.requestResource(cmds[1], Integer.valueOf(cmds[2]));
                    }else if ("rel".equals(cmds[0])) {
                        ProcessManage.releaseResource(cmds[1], Integer.valueOf(cmds[2]));
                    }else {
                        System.out.println("please input the correct command");
                    }
                    break;
                default:
                    System.out.println("please input the correct command");
            }
            ProcessManage.showCurrentProcess();
        }

        }
    }
