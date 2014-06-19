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
     tmpnode: TAstNode;
%}

%token T_EOL
%token T_NUMBER
%token T_EXIT T_PRINT T_COLON T_SEMICOLON
%token T_IF T_WHILE
%token T_VAR T_SCRIPT
%token <nstring> T_IDENTIFIER
%token <TCmpType> T_CMP
%token <TOperatorType> T_MIN T_PLUS T_MUL T_EQUAL T_EXIT T_IF T_COLON T_DIV

%type <TStatement> expression term statement assignment print_cmd exit_cmd if_statement


%%

%start program

program:
        |program statement T_EOL {writeDown($2);};
;

statement: assignment
          |expression
          |if_statement
          |print_cmd
          |exit_cmd
;

assignment: T_IDENTIFIER T_EQUAL expression {$$:= vlist.setvar($1, $3);};

expression: T_NUMBER
            | expression T_OPERATOR expression {
              tmpnode:= T
            }
            ;
if_statement:
             T_IF expression T_CMP expression T_COLON {
                  x:= $3;
                  case x of
                       GREATER: writeln('een if statement met een groter dan');
                       LESSER: writeln('een if statement met een kleiner dan');
                       EQUAL: writeln('een if statement met een gelijk aan');
                  end;
                  $$:= TNonkelVar.EmptyVar;
             }
             ;

term: T_NUMBER
      | T_IDENTIFIER {$$:= vlist.getvar($1);}
      ;

print_cmd: T_PRINT T_IDENTIFIER {
           $$:= vlist.getvar($2);
;
exit_cmd: T_EXIT {halt;};

%%
