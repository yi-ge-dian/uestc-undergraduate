/**
 * @author YiGeDian
 * @date 2021/6/12 21:40
 */
/**
 * <program>-><subProgram>
 * <subProgram>->begin<declareStatementList>;<executeStatementList>end
 * <declareStatementList>-><declareStatement><declareStatementList_L()>
 * <declareStatementList_L>->;<declareStatement><declareStatementList_L>|epsilon
 * <declareStatement>-><declareVariable>|<declareFunction>
 * <declareVariable>->integer<variable>
 * <variable>-><identifier>
 * <identifier>-><letter><identifier_I>
 * <identifier_I>-><letter><identifier_I>│<digit><identifier_I>|epsilon
 * <letter>->a~z|A~Z
 * <digit>->0~9
 * <declareFunction>->integer function <identifier>(<parameter>);<functionBody>
 * <parameter>-><variable>
 * <functionBody>->begin<declareStatementList>;<executeStatementList>end
 * <executeStatementList>-><executeStatement><executeStatementList_L>
 * <executeStatementList_L>->;<executeStatement><executeStatementList_L>|epsilon
 * <executeStatement>-><readStatement>|<writeStatement>|<assignStatement>|<conditionalStatement>
 * <readStatement>->read(<variable>)
 * <writeStatement>->write(<variable>)
 * <assignStatement>-><variable>:=<arithmeticalExpression>
 * <arithmeticalExpression>-><item><arithmeticalExpression_E>
 * <arithmeticalExpression_E>->-<item><arithmeticalExpression_E>|epsilon
 * <item>-><factor><item_I>
 * <item_I>->*<factor><item_I>|epsilon
 * <factor>-><variable>|<constant>|<functionCall>;
 * <constant>-><unsignedInteger>
 * <unsignedInteger>-><digit><unsignedInteger_I>
 * <unsignedInteger_I>-><digit><unsignedInteger_I>|epsilon
 * <functionCall>-><identifier>(<arithmeticalExpression>);
 * <conditionalStatement>->if<conditionalExpression>then<executeStatement>else<executeStatement>
 * <conditionalExpression>-><arithmeticalExpression><relationalOperator><arithmeticalExpression>
 * <relationalOperator>-><│<=│>│>=│=│<>
 */
