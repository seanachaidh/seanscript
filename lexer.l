%{

%}

%%

"+"				return(T_PLUS);
"-"				return(T_MIN);
"*"				return(T_MUL);
"/"
"<"                             return(T_DIV);
"="                             return(T_EQUAL);
":"                             return(T_COLON);
"print"                         return(T_PRINT);
"exit"                          return(T_EXIT);
"if"                            return(T_IF);


[1-9][0-9]*			begin
                                     yylval.yyTNonkelVar:= TNonkelVar.Create('number', strtoint(yytext));
                                     return(T_NUMBER);
                                     end;

[\<\>=]                              begin
                                          case yytext of
                                               '<': yylval.yyTCmpType:= LESSER;
                                               '>': yylval.yyTCmpType:= GREATER;
                                               '=': yylval.yyTCmpType:= EQUAL;
                                          end;
                                          return(T_CMP);
                                          end;
[a-zA-Z][_a-zA-Z0-9]*           begin yylval.yynstring := yytext; return(T_IDENTIFIER); end;
\n				return(T_EOL);
[ \t]				;
.				writeln('error: unknown character', yytext);

%%
