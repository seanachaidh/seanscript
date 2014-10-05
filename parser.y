%{
  var
    NonkelDebug: boolean;
    tmpnodes: TAstNode;
    finalnodes: TAstNode;

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
%type <TAstNode> statementlist calculation programdecl function print_statement codeblock

%start program
%%

program:
        programdecl function  {
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
          |print_statement
;

codeblock: T_BEGIN statementlist T_END {
           $$:= $2;
}
;

statementlist: {$$:= nil;}
              | statement T_SEMICOLON statementlist{
                if $3 = nil then
                begin
                     $$:= $1;
                end else begin
                     TStatement($3).Next:= TStatement($1);
                     $$:= $3;
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
             T_IF number T_CMP number codeblock {
                       if NonkelDebug then writeln('Een ifstatement');
                       $$:= TIfStatement.Create($2, $4, $3, $5, nil);
             }
;

while_statement:
                T_WHILE number T_CMP number codeblock {
                       if NonkelDebug then writeln('Een while statement');
                       $$:= TWhileStatement.Create($2, $4, $3, finalnodes);
                }
;


/*zorg er ook voor dat je identifiers kan berekenen*/
calculation: number T_OPERATOR number {
             if NonkelDebug then writeln('Een berekening');
             $$:= TCalculation.Create($1, $3, $2);
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

function:
         T_IDENTIFIER codeblock
         {
                      if NonkelDebug then writeln('Een functie');
                      $$:=TFunction.Create($1, $2);
         }
;

print_statement:
          T_PRINT T_IDENTIFIER {
                  if NonkelDebug then writeln('Een printstatement met een identifier');
                  $$:= TPrintCmd.Create($2, true);
          }
          | T_PRINT T_STRING {
                  if NonkelDebug then writeln('Een printstatement met een string');
                  $$:= TPrintCmd.Create($2, false);
          }
;

%%
