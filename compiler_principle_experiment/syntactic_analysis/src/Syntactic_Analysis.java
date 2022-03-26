
import java.io.*;
import java.nio.charset.StandardCharsets;

/**
 * @author YiGeDian
 * @date 2021/6/9 10:08
 */
public class Syntactic_Analysis {
    public static Syntactic_Table.VarTable[] varTables=new Syntactic_Table.VarTable[100];
    public static Syntactic_Table.ProTable[] proTables=new Syntactic_Table.ProTable[100];
    String[] words=new String[150];	//用来存放二元式中的单词
    String currentWord;		        //当前单词
    String[] types=new String[150];	//用来存放二元式中的种类
    String currentType;		        //当前种类
    int line=0;                     //当前运行的行数
    int level=0;                    //程序的层次
    int proNumber=0;                //程序的数目
    int address=0;                  //变量在变量表中的位置，address+1为变量的数目
    String lastWord;                //上一个单词
    String lastType;                //上一个单词类型
    int index=0;                    //当前单词的位置
    String err;                     //出错信息
    int errNumber=0;                //出错数量
    int errFlag=0;                  //出错标志位
    int declareFlag=0;              //说明语句标志位
    int proFlag=0;                  //程序标志位
    String form;                    //变量类型
    int isArgument;                 //是否为参数

    /**
     * 初始化变量名表
     * @param file
     * @throws IOException
     */
    public void initializeVarFile(File file) throws IOException {
        FileWriter fileWriter_var = new FileWriter(file,true);
        fileWriter_var.write(String.format("%16s", "vname") + "  ");
        fileWriter_var.write(String.format("%16s", "vproc") + "  ");
        fileWriter_var.write(String.format("%5s", "vkind") + "  ");
        fileWriter_var.write(String.format("%16s", "vtype") + "  ");
        fileWriter_var.write(String.format("%4s", "vlev") + "  ");
        fileWriter_var.write(String.format("%4s", "vadr") + "\n");
        fileWriter_var.close();
    }

    /**
     * 初始化过程名表
     * @param file
     * @throws IOException
     */
    public void initializeProFile(File file) throws IOException {
        FileWriter fileWriter_pro = new FileWriter(file, true);
        fileWriter_pro.write(String.format("%16s", "pname") + "  ");
        fileWriter_pro.write(String.format("%16s", "ptype") + "  ");
        fileWriter_pro.write(String.format("%4s", "plev") + "  ");
        fileWriter_pro.write(String.format("%4s", "fadr") + "  ");
        fileWriter_pro.write(String.format("%4s", "ladr") + "\n");
        fileWriter_pro.close();
    }

    /**
     * 将*.dyd初始化为单词符号数组和种别数组
     * @param file
     * @throws IOException
     */
    public void initializeDydFile(File file) throws IOException {
        FileInputStream fileInputStream = new FileInputStream(file);
        InputStreamReader inputStreamReader = new InputStreamReader(fileInputStream, StandardCharsets.UTF_8);
        BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
        String readline;
        int i=0;
        while ((readline =bufferedReader.readLine()) != null) {
            words[i]=readline.substring(0,16).trim();
            types[i]=readline.substring(17,19);
            i++;
        }
        currentWord=words[0];
        currentType=types[0];
        varTables[0]=new Syntactic_Table.VarTable("","","",0,0,0);
        bufferedReader.close();
        inputStreamReader.close();
        fileInputStream.close();
    }

    /**
     * 当前变量写入写*.dys文件
     * @param file
     * @param word
     * @param type
     * @throws IOException
     */
    public void writeDysFile(File file,String word,String type) throws IOException {
        FileWriter fileWriter_dys = new FileWriter(file,true);
        fileWriter_dys.write(String.format("%16s", word) + " ");
        if (word.equals("EOF")){
            fileWriter_dys.write(type);
        }else {
            fileWriter_dys.write(type+"\n");
        }
        fileWriter_dys.close();
    }

    /**
     * 错误信息写入*.err文件
     * @param file
     * @param err
     * @throws IOException
     */
    public void writeErrFile(File file, String err) throws IOException {
        FileWriter fileWriter_err = new FileWriter(file,true);
        fileWriter_err.write("***LINE "+line+": "+err+"\n");
        fileWriter_err.close();
        errNumber++;
        if (err.indexOf("Fatal")!=-1) {//重大错误退出
            System.exit(0);
        }
    }

    /**
     * 变量表的内容写入*.var文件
     * @param file
     * @throws IOException
     */
    public void writeVarFile(File file) throws IOException {
        FileWriter fileWriter_Var = new FileWriter(file,true);
        for (int n = 0; n < address; n++) {
            fileWriter_Var.write(String.format("%16s", varTables[n].vname) + "  ");
            fileWriter_Var.write(String.format("%16s", varTables[n].vproc) + "  ");
            fileWriter_Var.write(String.format("%5s", varTables[n].vkind) + "  ");
            fileWriter_Var.write(String.format("%16s", varTables[n].vtype) + "  ");
            fileWriter_Var.write(String.format("%4s", varTables[n].vlev) + "  ");
            fileWriter_Var.write(String.format("%4s", varTables[n].vadr) + "\n");
        }
        fileWriter_Var.close();
    }

    /**
     * 过程表的内容写入*.pro文件
     * @param file
     * @throws IOException
     */
    public void writeProFile(File file) throws IOException {
        FileWriter fileWriter_Pro = new FileWriter(file,true);
        for (int n = 0; n < proNumber; n++) {
            fileWriter_Pro.write(String.format("%16s", proTables[n].pname) + "  ");
            fileWriter_Pro.write(String.format("%16s", proTables[n].ptype) + "  ");
            fileWriter_Pro.write(String.format("%4s", proTables[n].plev) + "  ");
            fileWriter_Pro.write(String.format("%4s", proTables[n].fadr) + "  ");
            fileWriter_Pro.write(String.format("%4s", proTables[n].ladr) + "\n");
        }
        fileWriter_Pro.close();
    }

    /**
     * 进行预测
     * @param fileDys
     * @param fileErr
     * @param word
     * @param type
     * @param err
     * @throws IOException
     */
    public void forecast(File fileDys,File fileErr,String word,String type,String err) throws IOException {
        if (currentWord.equals(word)){
            errFlag=0;
        }else{
            writeErrFile(fileErr,err);
            writeDysFile(fileDys,currentWord,currentType);
            currentWord=word;
            currentType=type;
            errFlag=1;
        }
    }

    /**
     * 读入下一个单词
     * @throws IOException
     */
    public void readNextWord() throws IOException {
        File file_dys = new File("source.dys");
        lastWord=currentWord;
        lastType=currentType;
        index++;
        currentWord=words[index];
        currentType=types[index];
        if (currentWord.equals("EOLN")){
            writeDysFile(file_dys,currentWord,currentType);
            index++;
            currentWord=words[index];
            currentType=types[index];
            line++;
            if (currentWord.equals("EOF")){//解决空行问题
                writeDysFile(file_dys,currentWord,currentType);
                currentWord="";
                currentType="";
            }
        }else if(currentWord.equals("EOF")){
            writeDysFile(file_dys,currentWord,currentType);
            currentWord="";
            currentType="";
        }
    }

    /**
     * <program>-><subProgram>
     * @throws IOException
     */
    public void program() throws IOException {
        line++;
        proTables[0]= new Syntactic_Table.ProTable();
        proTables[0].pname="main";
        proTables[0].plev=level; //level=1
        proTables[0].ptype="void";
        proNumber++;
        subProgram();

        int fadr=100;
        int ladr=0;
        int tempadr=0;
        for (int n = 0; n < address; n++) {
            if (varTables[n].vlev==0) {//main函数中的变量
                tempadr=varTables[n].vadr;
                if (tempadr<fadr) {
                    proTables[0].fadr=tempadr;
                    fadr=tempadr;
                }
            }
        }
        if (tempadr>ladr) {
            proTables[0].ladr=tempadr;
            ladr=tempadr;
        }
    }

    /**
     * <subProgram>->begin<declareStatementList>;<executeStatementList>end
     * @throws IOException
     */
    public void subProgram() throws IOException {
        File file_dys = new File("source.dys");
        File file_err = new File("source.err");
        if (currentWord.equals("begin")) {
            writeDysFile(file_dys,currentWord, currentType);
            readNextWord();
            declareStatementList();
            if(lastWord.equals(";")) {
                executeStatementList();
                if (currentWord.equals("end")) {
                    writeDysFile(file_dys,currentWord, currentType);
                    readNextWord();
                }else{
                    err="Fatal Error: missing: \"end\"";
                    writeErrFile(file_err,err);
                    readNextWord();
                }
            }else{
                if (!lastWord.equals("function")){
                    err="Fatal Error: missing: \"function\"";
                    writeErrFile(file_err,err);
                }
                err="Error: missing: \";\"";
                writeErrFile(file_err,err);
                readNextWord();
            }
        }else{
            err="Fatal Error: missing \"begin\"";
            writeErrFile(file_err,err);
        }
    }

    /**
     * <declareStatementList>-><declareStatement><declareStatementList_L()>
     * @throws IOException
     */
    public void declareStatementList() throws IOException {
        File file_err = new File("source.err");
        File file_dys = new File("source.dys");
        forecast(file_dys,file_err,"integer", "03", "missing \"integer\"");
        declareStatement();
        declareStatementList_L();
    }

    /**
     * <declareStatementList_L>->;<declareStatement><declareStatementList_L>
     * @throws IOException
     */
    public void declareStatementList_L() throws IOException {
        if (currentWord.equals(";")) {
            File file_dys = new File("source.dys");
            writeDysFile(file_dys,currentWord, currentType);
            readNextWord();
            declareStatement();
            declareStatementList_L();
        }
    }

    /**
     * <declareStatement>->integer<variable>|integer function <identifier>(<parameter>);<functionBody>
     * <declareStatement>-><declareVariable>|<declareFunction>
     * <declareVariable>->integer <variable>
     * <declareFunction>->integer function <identifier>(<parameter>);<functionBody>
     * @throws IOException
     */
    public void declareStatement() throws IOException {
        File file_dys = new File("source.dys");
        File file_err = new File("source.err");
        declareFlag=1;
        if (currentWord.equals("integer")) {
            if (errFlag==0) {
                writeDysFile(file_dys,currentWord,currentType);
            }
            form=currentWord.toUpperCase();
            readNextWord();
            if (currentWord.equals("function")) {
                level++;
                proFlag=1;
                writeDysFile(file_dys,currentWord,currentType);
                readNextWord();
                identifier();
                forecast(file_dys,file_err,"(","21", "missing: \"(\"");
                if (currentWord.equals("(")) {
                    if (errFlag==0) {
                        writeDysFile(file_dys,currentWord,currentType);
                    }else {

                    }
                    errFlag=0;
                    readNextWord();
                    isArgument=1;
                    parameter();
                    forecast(file_dys,file_err,")","22", "missing: \")\"");
                    if (currentWord.equals(")")) {
                        if (errFlag==0) {
                            writeDysFile(file_dys,currentWord,currentType);
                        }else {

                        }
                        errFlag=0;
                        readNextWord();
                        forecast(file_dys,file_err,";","23", "missing: \";\"");
                        if (currentWord.equals(";")) {
                            if (errFlag==0) {
                                writeDysFile(file_dys,currentWord,currentType);
                            }else {

                            }
                            errFlag=0;
                            readNextWord();
                            functionBody();
                        }
                    }
                }
            }else {
                variable();
            }
        }
        declareFlag=0;
    }

    /**
     * <variable>-><identifier>
     * @throws IOException
     */
    public void variable() throws IOException {
        identifier();
    }
    /**
     * <identifier>->currentType=10
     * <identifier>-><letter>│<identifier><letter>│<identifier><digit>
     * @throws IOException
     */
    public void identifier() throws IOException {
        File file_dys = new File("source.dys");
        File file_err = new File("source.err");
        if (currentType.equals("10")) {
            if (declareFlag!=1) {
                int checkFlag=0;
                for (int n = 0; n < proNumber; n++) {
                    if (proTables[n].pname.equals(currentWord)) {
                        writeDysFile(file_dys,currentWord,currentType);
                        readNextWord();
                        checkFlag=1;
                    }
                }
                for (int n = 0; n < address; n++) {
                    if (varTables[n].vname.equals(currentWord)) {
                        writeDysFile(file_dys,currentWord,currentType);
                        readNextWord();
                        checkFlag=1;
                    }
                }
                if (checkFlag==0) {
                    err=currentWord+ " is not defined";
                    writeErrFile(file_err,err);
                    writeDysFile(file_dys,currentWord,currentType);
                    readNextWord();
                }
            }
            if (declareFlag==1) {
                if (proFlag==1) {
                    int checkFlag=0;
                    for (int n = 0; n < proNumber; n++) {
                        if (proTables[n].pname.equals(currentWord)) {
                            checkFlag=1;
                        }
                    }
                    if (checkFlag==0) {
                        proTables[proNumber]=new Syntactic_Table.ProTable(currentWord,form,level,0,0);
                        proNumber++;
                        writeDysFile(file_dys,currentWord,currentType);
                        readNextWord();
                    }else {
                        err="duplicate local variable "+currentWord;
                        writeErrFile(file_err,err);
                        readNextWord();
                    }
                    proFlag=0;
                }else {
                    if (errFlag==0){
                        int checkFlag=0;
                        for (int n = 0; n < proNumber; n++) {
                            if (proTables[n].pname.equals(currentWord)) {
                                checkFlag=1;
                            }
                        }
                        for (int n = 0; n < address; n++) {
                            if (varTables[n].vname.equals(currentWord)&&varTables[n].vlev==level&&varTables[n].vkind==isArgument) {
                                checkFlag=1;
                            }
                        }
                        if (checkFlag==0) {
                            varTables[address]=new Syntactic_Table.VarTable(currentWord,"",form,isArgument,level,address);
                            for (int n = 0; n < proNumber; n++) {
                                if (proTables[n].plev==level) {
                                    varTables[address].vproc=proTables[n].pname;
                                }
                            }
                            address++;
                            isArgument=0;
                            writeDysFile(file_dys,currentWord,currentType);
                            readNextWord();
                        }else {
                            err="duplicate local variable "+currentWord;
                            writeErrFile(file_err,err);
                            readNextWord();
                        }
                    }
                    else{
                        errFlag=0;
                        writeDysFile(file_dys,currentWord,currentType);
                        readNextWord();
                    }
                }
            }
        }else{
            err="Invalid execution statement";
            writeErrFile(file_err,err);
            writeDysFile(file_dys,currentWord,currentType);
            readNextWord();
        }
    }

    /**
     * <parameter>-><variable>
     * @throws IOException
     */
    public void parameter() throws IOException {
        variable();
    }

    /**
     * <functionBody>->begin<declareStatementList>;<executeStatementList>end
     * @throws IOException
     */
    public void functionBody() throws IOException {
        File file_dys = new File("source.dys");
        File file_err = new File("source.err");
        if (currentWord.equals("begin")) {
            writeDysFile(file_dys,currentWord,currentType);
            readNextWord();
            declareStatementList();
            if (lastWord.equals(";")) {
                executeStatementList();
                if (currentWord.equals("end")) {
                    writeDysFile(file_dys,currentWord,currentType);
                    int fadr=100;
                    int ladr=0;
                    int tempadr=0;
                    for (int n = 0; n < address; n++) {
                        if (varTables[n].vlev==level) {
                            tempadr=varTables[n].vadr;
                            if (tempadr<fadr) {
                                proTables[level].fadr=tempadr;
                                fadr=tempadr;
                            }
                        }
                    }
                    if (tempadr>ladr) {
                        proTables[level].ladr=tempadr;
                        ladr=tempadr;
                    }
                    readNextWord();
                    level--;
                }else{
                    err="missing: \"end\"";
                    writeErrFile(file_err,err);
                }
            }
        }else{
            err="Fatal Error: missing \"begin\"";
            writeErrFile(file_err,err);
        }
    }

    /**
     * <executeStatementList>-><executeStatement><executeStatementList_L>
     * @throws IOException
     */
    public void executeStatementList() throws IOException {
        executeStatement();
        executeStatementList_L();
    }

    /**
     * <executeStatementList_L>->;<executeStatement><executeStatementList_L>
     * @throws IOException
     */
    public void executeStatementList_L() throws IOException {
        File file_dys = new File("source.dys");
        if (currentWord.equals(";")) {
            writeDysFile(file_dys,currentWord,currentType);
            readNextWord();
            executeStatement();
            executeStatementList_L();
        }
    }

    /**
     * <executeStatement>->read(<variable>)|write(<variable>)|if<conditionalExpression>then<executeStatement>else<executeStatement>|<variable>:=<arithmeticalExpression>
     * <executeStatement>-><readStatement>|<writeStatement>|<assignStatement>|<conditionalStatement>
     * <readStatement>->read(<variable>)
     * <writeStatement>->write(<variable>)
     * <conditionalStatement>->if<conditionalExpression>then<executeStatement>else<executeStatement>
     * <assignStatement>-><variable>:=<arithmeticalExpression>
     * @throws IOException
     */
    public void executeStatement( ) throws IOException {
        File file_dys = new File("source.dys");
        File file_err = new File("source.err");
        if (currentWord.equals("read")) {
            writeDysFile(file_dys,currentWord,currentType);
            readNextWord();
            forecast(file_dys,file_err,"(","21", err="missing: \"(\"");
            if (currentWord.equals("(")) {
                if (errFlag==0) {
                    writeDysFile(file_dys,currentWord,currentType);
                }else {

                }
                errFlag=0;
                readNextWord();
                variable();
                forecast(file_dys,file_err,")","22", err="missing: \")\"");
                if (currentWord.equals(")")) {
                    if (errFlag==0) {
                        writeDysFile(file_dys,currentWord,currentType);
                    }else {

                    }
                    errFlag=0;
                    readNextWord();
                }
            }
        }else if (currentWord.equals("write")) {
            writeDysFile(file_dys,currentWord,currentType);
            readNextWord();
            forecast(file_dys,file_err,"(","21", err="missing: \"(\"");
            if (currentWord.equals("(")) {
                if (errFlag==0) {
                    writeDysFile(file_dys,currentWord,currentType);
                }else {

                }
                errFlag=0;
                readNextWord();
                isArgument=1;
                variable();
                forecast(file_dys,file_err,")","22", err="missing: \")\"");
                if (currentWord.equals(")")) {
                    if (errFlag==0) {
                        writeDysFile(file_dys,currentWord,currentType);
                    }else {

                    }
                    errFlag=0;
                    readNextWord();
                }
            }
        }else if (currentWord.equals("if")) {
            writeDysFile(file_dys,currentWord,currentType);
            readNextWord();
            conditionalExpression();
            forecast(file_dys,file_err,"then","05", err="missing: \"then\"");
            if (currentWord.equals("then")) {
                if (errFlag==0) {
                    writeDysFile(file_dys,currentWord,currentType);
                }else {

                }
                errFlag=0;
                readNextWord();
                executeStatement();
                forecast(file_dys,file_err,"else","06", err="missing: \"else\"");
                if (currentWord.equals("else")) {
                    if (errFlag==0) {
                        writeDysFile(file_dys,currentWord,currentType);
                    }else {

                    }
                    errFlag=0;
                    readNextWord();
                    executeStatement();
                }
            }
        }else {
            variable();
            if (currentWord.equals(":=")) {
                writeDysFile(file_dys,currentWord,currentType);
                readNextWord();
                arithmeticalExpression();
            }else {
                writeDysFile(file_dys,currentWord,currentType);
                readNextWord();
            }
        }
    }

    /**
     * <conditionalExpression>-><arithmeticalExpression><relationalOperator><arithmeticalExpression>
     * @throws IOException
     */
    private void conditionalExpression() throws IOException {
        arithmeticalExpression();
        relationalOperator();
        arithmeticalExpression();
    }

    /**
     * <relationalOperator>->12<=type<=17
     * <relationalOperator>-><│<=│>│>=│=│<>
     * @throws IOException
     */
    private void relationalOperator() throws IOException {
        File file_dys = new File("source.dys");
        File file_err = new File("source.err");
        int num=Integer.parseInt(currentType);
        if (num>=12&&num<=17) {
            writeDysFile(file_dys,currentWord,currentType);
            readNextWord();
        }else{
            err="Invalid Symbol.";
            writeErrFile(file_err,err);
        }

    }

    /**
     * <arithmeticalExpression>-><item><arithmeticalExpression_E>
     * @throws IOException
     */
    private void arithmeticalExpression() throws IOException {
        item();
        arithmeticalExpression_E();
    }

    /**
     * <arithmeticalExpression_E>->-<item><arithmeticalExpression_E>
     * @throws IOException
     */
    private void arithmeticalExpression_E() throws IOException {
        File file_dys = new File("source.dys");
        if (currentWord.equals("-")) {
            writeDysFile(file_dys,currentWord,currentType);
            readNextWord();
            item();
            arithmeticalExpression_E();
        }
    }

    /**
     * <item>-><factor><item_I>
     * @throws IOException
     */
    private void item() throws IOException {
        factor();
        item_I();
    }

    /**
     * <item_I>->*<factor><item_I>
     * @throws IOException
     */
    private void item_I() throws IOException {
        File file_dys = new File("source.dys");
        if (currentWord.equals("*")) {
            writeDysFile(file_dys,currentWord,currentType);
            readNextWord();
            factor();
            item_I();
        }
    }

    /**
     *  <factor>->type=10<variable>(<arithmeticalExpression>)|type=10<variable>|type=11
     *  <factor>-><variable>|<constant>|<functionCall>;
     *  <functionCall>->identifier(<arithmeticalExpression>);
     *  <constant>-><unsignedInteger>
     *  <unsignedInteger>-><digit>|<unsignedInteger><digit>
     * @throws IOException
     */
    private void factor() throws IOException {
        File file_dys = new File("source.dys");
        if (currentType.equals("10")) {
            variable();
            if (currentWord.equals("(")) {
                writeDysFile(file_dys,currentWord,currentType);
                readNextWord();
                arithmeticalExpression();
                if (currentWord.equals(")")) {
                    writeDysFile(file_dys,currentWord,currentType);
                    readNextWord();
                }
            }
        }else if (currentType.equals("11")) {
            writeDysFile(file_dys,currentWord,currentType);
            readNextWord();
        }
    }

    public static void main(String[] args) throws IOException {
        File file_dyd = new File("source.dyd");
        File file_err = new File("source.err");
        File file_dys = new File("source.dys");
        File file_var = new File("source.var");
        File file_pro = new File("source.pro");
        //不存在,则创建文件
        if ((!file_dyd.exists())||(!file_dyd.isFile())){
            file_dyd.createNewFile();
        }
        if ((!file_err.exists())||(!file_err.isFile())){
            file_err.createNewFile();
        }
        if ((!file_dys.exists())||(!file_dys.isFile())){
            file_dys.createNewFile();
        }
        if ((!file_var.exists())||(!file_var.isFile())){
            file_var.createNewFile();
        }
        if ((!file_pro.exists())||(!file_pro.isFile())){
            file_pro.createNewFile();
        }
        /*写初始化，每次写会重写文件内容*/
        FileWriter fileWriter_var=new FileWriter(file_var);
        FileWriter fileWriter_pro=new FileWriter(file_pro);
        FileWriter fileWriter_dys=new FileWriter(file_dys);
        FileWriter fileWriter_err=new FileWriter(file_err);
        fileWriter_var.write("");
        fileWriter_pro.write("");
        fileWriter_dys.write("");
        fileWriter_err.write("");
        Syntactic_Analysis syntacticAnalysis = new Syntactic_Analysis();
        syntacticAnalysis.initializeVarFile(file_var);
        syntacticAnalysis.initializeProFile(file_pro);
        syntacticAnalysis.initializeDydFile(file_dyd);
        syntacticAnalysis.program();
        syntacticAnalysis.writeVarFile(file_var);
        syntacticAnalysis.writeProFile(file_pro);
    }
}
