
import java.io.*;


/**
 * @author YiGeDian
 * @date 2021/5/21 11:26
 */
public class Lexical_Analyzer {
    public static void writeDydFile(String str) throws IOException {
        File file_dyd = new File("source.dyd");
        FileWriter fileWriter_dyd=new FileWriter(file_dyd,true);
        fileWriter_dyd.write(str);
        fileWriter_dyd.close();
    }
    public static void writeErrorFile(String str) throws IOException {
        File file_err=new File("source.err");
        FileWriter fileWriter_err=new FileWriter(file_err,true);
        fileWriter_err.write(str);
        fileWriter_err.close();
    }
    public static void main(String[] args) throws IOException {
        /*读取文件*/
        File file_pas = new File("source.pas");
        File file_err = new File("source.err");
        File file_dyd = new File("source.dyd");
        /*读取文件变量*/
        PushbackReader  reader = null;
        /*接受reader读取变量*/
        int tempChar;
        /*存储reader的字符*/
        char character=' ';
        /*根据读取的字符数得到返回值*/
        int state=0;
        int finalState=0;
        /*文件行号*/
        int line=1;
        /*存储一个串*/
        StringBuffer buffer=new StringBuffer();
        /*文件是否存在*/
        if ((!file_dyd.exists())||(!file_dyd.isFile())){
            file_dyd.createNewFile();
        }
        if ((!file_err.exists())||(!file_err.isFile())){
            file_err.createNewFile();
        }
        /*初始化读取文件变量*/
        try {
            reader = new PushbackReader(new FileReader(file_pas));
            /*System.out.println("Read successfully!");*/
        } catch (IOException e) {
            System.out.print(e);
        }
        /*写初始化，每次写会重写文件内容*/
        FileWriter fileWriter_dyd=new FileWriter(file_dyd);
        FileWriter fileWriter_err=new FileWriter(file_err);
        fileWriter_dyd.write("");
        fileWriter_err.write("");
        /*开始读取内容并进行判断*/
        while ((tempChar=reader.read())!=-1||((tempChar=reader.read())==-1)&&(finalState==1||finalState==2||finalState==5||finalState==6||finalState==7)){
            if (((char)tempChar)=='\n'){
                line++;
                String str=String.format("%16s","EOLN")+" "+"24\n";
                writeDydFile(str);
                buffer.delete(0,buffer.length());
            }else{
                character=(char)tempChar;
                state= Lexical_CharToState.CharToState(character);
                if (finalState==1||state==1&&finalState==0){//标识符:字母或者数字
                    if (state==1||state==2){
                        buffer.append(character);
                        finalState=1;
                        continue;
                    }else{
                        String word=buffer.toString();
                        if (word.length()>16){
                            String str = "***LINE" + line + ":  Identifier "+"'"+buffer.toString()+"'"+ "is too long.\n";
                            writeErrorFile(str);
                        }else {
                            String str=String.format("%16s", word) + " " + Lexical_WordToIdType.wordToIdType(word) + "\n";
                            writeDydFile(str);
                        }
                        buffer.delete(0,buffer.length());
                        reader.unread(tempChar);
                    }
                }
                if (finalState == 2 || state == 2&&finalState==0) {// 接收到数字串
                    if (state == 2) {
                        buffer.append(character);
                        finalState = 2;
                        continue;
                    } else {
                        String word = buffer.toString();
                        if (word.length()>16){
                            String str = "***LINE" + line + ":  Number "+"'"+buffer.toString()+"'"+ "is too long.\n";
                            writeErrorFile(str);
                        }else{
                            String str=String.format("%16s", word) + " " + Lexical_WordToIdType.wordToIdType(word) + "\n";
                            writeDydFile(str);
                        }
                        buffer.delete(0, buffer.length());
                        reader.unread(tempChar);
                    }
                }
                if (finalState == 0 && state == 3) {// 接收到=
                    buffer.append(character);
                    String word = buffer.toString();
                    String str=String.format("%16s", word) + " " + Lexical_WordToIdType.wordToIdType(word) + "\n";
                    writeDydFile(str);
                    buffer.delete(0, buffer.length());
                }
                if (finalState == 0 && state == 4) {// 接收到-，*，(，),;
                    buffer.append(character);
                    String word = buffer.toString();
                    String str=String.format("%16s", word) + " " + Lexical_WordToIdType.wordToIdType(word) + "\n";
                    writeDydFile(str);
                    buffer.delete(0, buffer.length());
                }
                if (finalState == 5 || state == 5&&finalState==0) {//接受到<,<=,<>
                    if (finalState == 0 && state == 5) {//接受到<
                        buffer.append(character);
                        finalState = 5;
                        continue;
                    } else if (finalState == 5 && (state == 3 || state == 6)) {//如果为<=,<>
                        buffer.append(character);
                        String word = buffer.toString();
                        String str=String.format("%16s", word) + " " + Lexical_WordToIdType.wordToIdType(word) + "\n";
                        writeDydFile(str);
                        buffer.delete(0, buffer.length());
                        finalState=0;
                        continue;
                    } else { // 为小于号
                        String word = buffer.toString();
                        String str=String.format("%16s", word) + " " + Lexical_WordToIdType.wordToIdType(word) + "\n";
                        writeDydFile(str);
                        buffer.delete(0, buffer.length());
                        reader.unread(tempChar);
                    }
                }
                if (finalState == 6 || state == 6&&finalState==0) {// 接受>=,>
                    if (finalState == 0 && state == 6) {
                        buffer.append(character);
                        finalState = 6;
                        continue;
                    } else if (finalState == 6 && state == 3) {
                        buffer.append(character);
                        String word = buffer.toString();
                        String str = String.format("%16s", word) + " " + Lexical_WordToIdType.wordToIdType(word) + "\n";
                        writeDydFile(str);
                        buffer.delete(0, buffer.length());
                        finalState=0;
                        continue;
                    } else {
                        String word = buffer.toString();
                        String str = String.format("%16s", word) + " " + Lexical_WordToIdType.wordToIdType(word) + "\n";
                        writeDydFile(str);
                        buffer.delete(0, buffer.length());
                        reader.unread(tempChar);
                    }
                }
                if (finalState==7||state==7&&finalState==0){//:=
                    if (finalState == 0 && state == 7) {//先接受到:
                        buffer.append(character);
                        finalState= 7;
                        continue;
                    }else if (finalState == 7 && state == 3) {
                        buffer.append(character);
                        String word = buffer.toString();
                        String str=String.format("%16s", word) + " " +Lexical_WordToIdType.wordToIdType(word) + "\n";
                        writeDydFile(str);
                        buffer.delete(0, buffer.length());
                        finalState=0;
                        continue;
                    }else {
                        String str = "***LINE" + line + ":  Missing \"=\" after \":\".\n";
                        writeErrorFile(str);
                        buffer.delete(0, buffer.length());
                        reader.unread(tempChar);
                    }
                }
                if (tempChar==-1){//文件结束
                    break;//跳出循环
                }
                if (state == 8&&finalState==0) {
                    buffer.append(character);
                    String str = "***LINE" + line + ": "+"'"+buffer.toString()+"'"+"is invalid symbol.\n";
                    writeErrorFile(str);
                    buffer.delete(0, buffer.length());
                }
                finalState=0;
            }
        }
        /*文件读取完毕*/
        reader.close();
        String str=String.format("%16s","EOF")+" "+"25";
        writeDydFile(str);
    }
}