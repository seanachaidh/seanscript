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

%type <TAstNode> number statement assignment if_statement while_statement programdecl
%type <TAstNode> statementlist calculation programdecl
%start program
%%



program:
        |programdecl statementlist {
                     $1.AddProgram($2);
        }
;

programdecl:
            T_SCRIPT T_IDENTIFIER T_SEMICOLON {
            $$:= TScriptDeclaration.Create($2);
};

statement: assignment
          |if_statement
          |while_statement
;

statementlist:
              statementlist T_SEMICOLON statement {
                            $1.AddChild($3);
                            $$:= $1;
              }
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
             T_IF calculation T_CMP calculation T_COLON statementlist {
                       $$:= TIfStatement.Create($2, $4, $3, $6, nil);
             }
;

while_statement:
                T_WHILE calculation T_CMP calculation T_COLON statementlist {
                       $$:= TWhileStatement.Create($2, $4, $3, $6);
                }
;

number:
       T_NUMBER {$$:= TNumber.Create($1);}
       T_IDENTIFIER {
                    $$:= TAssignedNumber.Create($1);
       }
;
%%

