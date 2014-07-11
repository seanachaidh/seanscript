%{

%}

%%


"+"				begin yylval.yyTOperator:= OPERATOR_PLUS; return(T_OPERATOR); end;
"-"				begin yylval.yyTOperator:= OPERATOR_MIN; return(T_OPERATOR); end;
"*"				begin yylval.yyTOperator:= OPERATOR_MUL; return(T_OPERATOR); end;
"/"                             begin yylval.yyTOperator:= OPERATOR_DIV; return(T_OPERATOR); end;


"<"                             begin yylval.yyTCompType:= LESSER; return(T_CMP); end;
">"                             begin yylval.yyTCompType:= GREATER; return(T_CMP); end;
"="                             begin yylval.yyTCompType:= EQUAL; return(T_CMP); end;

"{"                             return(T_BEGIN);
"}"                             return(T_END);

":="                            return(T_EQUAL);
":"                             return(T_COLON);
"print"                         return(T_PRINT);
"exit"                          return(T_EXIT);

"if"                            return(T_IF);
"while"                         return(T_WHILE);

"var"                           return(T_VAR);
"script"                        return(T_SCRIPT);

[1-9][0-9]*			begin
                                     yylval.yyTValue:= TValue.Create(StrToFloat(yytext));
                                     return(T_NUMBER);
                                     end;
[a-zA-Z][_a-zA-Z0-9]*           begin yylval.yyshortstring := yytext; return(T_IDENTIFIER); end;
";"				return(T_SEMICOLON);
[ \t\n]				;
.				writeln('error: unknown character', yytext);

%%
