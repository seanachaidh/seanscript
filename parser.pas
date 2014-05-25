
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
  var
     x: TCmpType;
const T_EOL = 257;
const T_NUMBER = 258;
const T_MIN = 259;
const T_PLUS = 260;
const T_MUL = 261;
const T_EQUAL = 262;
const T_EXIT = 263;
const T_IF = 264;
const T_COLON = 265;
const T_DIV = 266;
const T_PRINT = 267;
const T_IDENTIFIER = 268;
const T_CMP = 269;

type YYSType = record case Integer of
                 1 : ( yyTCmpType : TCmpType );
                 2 : ( yyTNonkelVar : TNonkelVar );
                 3 : ( yynstring : nstring );
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
         writeDown(yyv[yysp-1].yyTNonkelVar);
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
         yyval := yyv[yysp-0];
       end;
   8 : begin
         yyval.yyTNonkelVar:= vlist.setvar(yyv[yysp-2].yynstring, yyv[yysp-0].yyTNonkelVar);
       end;
   9 : begin
         yyval := yyv[yysp-0];
       end;
  10 : begin
         yyval.yyTNonkelVar := DoMin(yyv[yysp-2].yyTNonkelVar, yyv[yysp-0].yyTNonkelVar);
       end;
  11 : begin
         yyval.yyTNonkelVar := DoPlus(yyv[yysp-2].yyTNonkelVar, yyv[yysp-0].yyTNonkelVar);
       end;
  12 : begin
         yyval.yyTNonkelVar := DoMul(yyv[yysp-2].yyTNonkelVar, yyv[yysp-0].yyTNonkelVar);
       end;
  13 : begin
         yyval.yyTNonkelVar:= DoDiv(yyv[yysp-2].yyTNonkelVar, yyv[yysp-0].yyTNonkelVar);
       end;
  14 : begin
         
         x:= yyv[yysp-2].yyTCmpType;
         case x of
         GREATER: writeln('een if statement met een groter dan');
         LESSER: writeln('een if statement met een kleiner dan');
         EQUAL: writeln('een if statement met een gelijk aan');
         end;
         yyval.yyTNonkelVar:= TNonkelVar.EmptyVar;
         
       end;
  15 : begin
         yyval := yyv[yysp-0];
       end;
  16 : begin
         yyval := yyv[yysp-0];
       end;
  17 : begin
         yyval := yyv[yysp-0];
       end;
  18 : begin
         yyval := yyv[yysp-0];
       end;
  19 : begin
         yyval.yyTNonkelVar:= vlist.getvar(yyv[yysp-0].yynstring);
       end;
  20 : begin
         yyval.yyTNonkelVar:= vlist.getvar(yyv[yysp-0].yynstring);
       end;
  21 : begin
         halt;
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

yynacts   = 48;
yyngotos  = 18;
yynstates = 31;
yynrules  = 21;

yya : array [1..yynacts] of YYARec = (
{ 0: }
{ 1: }
  ( sym: 0; act: 0 ),
  ( sym: 258; act: 9 ),
  ( sym: 263; act: 10 ),
  ( sym: 264; act: 11 ),
  ( sym: 267; act: 12 ),
  ( sym: 268; act: 13 ),
{ 2: }
{ 3: }
{ 4: }
{ 5: }
{ 6: }
  ( sym: 257; act: 14 ),
{ 7: }
{ 8: }
  ( sym: 259; act: 15 ),
  ( sym: 260; act: 16 ),
  ( sym: 261; act: 17 ),
  ( sym: 266; act: 18 ),
  ( sym: 257; act: -4 ),
{ 9: }
{ 10: }
{ 11: }
  ( sym: 258; act: 9 ),
  ( sym: 268; act: 20 ),
{ 12: }
  ( sym: 268; act: 21 ),
{ 13: }
  ( sym: 262; act: 22 ),
  ( sym: 257; act: -19 ),
  ( sym: 259; act: -19 ),
  ( sym: 260; act: -19 ),
  ( sym: 261; act: -19 ),
  ( sym: 266; act: -19 ),
{ 14: }
{ 15: }
  ( sym: 258; act: 9 ),
  ( sym: 268; act: 20 ),
{ 16: }
  ( sym: 258; act: 9 ),
  ( sym: 268; act: 20 ),
{ 17: }
  ( sym: 258; act: 9 ),
  ( sym: 268; act: 20 ),
{ 18: }
  ( sym: 258; act: 9 ),
  ( sym: 268; act: 20 ),
{ 19: }
  ( sym: 259; act: 15 ),
  ( sym: 260; act: 16 ),
  ( sym: 261; act: 17 ),
  ( sym: 266; act: 18 ),
  ( sym: 269; act: 27 ),
{ 20: }
{ 21: }
{ 22: }
  ( sym: 258; act: 9 ),
  ( sym: 268; act: 20 ),
{ 23: }
{ 24: }
{ 25: }
{ 26: }
{ 27: }
  ( sym: 258; act: 9 ),
  ( sym: 268; act: 20 ),
{ 28: }
  ( sym: 259; act: 15 ),
  ( sym: 260; act: 16 ),
  ( sym: 261; act: 17 ),
  ( sym: 266; act: 18 ),
  ( sym: 257; act: -8 ),
{ 29: }
  ( sym: 259; act: 15 ),
  ( sym: 260; act: 16 ),
  ( sym: 261; act: 17 ),
  ( sym: 265; act: 30 ),
  ( sym: 266; act: 18 )
{ 30: }
);

yyg : array [1..yyngotos] of YYARec = (
{ 0: }
  ( sym: -9; act: 1 ),
{ 1: }
  ( sym: -8; act: 2 ),
  ( sym: -7; act: 3 ),
  ( sym: -6; act: 4 ),
  ( sym: -5; act: 5 ),
  ( sym: -4; act: 6 ),
  ( sym: -3; act: 7 ),
  ( sym: -2; act: 8 ),
{ 2: }
{ 3: }
{ 4: }
{ 5: }
{ 6: }
{ 7: }
{ 8: }
{ 9: }
{ 10: }
{ 11: }
  ( sym: -3; act: 7 ),
  ( sym: -2; act: 19 ),
{ 12: }
{ 13: }
{ 14: }
{ 15: }
  ( sym: -3; act: 23 ),
{ 16: }
  ( sym: -3; act: 24 ),
{ 17: }
  ( sym: -3; act: 25 ),
{ 18: }
  ( sym: -3; act: 26 ),
{ 19: }
{ 20: }
{ 21: }
{ 22: }
  ( sym: -3; act: 7 ),
  ( sym: -2; act: 28 ),
{ 23: }
{ 24: }
{ 25: }
{ 26: }
{ 27: }
  ( sym: -3; act: 7 ),
  ( sym: -2; act: 29 )
{ 28: }
{ 29: }
{ 30: }
);

yyd : array [0..yynstates-1] of Integer = (
{ 0: } -1,
{ 1: } 0,
{ 2: } -5,
{ 3: } -7,
{ 4: } -6,
{ 5: } -3,
{ 6: } 0,
{ 7: } -9,
{ 8: } 0,
{ 9: } -18,
{ 10: } -21,
{ 11: } 0,
{ 12: } 0,
{ 13: } 0,
{ 14: } -2,
{ 15: } 0,
{ 16: } 0,
{ 17: } 0,
{ 18: } 0,
{ 19: } 0,
{ 20: } -19,
{ 21: } -20,
{ 22: } 0,
{ 23: } -10,
{ 24: } -11,
{ 25: } -12,
{ 26: } -13,
{ 27: } 0,
{ 28: } 0,
{ 29: } 0,
{ 30: } -14
);

yyal : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 1,
{ 2: } 7,
{ 3: } 7,
{ 4: } 7,
{ 5: } 7,
{ 6: } 7,
{ 7: } 8,
{ 8: } 8,
{ 9: } 13,
{ 10: } 13,
{ 11: } 13,
{ 12: } 15,
{ 13: } 16,
{ 14: } 22,
{ 15: } 22,
{ 16: } 24,
{ 17: } 26,
{ 18: } 28,
{ 19: } 30,
{ 20: } 35,
{ 21: } 35,
{ 22: } 35,
{ 23: } 37,
{ 24: } 37,
{ 25: } 37,
{ 26: } 37,
{ 27: } 37,
{ 28: } 39,
{ 29: } 44,
{ 30: } 49
);

yyah : array [0..yynstates-1] of Integer = (
{ 0: } 0,
{ 1: } 6,
{ 2: } 6,
{ 3: } 6,
{ 4: } 6,
{ 5: } 6,
{ 6: } 7,
{ 7: } 7,
{ 8: } 12,
{ 9: } 12,
{ 10: } 12,
{ 11: } 14,
{ 12: } 15,
{ 13: } 21,
{ 14: } 21,
{ 15: } 23,
{ 16: } 25,
{ 17: } 27,
{ 18: } 29,
{ 19: } 34,
{ 20: } 34,
{ 21: } 34,
{ 22: } 36,
{ 23: } 36,
{ 24: } 36,
{ 25: } 36,
{ 26: } 36,
{ 27: } 38,
{ 28: } 43,
{ 29: } 48,
{ 30: } 48
);

yygl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 2,
{ 2: } 9,
{ 3: } 9,
{ 4: } 9,
{ 5: } 9,
{ 6: } 9,
{ 7: } 9,
{ 8: } 9,
{ 9: } 9,
{ 10: } 9,
{ 11: } 9,
{ 12: } 11,
{ 13: } 11,
{ 14: } 11,
{ 15: } 11,
{ 16: } 12,
{ 17: } 13,
{ 18: } 14,
{ 19: } 15,
{ 20: } 15,
{ 21: } 15,
{ 22: } 15,
{ 23: } 17,
{ 24: } 17,
{ 25: } 17,
{ 26: } 17,
{ 27: } 17,
{ 28: } 19,
{ 29: } 19,
{ 30: } 19
);

yygh : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 8,
{ 2: } 8,
{ 3: } 8,
{ 4: } 8,
{ 5: } 8,
{ 6: } 8,
{ 7: } 8,
{ 8: } 8,
{ 9: } 8,
{ 10: } 8,
{ 11: } 10,
{ 12: } 10,
{ 13: } 10,
{ 14: } 10,
{ 15: } 11,
{ 16: } 12,
{ 17: } 13,
{ 18: } 14,
{ 19: } 14,
{ 20: } 14,
{ 21: } 14,
{ 22: } 16,
{ 23: } 16,
{ 24: } 16,
{ 25: } 16,
{ 26: } 16,
{ 27: } 18,
{ 28: } 18,
{ 29: } 18,
{ 30: } 18
);

yyr : array [1..yynrules] of YYRRec = (
{ 1: } ( len: 0; sym: -9 ),
{ 2: } ( len: 3; sym: -9 ),
{ 3: } ( len: 1; sym: -4 ),
{ 4: } ( len: 1; sym: -4 ),
{ 5: } ( len: 1; sym: -4 ),
{ 6: } ( len: 1; sym: -4 ),
{ 7: } ( len: 1; sym: -4 ),
{ 8: } ( len: 3; sym: -5 ),
{ 9: } ( len: 1; sym: -2 ),
{ 10: } ( len: 3; sym: -2 ),
{ 11: } ( len: 3; sym: -2 ),
{ 12: } ( len: 3; sym: -2 ),
{ 13: } ( len: 3; sym: -2 ),
{ 14: } ( len: 5; sym: -8 ),
{ 15: } ( len: 1; sym: -10 ),
{ 16: } ( len: 1; sym: -10 ),
{ 17: } ( len: 1; sym: -10 ),
{ 18: } ( len: 1; sym: -3 ),
{ 19: } ( len: 1; sym: -3 ),
{ 20: } ( len: 2; sym: -6 ),
{ 21: } ( len: 1; sym: -7 )
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
