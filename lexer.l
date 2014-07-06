%{

%}

%%

//operators
"+"				begin yylval.yyTOperatorType:= OPERATOR_PLUS; return(T_OPERATOR); end;
"-"				begin yylval.yyTOperatorType:= OPERATOR_MIN; return(T_OPERATOR); end;
"*"				begin yylval.yyTOperatorType:= OPERATOR_MUL; return(T_OPERATOR); end;
"/"                             begin yylval.yyTOperatorType:= OPERATOR_DIV; return(T_OPERATOR); end;

//comparators
"<"                             begin yylval.TCmpType:= LESSER; retrun(T_CMP); end;
">"                             begin yylval.TCmpType:= GREATER; return(T_CMP); end;
"="                             begin yylval.TCmpType:= EQUAL; return(T_CMP); end;

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
[a-zA-Z][_a-zA-Z0-9]*           begin yylval.yynstring := yytext; return(T_IDENTIFIER); end;
";"				return(T_SEMICOLON);
[ \t\n]				;
.				writeln('error: unknown character', yytext);

%%
