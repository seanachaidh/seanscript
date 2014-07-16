%{

%}

%%

"+"				begin
                                     yylval.yyTOperator:= OPERATOR_PLUS;
                                     return(T_OPERATOR);
                                end;

"-"				begin
                                     yylval.yyTOperator:= OPERATOR_MIN;
                                     return(T_OPERATOR);
                                end;
"*"				begin
                                     yylval.yyTOperator:= OPERATOR_MUL;
                                     return(T_OPERATOR);
                                end;
"/"                             begin
                                     yylval.yyTOperator:= OPERATOR_DIV;
                                     return(T_OPERATOR);
                                end;

"<"                             begin
                                     yylval.yyTCompType:= LESSER;
                                     return(T_CMP);
                                end;
">"                             begin
                                     yylval.yyTCompType:= GREATER;
                                     return(T_CMP);
                                end;

"="                             begin yylval.yyTCompType:= EQUAL;
                                      return(T_CMP);
                                end;

"{"                             begin
                                     return(T_BEGIN);
                                end;

"}"                             begin
                                     return(T_END);
                                end;

":="                            begin
                                     return(T_EQUAL);
                                end;

":"                             begin
                                     return(T_COLON);
                                end;

"print"                         begin
                                     return(T_PRINT);
                                end;

"exit"                          begin
                                     return(T_EXIT);
                                end;

"if"                            begin
                                     return(T_IF);
                                end;

"while"                         begin
                                     return(T_WHILE);
                                end;

"var"                           begin
                                     return(T_VAR);
                                end;

"script"                        begin
                                     return(T_SCRIPT);
                                end;

[1-9][0-9]*			begin
                                     yylval.yyTValue:= TValue.Create(StrToFloat(yytext));
                                     return(T_NUMBER);
                                end;

[a-zA-Z][_a-zA-Z0-9]*           begin
                                     yylval.yyshortstring := yytext;
                                     return(T_IDENTIFIER);
                                end;

";"				begin
                                     return(T_SEMICOLON);
                                end;
[ \t\n]				;
.				begin
                                     writeln('error: unknown character', yytext);
                                end;
%%

