%{

%}

%%

"+"				begin
                                     if NonkelDebug then writeln('T_OPERATOR');
                                     yylval.yyTOperator:= OPERATOR_PLUS;
                                     return(T_OPERATOR);
                                end;

"-"				begin
                                     if NonkelDebug then writeln('T_OPERATOR);
                                     yylval.yyTOperator:= OPERATOR_MIN;
                                     return(T_OPERATOR);
                                end;
"*"				begin
                                     if NonkelDebug then writeln('T_OPERATOR);
                                     yylval.yyTOperator:= OPERATOR_MUL;
                                     return(T_OPERATOR);
                                end;
"/"                             begin
                                     if NonkelDebug then writeln('T_OPERATOR);
                                     yylval.yyTOperator:= OPERATOR_DIV;
                                     return(T_OPERATOR);
                                end;

"<"                             begin
                                     if NonkelDebug then writeln('T_CMP');
                                     yylval.yyTCompType:= LESSER;
                                     return(T_CMP);
                                end;
">"                             begin
                                     if NonkelDebug then writeln('T_CMP');
                                     yylval.yyTCompType:= GREATER;
                                     return(T_CMP);
                                end;

"="                             begin
                                     if NonkelDebug then writeln('T_CMP');
                                     yylval.yyTCompType:= EQUAL;
                                     return(T_CMP);
                                end;

"{"                             begin
                                     if NonkelDebug then writeln('T_BEGIN);
                                     return(T_BEGIN);
                                end;

"}"                             begin
                                     if NonkelDebug then writeln('T_END');
                                     return(T_END);
                                end;

":="                            begin
                                     if NonkelDebug then writeln('T_EQUAL');
                                     return(T_EQUAL);
                                end;

":"                             begin
                                     if NonkelDebug then writeln('T_COLON');
                                     return(T_COLON);
                                end;

"print"                         begin
                                     if NonkelDebug then writeln('T_PRINT');
                                     return(T_PRINT);
                                end;

"exit"                          begin
                                     if NonkelDebug then writeln('T_PRINT');
                                     return(T_EXIT);
                                end;

"if"                            begin
                                     if NonelDebug then writeln('T_IF');
                                     return(T_IF);
                                end;

"while"                         begin
                                     if NonkelDebug then writeln('T_WHILE');
                                     return(T_WHILE);
                                end;

"var"                           begin
                                     if NonkelDebug then writeln('T_VAR');
                                     return(T_VAR);
                                end;

"script"                        begin
                                     if NonkelDebug then writeln('T_SCRIPT');
                                     return(T_SCRIPT);
                                end;

[1-9][0-9]*			begin
                                     if NonkelDebug then writeln('T_NUMBER');
                                     yylval.yyTValue:= TValue.Create(StrToFloat(yytext));
                                     return(T_NUMBER);
                                end;

[a-zA-Z][_a-zA-Z0-9]*           begin
                                     if NonkelDebug then writeln('T_IDENTIFIER');
                                     yylval.yyshortstring := yytext;
                                     return(T_IDENTIFIER);
                                end;

";"				begin
                                     if NonkelDebug then writeln('T_SEMICOLON');
                                     return(T_SEMICOLON);
                                end;
[ \t\n]				;
.				begin
                                     writeln('error: unknown character', yytext);
                                end;
%%

