/**
 * @author YiGeDian
 * @date 2021/5/21 15:49
 */
public class Lexical_CharToState {
    public static int CharToState(char s) {
        switch (s) {
            case ' ':
            case '\r':
            case '\n':
                return -1;
            case '\t':
                return 0;
            case 'a':
            case 'b':
            case 'c':
            case 'd':
            case 'e':
            case 'f':
            case 'g':
            case 'h':
            case 'i':
            case 'j':
            case 'k':
            case 'l':
            case 'm':
            case 'n':
            case 'o':
            case 'p':
            case 'q':
            case 'r':
            case 's':
            case 't':
            case 'u':
            case 'v':
            case 'w':
            case 'x':
            case 'y':
            case 'z':
            case 'A':
            case 'B':
            case 'C':
            case 'D':
            case 'E':
            case 'F':
            case 'G':
            case 'H':
            case 'I':
            case 'J':
            case 'K':
            case 'L':
            case 'M':
            case 'N':
            case 'O':
            case 'P':
            case 'Q':
            case 'R':
            case 'S':
            case 'T':
            case 'U':
            case 'V':
            case 'W':
            case 'X':
            case 'Y':
            case 'Z':
                return 1; // 英文字母'a'~'z'和'A'~'Z'
            case '0':
            case '1':
            case '2':
            case '3':
            case '4':
            case '5':
            case '6':
            case '7':
            case '8':
            case '9':
                return 2; // 数字'1'~'9'
            case '=':
                return 3;
            case '-':
            case '*':
            case '(':
            case ')':
            case ';':
                return 4;
            case '<':
                return 5;
            case '>':
                return 6;
            case ':':
                return 7;
            default:
                return 8;
        }
    }
}
