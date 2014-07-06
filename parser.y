%{
  type
      nstring = string[50];

  procedure yyerror(s: string);
  begin
       WriteLn(Format('Syntax error:  %s', [s]));
       //Ervoor zorgen dat ik de error kan zien
       WriteLn('druk op een toets om verder te gaan...');
       ReadLn;
  end;
  var
     x: TCmpType;
     tmpnode: TScriptDeclaration;
%}

%token T_EOL
%token <TValue> T_NUMBER
%token T_EXIT T_PRINT T_COLON T_SEMICOLON
%token T_IF T_WHILE
%token T_VAR T_SCRIPT
%token <pchar> T_IDENTIFIER
%token <TCmpType> T_CMP
%token <TOperatorType> T_OPERATOR

%type <TAstNode> expression number statement assignment if_statement


%%

%start program

program:
        |programdecl statementlist {
                     $1.AddProgram($2);
        }
;

programdecl:
            T_SCRIPT T_IDENTIFIER T_SEMICOLON {
            tmpnode:= TScriptDeclaration.Create($2);
};

statementlist:
              statementlist T_SEMICOLON satement {
                            $1.AddChild($2);
                            $$:= $1;
              }
;


statement: assignment
          |if_statement
          |while_statement
          |exit_cmd
          |print_cmd
;

/*zorg er ook voor dat je identifiers kan berekenen*/
calculation: number T_OPERATOR number {
             $$:= TCalculation.Create($1, $3, $2);
}
;

assignment: T_IDENTIFIER T_EQUAL calculation {
                         $$:=TAssingnment.Create($1, $3);
            }
;

/*hier moet ik nog een else statementlist aan toevoegen.*/
if_statement:
             T_IF expression T_CMP expression T_COLON statementlist {
                       $$:= TIfStatement.Create($2, $4, $3, $6, nil);
             }
;

while_statement:
                T_WHILE expression T_CMP expression T_COLON statementlist {
                /*Code voor een gewone while statement*/
                       $$:= TWhileStatement.Create($2, $4, $3, $6);
                }
;

number:
       T_NUMBER {$$:= TNumber.Create($1);}
       T_IDENTIFIER {
                    $$:= TNumber.Create(
                          maininterpreter.Context.SearchSymbol($1).Value);
       }
;
%%

