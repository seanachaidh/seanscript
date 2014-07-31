%{
  var
    NonkelDebug: boolean;

  type
      nstring = string[50];

  procedure yyerror(s: string);
  begin
       WriteLn(Format('Syntax error:  %s', [s]));
       //Ervoor zorgen dat ik de error kan zien
       WriteLn('druk op een toets om verder te gaan...');
       ReadLn;
  end;
%}

%token <TValue> T_NUMBER
%token T_END T_BEGIN
%token T_EXIT T_PRINT T_COLON T_SEMICOLON T_EQUAL
%token T_IF T_WHILE
%token T_VAR T_SCRIPT
%token <shortstring> T_IDENTIFIER T_STRING
%token <TCompType> T_CMP
%token <TOperator> T_OPERATOR

%type <TAstNode> number statement assignment if_statement while_statement programdecl
%type <TAstNode> statementlist calculation programdecl function print_statement

%start program
%%

program:
        programdecl statementlist {
                     $1.AddChild($2);
                     TNonkelScript.maininterpreter.AddExpression($1);
                     writeln('Een programma');
        }
;

programdecl:
            T_SCRIPT T_IDENTIFIER T_SEMICOLON {
            writeln('Een scriptdeclaratie');
            $$:= TScriptDeclaration.Create($2);
};

statement: assignment
          |if_statement
          |while_statement
          |function
          |print_statement
;

statementlist:  {$$:= nil;}
              | statementlist statement T_SEMICOLON {
                          if not assigned($1) then
                          begin
                               $$:= $2;
                          end else begin
                              $1.Addchild($2);
                              $$:= $1;
                          end;
              }
;



assignment:
           T_VAR T_IDENTIFIER T_EQUAL number {
                 if NonkelDebug then writeln('Een nieuwe variable');
                 $$:= TAssingnment.Create($2, true, $4);
           }
           | T_IDENTIFIER T_EQUAL number {
                         if NonkelDebug then writeln('Een toekenning: ', $1);
                         $$:=TAssingnment.Create($1, false, $3);
           }
;

/*hier moet ik nog een else statementlist aan toevoegen.*/
if_statement:
             T_IF number T_CMP number T_BEGIN statementlist T_END {
                       if NonkelDebug then writeln('Een ifstatement');
                       $$:= TIfStatement.Create($2, $4, $3, $6, nil);
             }
;

while_statement:
                T_WHILE number T_CMP number T_BEGIN statementlist T_END {
                       if NonkelDebug then writeln('Een while statement');
                       $$:= TWhileStatement.Create($2, $4, $3, $6);
                }
;

number:
       T_NUMBER {$$:= TNumber.Create($1);}
       | T_IDENTIFIER {
                    $$:= TAssignedNumber.Create($1);
       }
       | calculation {
         $$:= $1;
       }
;

/*zorg er ook voor dat je identifiers kan berekenen*/
calculation:
            | number T_OPERATOR number {
             if NonkelDebug then writeln('Een berekening');
             $$:= TCalculation.Create($1, $3, $2);
}
;

function:
         T_IDENTIFIER T_BEGIN statementlist T_END
         {
                      if NonkelDebug then writeln('Een functie');
                      $$:=TFunction.Create($1, $3);
         }
;

print_statement:
          T_PRINT T_IDENTIFIER T_SEMICOLON {
                  if NonkelDebug then writeln('Een printstatement met een identifier');
                  $$:= TPrintCmd.Create($2, true);
          }
          T_PRINT T_STRING T_SEMICOLON{
                  if NonkelDebug then writeln('Een printstatment met een gewone string');
                  $$:= TPrintCmd.Create($2, false);
          }
;

%%

