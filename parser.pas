
(* Yacc parser template (TP Yacc V3.0), V1.2 6-17-91 AG *)

(* global definitions: *)

  type
      nstring = string[50];

  procedure yyerror(s: string);
  begin
       WriteLn(Format('Syntax error:  %s', [s]));
       //Ervoor zorgen dat ik de error kan zien
       WriteLn('druk op een toets om verder te gaan...');
       ReadLn;
  end;
const T_NUMBER = 257;
const T_END = 258;
const T_BEGIN = 259;
const T_EXIT = 260;
const T_PRINT = 261;
const T_COLON = 262;
const T_SEMICOLON = 263;
const T_EQUAL = 264;
const T_IF = 265;
const T_WHILE = 266;
const T_VAR = 267;
const T_SCRIPT = 268;
const T_IDENTIFIER = 269;
const T_CMP = 270;
const T_OPERATOR = 271;

type YYSType = record case Integer of
                 1 : ( yyTAstNode : TAstNode );
                 2 : ( yyTCompType : TCompType );
                 3 : ( yyTOperator : TOperator );
                 4 : ( yyTValue : TValue );
                 5 : ( yyshortstring : shortstring );
               end(*YYSType*);

var yylval : YYSType;

function yylex : Integer; forward;

function yyparse : Integer;

var yystate, yysp, yyn : Integer;
    yys : array [1..yymaxdepth] of Integer;
    yyv : array [1..yymaxdepth] of YYSType;
    yyval : YYSType;

procedure yyaction ( yyruleno : Integer );
  (* local definitions: *)
begin
  (* actions: *)
  case yyruleno of
   1 : begin
       end;
   2 : begin
         
         yyv[yysp-1].yyTAstNode.AddChild(yyv[yysp-0].yyTAstNode);
         TNonkelScript.maininterpreter.AddExpression(yyv[yysp-1].yyTAstNode);
         writeln('Een programma');
         
       end;
   3 : begin
         
         writeln('Een scriptdeclaratie');
         yyval.yyTAstNode:= TScriptDeclaration.Create(yyv[yysp-1].yyshortstring);
         
       end;
   4 : begin
         yyval := yyv[yysp-0];
       end;
   5 : begin
         yyval := yyv[yysp-0];
       end;
   6 : begin
         yyval := yyv[yysp-0];
       end;
   7 : begin
         yyval := yyv[yysp-0];
       end;
   8 : begin
         
         yyv[yysp-2].yyTAstNode.AddChild(yyv[yysp-0].yyTAstNode);
         yyval.yyTAstNode:= yyv[yysp-2].yyTAstNode;
         
       end;
   9 : begin
         
         writeln('Een berekening');
         yyval.yyTAstNode:= TCalculation.Create(yyv[yysp-2].yyTAstNode, yyv[yysp-0].yyTAstNode, yyv[yysp-1].yyTOperator);
         
       end;
  10 : begin
         
         writeln('Een toekenning');
         yyval.yyTAstNode:=TAssingnment.Create(yyv[yysp-2].yyshortstring, yyv[yysp-0].yyTAstNode);
         
       end;
  11 : begin
         
         writeln('Een ifstatement');
         yyval.yyTAstNode:= TIfStatement.Create(yyv[yysp-5].yyTAstNode, yyv[yysp-3].yyTAstNode, yyv[yysp-4].yyTCompType, yyv[yysp-1].yyTAstNode, nil);
         
       end;
  12 : begin
         
         writeln('Een while statement');
         yyval.yyTAstNode:= TWhileStatement.Create(yyv[yysp-5].yyTAstNode, yyv[yysp-3].yyTAstNode, yyv[yysp-4].yyTCompType, yyv[yysp-1].yyTAstNode);
         
       end;
  13 : begin
         yyval.yyTAstNode:= TNumber.Create(yyv[yysp-0].yyTValue);
       end;
  14 : begin
         
         yyval.yyTAstNode:= TAssignedNumber.Create(yyv[yysp-0].yyshortstring);
         
       end;
  15 : begin
         
         writeln('Een functie');
         yyval.yyTAstNode:=TFunction.Create(yyv[yysp-3].yyshortstring, yyv[yysp-1].yyTAstNode);
         
       end;
  end;
end(*yyaction*);

(* parse table: *)

type YYARec = record
                sym, act : Integer;
              end;
     YYRRec = record
                len, sym : Integer;
              end;

const

yynacts   = 35;
yyngotos  = 22;
yynstates = 38;
yynrules  = 15;

yya : array [1..yynacts] of YYARec = (
{ 0: }
  ( sym: 268; act: 3 ),
  ( sym: 0; act: -1 ),
{ 1: }
  ( sym: 0; act: 0 ),
{ 2: }
{ 3: }
  ( sym: 269; act: 5 ),
{ 4: }
  ( sym: 263; act: 6 ),
  ( sym: 0; act: -2 ),
{ 5: }
  ( sym: 263; act: 7 ),
{ 6: }
  ( sym: 265; act: 13 ),
  ( sym: 266; act: 14 ),
  ( sym: 269; act: 15 ),
{ 7: }
{ 8: }
{ 9: }
{ 10: }
{ 11: }
{ 12: }
{ 13: }
  ( sym: 257; act: 18 ),
  ( sym: 269; act: 19 ),
{ 14: }
  ( sym: 257; act: 18 ),
  ( sym: 269; act: 19 ),
{ 15: }
  ( sym: 259; act: 21 ),
  ( sym: 264; act: 22 ),
{ 16: }
  ( sym: 270; act: 23 ),
{ 17: }
  ( sym: 271; act: 24 ),
{ 18: }
{ 19: }
{ 20: }
  ( sym: 270; act: 25 ),
{ 21: }
{ 22: }
  ( sym: 257; act: 18 ),
  ( sym: 269; act: 19 ),
{ 23: }
  ( sym: 257; act: 18 ),
  ( sym: 269; act: 19 ),
{ 24: }
  ( sym: 257; act: 18 ),
  ( sym: 269; act: 19 ),
{ 25: }
  ( sym: 257; act: 18 ),
  ( sym: 269; act: 19 ),
{ 26: }
  ( sym: 258; act: 31 ),
  ( sym: 263; act: 6 ),
{ 27: }
{ 28: }
  ( sym: 259; act: 32 ),
{ 29: }
{ 30: }
  ( sym: 259; act: 33 ),
{ 31: }
{ 32: }
{ 33: }
{ 34: }
  ( sym: 258; act: 36 ),
  ( sym: 263; act: 6 ),
{ 35: }
  ( sym: 258; act: 37 ),
  ( sym: 263; act: 6 )
{ 36: }
{ 37: }
);

yyg : array [1..yyngotos] of YYARec = (
{ 0: }
  ( sym: -11; act: 1 ),
  ( sym: -7; act: 2 ),
{ 1: }
{ 2: }
  ( sym: -8; act: 4 ),
{ 3: }
{ 4: }
{ 5: }
{ 6: }
  ( sym: -10; act: 8 ),
  ( sym: -6; act: 9 ),
  ( sym: -5; act: 10 ),
  ( sym: -4; act: 11 ),
  ( sym: -3; act: 12 ),
{ 7: }
{ 8: }
{ 9: }
{ 10: }
{ 11: }
{ 12: }
{ 13: }
  ( sym: -9; act: 16 ),
  ( sym: -2; act: 17 ),
{ 14: }
  ( sym: -9; act: 20 ),
  ( sym: -2; act: 17 ),
{ 15: }
{ 16: }
{ 17: }
{ 18: }
{ 19: }
{ 20: }
{ 21: }
  ( sym: -8; act: 26 ),
{ 22: }
  ( sym: -9; act: 27 ),
  ( sym: -2; act: 17 ),
{ 23: }
  ( sym: -9; act: 28 ),
  ( sym: -2; act: 17 ),
{ 24: }
  ( sym: -2; act: 29 ),
{ 25: }
  ( sym: -9; act: 30 ),
  ( sym: -2; act: 17 ),
{ 26: }
{ 27: }
{ 28: }
{ 29: }
{ 30: }
{ 31: }
{ 32: }
  ( sym: -8; act: 34 ),
{ 33: }
  ( sym: -8; act: 35 )
{ 34: }
{ 35: }
{ 36: }
{ 37: }
);

yyd : array [0..yynstates-1] of Integer = (
{ 0: } 0,
{ 1: } 0,
{ 2: } 0,
{ 3: } 0,
{ 4: } 0,
{ 5: } 0,
{ 6: } 0,
{ 7: } 0,
{ 8: } -7,
{ 9: } -6,
{ 10: } -5,
{ 11: } -4,
{ 12: } -8,
{ 13: } 0,
{ 14: } 0,
{ 15: } 0,
{ 16: } 0,
{ 17: } 0,
{ 18: } -13,
{ 19: } -14,
{ 20: } 0,
{ 21: } 0,
{ 22: } 0,
{ 23: } 0,
{ 24: } 0,
{ 25: } 0,
{ 26: } 0,
{ 27: } -10,
{ 28: } 0,
{ 29: } -9,
{ 30: } 0,
{ 31: } -15,
{ 32: } 0,
{ 33: } 0,
{ 34: } 0,
{ 35: } 0,
{ 36: } -11,
{ 37: } -12
);

yyal : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 3,
{ 2: } 4,
{ 3: } 4,
{ 4: } 5,
{ 5: } 7,
{ 6: } 8,
{ 7: } 11,
{ 8: } 11,
{ 9: } 11,
{ 10: } 11,
{ 11: } 11,
{ 12: } 11,
{ 13: } 11,
{ 14: } 13,
{ 15: } 15,
{ 16: } 17,
{ 17: } 18,
{ 18: } 19,
{ 19: } 19,
{ 20: } 19,
{ 21: } 20,
{ 22: } 20,
{ 23: } 22,
{ 24: } 24,
{ 25: } 26,
{ 26: } 28,
{ 27: } 30,
{ 28: } 30,
{ 29: } 31,
{ 30: } 31,
{ 31: } 32,
{ 32: } 32,
{ 33: } 32,
{ 34: } 32,
{ 35: } 34,
{ 36: } 36,
{ 37: } 36
);

yyah : array [0..yynstates-1] of Integer = (
{ 0: } 2,
{ 1: } 3,
{ 2: } 3,
{ 3: } 4,
{ 4: } 6,
{ 5: } 7,
{ 6: } 10,
{ 7: } 10,
{ 8: } 10,
{ 9: } 10,
{ 10: } 10,
{ 11: } 10,
{ 12: } 10,
{ 13: } 12,
{ 14: } 14,
{ 15: } 16,
{ 16: } 17,
{ 17: } 18,
{ 18: } 18,
{ 19: } 18,
{ 20: } 19,
{ 21: } 19,
{ 22: } 21,
{ 23: } 23,
{ 24: } 25,
{ 25: } 27,
{ 26: } 29,
{ 27: } 29,
{ 28: } 30,
{ 29: } 30,
{ 30: } 31,
{ 31: } 31,
{ 32: } 31,
{ 33: } 31,
{ 34: } 33,
{ 35: } 35,
{ 36: } 35,
{ 37: } 35
);

yygl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 3,
{ 2: } 3,
{ 3: } 4,
{ 4: } 4,
{ 5: } 4,
{ 6: } 4,
{ 7: } 9,
{ 8: } 9,
{ 9: } 9,
{ 10: } 9,
{ 11: } 9,
{ 12: } 9,
{ 13: } 9,
{ 14: } 11,
{ 15: } 13,
{ 16: } 13,
{ 17: } 13,
{ 18: } 13,
{ 19: } 13,
{ 20: } 13,
{ 21: } 13,
{ 22: } 14,
{ 23: } 16,
{ 24: } 18,
{ 25: } 19,
{ 26: } 21,
{ 27: } 21,
{ 28: } 21,
{ 29: } 21,
{ 30: } 21,
{ 31: } 21,
{ 32: } 21,
{ 33: } 22,
{ 34: } 23,
{ 35: } 23,
{ 36: } 23,
{ 37: } 23
);

yygh : array [0..yynstates-1] of Integer = (
{ 0: } 2,
{ 1: } 2,
{ 2: } 3,
{ 3: } 3,
{ 4: } 3,
{ 5: } 3,
{ 6: } 8,
{ 7: } 8,
{ 8: } 8,
{ 9: } 8,
{ 10: } 8,
{ 11: } 8,
{ 12: } 8,
{ 13: } 10,
{ 14: } 12,
{ 15: } 12,
{ 16: } 12,
{ 17: } 12,
{ 18: } 12,
{ 19: } 12,
{ 20: } 12,
{ 21: } 13,
{ 22: } 15,
{ 23: } 17,
{ 24: } 18,
{ 25: } 20,
{ 26: } 20,
{ 27: } 20,
{ 28: } 20,
{ 29: } 20,
{ 30: } 20,
{ 31: } 20,
{ 32: } 21,
{ 33: } 22,
{ 34: } 22,
{ 35: } 22,
{ 36: } 22,
{ 37: } 22
);

yyr : array [1..yynrules] of YYRRec = (
{ 1: } ( len: 0; sym: -11 ),
{ 2: } ( len: 2; sym: -11 ),
{ 3: } ( len: 3; sym: -7 ),
{ 4: } ( len: 1; sym: -3 ),
{ 5: } ( len: 1; sym: -3 ),
{ 6: } ( len: 1; sym: -3 ),
{ 7: } ( len: 1; sym: -3 ),
{ 8: } ( len: 3; sym: -8 ),
{ 9: } ( len: 3; sym: -9 ),
{ 10: } ( len: 3; sym: -4 ),
{ 11: } ( len: 7; sym: -5 ),
{ 12: } ( len: 7; sym: -6 ),
{ 13: } ( len: 1; sym: -2 ),
{ 14: } ( len: 1; sym: -2 ),
{ 15: } ( len: 4; sym: -10 )
);


const _error = 256; (* error token *)

function yyact(state, sym : Integer; var act : Integer) : Boolean;
  (* search action table *)
  var k : Integer;
  begin
    k := yyal[state];
    while (k<=yyah[state]) and (yya[k].sym<>sym) do inc(k);
    if k>yyah[state] then
      yyact := false
    else
      begin
        act := yya[k].act;
        yyact := true;
      end;
  end(*yyact*);

function yygoto(state, sym : Integer; var nstate : Integer) : Boolean;
  (* search goto table *)
  var k : Integer;
  begin
    k := yygl[state];
    while (k<=yygh[state]) and (yyg[k].sym<>sym) do inc(k);
    if k>yygh[state] then
      yygoto := false
    else
      begin
        nstate := yyg[k].act;
        yygoto := true;
      end;
  end(*yygoto*);

label parse, next, error, errlab, shift, reduce, accept, abort;

begin(*yyparse*)

  (* initialize: *)

  yystate := 0; yychar := -1; yynerrs := 0; yyerrflag := 0; yysp := 0;

{$ifdef yydebug}
  yydebug := true;
{$else}
  yydebug := false;
{$endif}

parse:

  (* push state and value: *)

  inc(yysp);
  if yysp>yymaxdepth then
    begin
      yyerror('yyparse stack overflow');
      goto abort;
    end;
  yys[yysp] := yystate; yyv[yysp] := yyval;

next:

  if (yyd[yystate]=0) and (yychar=-1) then
    (* get next symbol *)
    begin
      yychar := yylex; if yychar<0 then yychar := 0;
    end;

  if yydebug then writeln('state ', yystate, ', char ', yychar);

  (* determine parse action: *)

  yyn := yyd[yystate];
  if yyn<>0 then goto reduce; (* simple state *)

  (* no default action; search parse table *)

  if not yyact(yystate, yychar, yyn) then goto error
  else if yyn>0 then                      goto shift
  else if yyn<0 then                      goto reduce
  else                                    goto accept;

error:

  (* error; start error recovery: *)

  if yyerrflag=0 then yyerror('syntax error');

errlab:

  if yyerrflag=0 then inc(yynerrs);     (* new error *)

  if yyerrflag<=2 then                  (* incomplete recovery; try again *)
    begin
      yyerrflag := 3;
      (* uncover a state with shift action on error token *)
      while (yysp>0) and not ( yyact(yys[yysp], _error, yyn) and
                               (yyn>0) ) do
        begin
          if yydebug then
            if yysp>1 then
              writeln('error recovery pops state ', yys[yysp], ', uncovers ',
                      yys[yysp-1])
            else
              writeln('error recovery fails ... abort');
          dec(yysp);
        end;
      if yysp=0 then goto abort; (* parser has fallen from stack; abort *)
      yystate := yyn;            (* simulate shift on error *)
      goto parse;
    end
  else                                  (* no shift yet; discard symbol *)
    begin
      if yydebug then writeln('error recovery discards char ', yychar);
      if yychar=0 then goto abort; (* end of input; abort *)
      yychar := -1; goto next;     (* clear lookahead char and try again *)
    end;

shift:

  (* go to new state, clear lookahead character: *)

  yystate := yyn; yychar := -1; yyval := yylval;
  if yyerrflag>0 then dec(yyerrflag);

  goto parse;

reduce:

  (* execute action, pop rule from stack, and go to next state: *)

  if yydebug then writeln('reduce ', -yyn);

  yyflag := yyfnone; yyaction(-yyn);
  dec(yysp, yyr[-yyn].len);
  if yygoto(yys[yysp], yyr[-yyn].sym, yyn) then yystate := yyn;

  (* handle action calls to yyaccept, yyabort and yyerror: *)

  case yyflag of
    yyfaccept : goto accept;
    yyfabort  : goto abort;
    yyferror  : goto errlab;
  end;

  goto parse;

accept:

  yyparse := 0; exit;

abort:

  yyparse := 1; exit;

end(*yyparse*);

