
(* Yacc parser template (TP Yacc V3.0), V1.2 6-17-91 AG *)

(* global definitions: *)

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
         
         yyv[yysp-1].yyTAstNode.AddChild(yyv[yysp-0].yyTAstNode);
         TNonkelScript.maininterpreter.AddExpression(yyv[yysp-1].yyTAstNode);
         writeln('Een programma');
         
       end;
   2 : begin
         
         writeln('Een scriptdeclaratie');
         yyval.yyTAstNode:= TScriptDeclaration.Create(yyv[yysp-1].yyshortstring);
         
       end;
   3 : begin
         yyval := yyv[yysp-0];
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
         
         yyval.yyTAstNode:= yyv[yysp-0].yyTAstNode;
         
       end;
   8 : begin
         
         yyv[yysp-2].yyTAstNode.AddChild(yyv[yysp-0].yyTAstNode);
         yyval.yyTAstNode:= yyv[yysp-2].yyTAstNode;
         
       end;
   9 : begin
         
         if NonkelDebug then writeln('Een nieuwe variable');
         yyval.yyTAstNode:= TAssingnment.Create(yyv[yysp-2].yyshortstring, true, yyv[yysp-0].yyTAstNode);
         
       end;
  10 : begin
         
         if NonkelDebug then writeln('Een toekenning: ', yyv[yysp-2].yyshortstring);
         yyval.yyTAstNode:=TAssingnment.Create(yyv[yysp-2].yyshortstring, false, yyv[yysp-0].yyTAstNode);
         
       end;
  11 : begin
         
         if NonkelDebug then writeln('Een ifstatement');
         yyval.yyTAstNode:= TIfStatement.Create(yyv[yysp-5].yyTAstNode, yyv[yysp-3].yyTAstNode, yyv[yysp-4].yyTCompType, yyv[yysp-1].yyTAstNode, nil);
         
       end;
  12 : begin
         
         if NonkelDebug then writeln('Een while statement');
         yyval.yyTAstNode:= TWhileStatement.Create(yyv[yysp-5].yyTAstNode, yyv[yysp-3].yyTAstNode, yyv[yysp-4].yyTCompType, yyv[yysp-1].yyTAstNode);
         
       end;
  13 : begin
         yyval.yyTAstNode:= TNumber.Create(yyv[yysp-0].yyTValue);
       end;
  14 : begin
         
         yyval.yyTAstNode:= TAssignedNumber.Create(yyv[yysp-0].yyshortstring);
         
       end;
  15 : begin
         
         yyval.yyTAstNode:= yyv[yysp-0].yyTAstNode;
         
       end;
  16 : begin
       end;
  17 : begin
         
         if NonkelDebug then writeln('Een berekening');
         yyval.yyTAstNode:= TCalculation.Create(yyv[yysp-2].yyTAstNode, yyv[yysp-0].yyTAstNode, yyv[yysp-1].yyTOperator);
         
       end;
  18 : begin
         
         if NonkelDebug then writeln('Een functie');
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

yynacts   = 94;
yyngotos  = 45;
yynstates = 43;
yynrules  = 18;

yya : array [1..yynacts] of YYARec = (
{ 0: }
  ( sym: 268; act: 3 ),
{ 1: }
  ( sym: 0; act: 0 ),
{ 2: }
  ( sym: 265; act: 10 ),
  ( sym: 266; act: 11 ),
  ( sym: 267; act: 12 ),
  ( sym: 269; act: 13 ),
{ 3: }
  ( sym: 269; act: 14 ),
{ 4: }
{ 5: }
  ( sym: 263; act: 15 ),
  ( sym: 0; act: -1 ),
{ 6: }
{ 7: }
{ 8: }
{ 9: }
{ 10: }
  ( sym: 257; act: 18 ),
  ( sym: 269; act: 19 ),
  ( sym: 270; act: -16 ),
  ( sym: 271; act: -16 ),
{ 11: }
  ( sym: 257; act: 18 ),
  ( sym: 269; act: 19 ),
  ( sym: 270; act: -16 ),
  ( sym: 271; act: -16 ),
{ 12: }
  ( sym: 269; act: 21 ),
{ 13: }
  ( sym: 259; act: 22 ),
  ( sym: 264; act: 23 ),
{ 14: }
  ( sym: 263; act: 24 ),
{ 15: }
  ( sym: 265; act: 10 ),
  ( sym: 266; act: 11 ),
  ( sym: 267; act: 12 ),
  ( sym: 269; act: 13 ),
{ 16: }
{ 17: }
  ( sym: 270; act: 26 ),
  ( sym: 271; act: 27 ),
{ 18: }
{ 19: }
{ 20: }
  ( sym: 270; act: 28 ),
  ( sym: 271; act: 27 ),
{ 21: }
  ( sym: 264; act: 29 ),
{ 22: }
  ( sym: 265; act: 10 ),
  ( sym: 266; act: 11 ),
  ( sym: 267; act: 12 ),
  ( sym: 269; act: 13 ),
{ 23: }
  ( sym: 257; act: 18 ),
  ( sym: 269; act: 19 ),
  ( sym: 0; act: -16 ),
  ( sym: 258; act: -16 ),
  ( sym: 263; act: -16 ),
  ( sym: 271; act: -16 ),
{ 24: }
{ 25: }
{ 26: }
  ( sym: 257; act: 18 ),
  ( sym: 269; act: 19 ),
  ( sym: 259; act: -16 ),
  ( sym: 271; act: -16 ),
{ 27: }
  ( sym: 257; act: 18 ),
  ( sym: 269; act: 19 ),
  ( sym: 0; act: -16 ),
  ( sym: 258; act: -16 ),
  ( sym: 259; act: -16 ),
  ( sym: 263; act: -16 ),
  ( sym: 270; act: -16 ),
  ( sym: 271; act: -16 ),
{ 28: }
  ( sym: 257; act: 18 ),
  ( sym: 269; act: 19 ),
  ( sym: 259; act: -16 ),
  ( sym: 271; act: -16 ),
{ 29: }
  ( sym: 257; act: 18 ),
  ( sym: 269; act: 19 ),
  ( sym: 0; act: -16 ),
  ( sym: 258; act: -16 ),
  ( sym: 263; act: -16 ),
  ( sym: 271; act: -16 ),
{ 30: }
  ( sym: 258; act: 36 ),
  ( sym: 263; act: 15 ),
{ 31: }
  ( sym: 271; act: 27 ),
  ( sym: 0; act: -10 ),
  ( sym: 258; act: -10 ),
  ( sym: 263; act: -10 ),
{ 32: }
  ( sym: 259; act: 37 ),
  ( sym: 271; act: 27 ),
{ 33: }
  ( sym: 271; act: 27 ),
  ( sym: 0; act: -17 ),
  ( sym: 258; act: -17 ),
  ( sym: 259; act: -17 ),
  ( sym: 263; act: -17 ),
  ( sym: 270; act: -17 ),
{ 34: }
  ( sym: 259; act: 38 ),
  ( sym: 271; act: 27 ),
{ 35: }
  ( sym: 271; act: 27 ),
  ( sym: 0; act: -9 ),
  ( sym: 258; act: -9 ),
  ( sym: 263; act: -9 ),
{ 36: }
{ 37: }
  ( sym: 265; act: 10 ),
  ( sym: 266; act: 11 ),
  ( sym: 267; act: 12 ),
  ( sym: 269; act: 13 ),
{ 38: }
  ( sym: 265; act: 10 ),
  ( sym: 266; act: 11 ),
  ( sym: 267; act: 12 ),
  ( sym: 269; act: 13 ),
{ 39: }
  ( sym: 258; act: 41 ),
  ( sym: 263; act: 15 ),
{ 40: }
  ( sym: 258; act: 42 ),
  ( sym: 263; act: 15 )
{ 41: }
{ 42: }
);

yyg : array [1..yyngotos] of YYARec = (
{ 0: }
  ( sym: -11; act: 1 ),
  ( sym: -7; act: 2 ),
{ 1: }
{ 2: }
  ( sym: -10; act: 4 ),
  ( sym: -8; act: 5 ),
  ( sym: -6; act: 6 ),
  ( sym: -5; act: 7 ),
  ( sym: -4; act: 8 ),
  ( sym: -3; act: 9 ),
{ 3: }
{ 4: }
{ 5: }
{ 6: }
{ 7: }
{ 8: }
{ 9: }
{ 10: }
  ( sym: -9; act: 16 ),
  ( sym: -2; act: 17 ),
{ 11: }
  ( sym: -9; act: 16 ),
  ( sym: -2; act: 20 ),
{ 12: }
{ 13: }
{ 14: }
{ 15: }
  ( sym: -10; act: 4 ),
  ( sym: -6; act: 6 ),
  ( sym: -5; act: 7 ),
  ( sym: -4; act: 8 ),
  ( sym: -3; act: 25 ),
{ 16: }
{ 17: }
{ 18: }
{ 19: }
{ 20: }
{ 21: }
{ 22: }
  ( sym: -10; act: 4 ),
  ( sym: -8; act: 30 ),
  ( sym: -6; act: 6 ),
  ( sym: -5; act: 7 ),
  ( sym: -4; act: 8 ),
  ( sym: -3; act: 9 ),
{ 23: }
  ( sym: -9; act: 16 ),
  ( sym: -2; act: 31 ),
{ 24: }
{ 25: }
{ 26: }
  ( sym: -9; act: 16 ),
  ( sym: -2; act: 32 ),
{ 27: }
  ( sym: -9; act: 16 ),
  ( sym: -2; act: 33 ),
{ 28: }
  ( sym: -9; act: 16 ),
  ( sym: -2; act: 34 ),
{ 29: }
  ( sym: -9; act: 16 ),
  ( sym: -2; act: 35 ),
{ 30: }
{ 31: }
{ 32: }
{ 33: }
{ 34: }
{ 35: }
{ 36: }
{ 37: }
  ( sym: -10; act: 4 ),
  ( sym: -8; act: 39 ),
  ( sym: -6; act: 6 ),
  ( sym: -5; act: 7 ),
  ( sym: -4; act: 8 ),
  ( sym: -3; act: 9 ),
{ 38: }
  ( sym: -10; act: 4 ),
  ( sym: -8; act: 40 ),
  ( sym: -6; act: 6 ),
  ( sym: -5; act: 7 ),
  ( sym: -4; act: 8 ),
  ( sym: -3; act: 9 )
{ 39: }
{ 40: }
{ 41: }
{ 42: }
);

yyd : array [0..yynstates-1] of Integer = (
{ 0: } 0,
{ 1: } 0,
{ 2: } 0,
{ 3: } 0,
{ 4: } -6,
{ 5: } 0,
{ 6: } -5,
{ 7: } -4,
{ 8: } -3,
{ 9: } -7,
{ 10: } 0,
{ 11: } 0,
{ 12: } 0,
{ 13: } 0,
{ 14: } 0,
{ 15: } 0,
{ 16: } -15,
{ 17: } 0,
{ 18: } -13,
{ 19: } -14,
{ 20: } 0,
{ 21: } 0,
{ 22: } 0,
{ 23: } 0,
{ 24: } -2,
{ 25: } -8,
{ 26: } 0,
{ 27: } 0,
{ 28: } 0,
{ 29: } 0,
{ 30: } 0,
{ 31: } 0,
{ 32: } 0,
{ 33: } 0,
{ 34: } 0,
{ 35: } 0,
{ 36: } -18,
{ 37: } 0,
{ 38: } 0,
{ 39: } 0,
{ 40: } 0,
{ 41: } -11,
{ 42: } -12
);

yyal : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 2,
{ 2: } 3,
{ 3: } 7,
{ 4: } 8,
{ 5: } 8,
{ 6: } 10,
{ 7: } 10,
{ 8: } 10,
{ 9: } 10,
{ 10: } 10,
{ 11: } 14,
{ 12: } 18,
{ 13: } 19,
{ 14: } 21,
{ 15: } 22,
{ 16: } 26,
{ 17: } 26,
{ 18: } 28,
{ 19: } 28,
{ 20: } 28,
{ 21: } 30,
{ 22: } 31,
{ 23: } 35,
{ 24: } 41,
{ 25: } 41,
{ 26: } 41,
{ 27: } 45,
{ 28: } 53,
{ 29: } 57,
{ 30: } 63,
{ 31: } 65,
{ 32: } 69,
{ 33: } 71,
{ 34: } 77,
{ 35: } 79,
{ 36: } 83,
{ 37: } 83,
{ 38: } 87,
{ 39: } 91,
{ 40: } 93,
{ 41: } 95,
{ 42: } 95
);

yyah : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 2,
{ 2: } 6,
{ 3: } 7,
{ 4: } 7,
{ 5: } 9,
{ 6: } 9,
{ 7: } 9,
{ 8: } 9,
{ 9: } 9,
{ 10: } 13,
{ 11: } 17,
{ 12: } 18,
{ 13: } 20,
{ 14: } 21,
{ 15: } 25,
{ 16: } 25,
{ 17: } 27,
{ 18: } 27,
{ 19: } 27,
{ 20: } 29,
{ 21: } 30,
{ 22: } 34,
{ 23: } 40,
{ 24: } 40,
{ 25: } 40,
{ 26: } 44,
{ 27: } 52,
{ 28: } 56,
{ 29: } 62,
{ 30: } 64,
{ 31: } 68,
{ 32: } 70,
{ 33: } 76,
{ 34: } 78,
{ 35: } 82,
{ 36: } 82,
{ 37: } 86,
{ 38: } 90,
{ 39: } 92,
{ 40: } 94,
{ 41: } 94,
{ 42: } 94
);

yygl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 3,
{ 2: } 3,
{ 3: } 9,
{ 4: } 9,
{ 5: } 9,
{ 6: } 9,
{ 7: } 9,
{ 8: } 9,
{ 9: } 9,
{ 10: } 9,
{ 11: } 11,
{ 12: } 13,
{ 13: } 13,
{ 14: } 13,
{ 15: } 13,
{ 16: } 18,
{ 17: } 18,
{ 18: } 18,
{ 19: } 18,
{ 20: } 18,
{ 21: } 18,
{ 22: } 18,
{ 23: } 24,
{ 24: } 26,
{ 25: } 26,
{ 26: } 26,
{ 27: } 28,
{ 28: } 30,
{ 29: } 32,
{ 30: } 34,
{ 31: } 34,
{ 32: } 34,
{ 33: } 34,
{ 34: } 34,
{ 35: } 34,
{ 36: } 34,
{ 37: } 34,
{ 38: } 40,
{ 39: } 46,
{ 40: } 46,
{ 41: } 46,
{ 42: } 46
);

yygh : array [0..yynstates-1] of Integer = (
{ 0: } 2,
{ 1: } 2,
{ 2: } 8,
{ 3: } 8,
{ 4: } 8,
{ 5: } 8,
{ 6: } 8,
{ 7: } 8,
{ 8: } 8,
{ 9: } 8,
{ 10: } 10,
{ 11: } 12,
{ 12: } 12,
{ 13: } 12,
{ 14: } 12,
{ 15: } 17,
{ 16: } 17,
{ 17: } 17,
{ 18: } 17,
{ 19: } 17,
{ 20: } 17,
{ 21: } 17,
{ 22: } 23,
{ 23: } 25,
{ 24: } 25,
{ 25: } 25,
{ 26: } 27,
{ 27: } 29,
{ 28: } 31,
{ 29: } 33,
{ 30: } 33,
{ 31: } 33,
{ 32: } 33,
{ 33: } 33,
{ 34: } 33,
{ 35: } 33,
{ 36: } 33,
{ 37: } 39,
{ 38: } 45,
{ 39: } 45,
{ 40: } 45,
{ 41: } 45,
{ 42: } 45
);

yyr : array [1..yynrules] of YYRRec = (
{ 1: } ( len: 2; sym: -11 ),
{ 2: } ( len: 3; sym: -7 ),
{ 3: } ( len: 1; sym: -3 ),
{ 4: } ( len: 1; sym: -3 ),
{ 5: } ( len: 1; sym: -3 ),
{ 6: } ( len: 1; sym: -3 ),
{ 7: } ( len: 1; sym: -8 ),
{ 8: } ( len: 3; sym: -8 ),
{ 9: } ( len: 4; sym: -4 ),
{ 10: } ( len: 3; sym: -4 ),
{ 11: } ( len: 7; sym: -5 ),
{ 12: } ( len: 7; sym: -6 ),
{ 13: } ( len: 1; sym: -2 ),
{ 14: } ( len: 1; sym: -2 ),
{ 15: } ( len: 1; sym: -2 ),
{ 16: } ( len: 0; sym: -9 ),
{ 17: } ( len: 3; sym: -9 ),
{ 18: } ( len: 4; sym: -10 )
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

