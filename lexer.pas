
(* lexical analyzer template (TP Lex V3.0), V1.0 3-2-91 AG *)

(* global definitions: *)



function yylex : Integer;

procedure yyaction ( yyruleno : Integer );
  (* local definitions: *)

begin
  (* actions: *)
  case yyruleno of
  1:
   				begin
                                     if NonkelDebug then writeln('T_OPERATOR');
                                     yylval.yyTOperator:= OPERATOR_PLUS;
                                     return(T_OPERATOR);
                                end;

  2:
   				begin
                                     if NonkelDebug then writeln('T_OPERATOR');
                                     yylval.yyTOperator:= OPERATOR_MIN;
                                     return(T_OPERATOR);
                                end;
  3:
   				begin
                                     if NonkelDebug then writeln('T_OPERATOR');
                                     yylval.yyTOperator:= OPERATOR_MUL;
                                     return(T_OPERATOR);
                                end;
  4:
                                begin
                                     if NonkelDebug then writeln('T_OPERATOR');
                                     yylval.yyTOperator:= OPERATOR_DIV;
                                     return(T_OPERATOR);
                                end;

  5:
                                begin
                                     if NonkelDebug then writeln('T_CMP');
                                     yylval.yyTCompType:= LESSER;
                                     return(T_CMP);
                                end;
  6:
                                begin
                                     if NonkelDebug then writeln('T_CMP');
                                     yylval.yyTCompType:= GREATER;
                                     return(T_CMP);
                                end;

  7:
                                begin
                                     if NonkelDebug then writeln('T_CMP');
                                     yylval.yyTCompType:= EQUAL;
                                     return(T_CMP);
                                end;

  8:
                                begin
                                     if NonkelDebug then writeln('T_BEGIN');
                                     return(T_BEGIN);
                                end;

  9:
                                begin
                                     if NonkelDebug then writeln('T_END');
                                     return(T_END);
                                end;

  10:
                                begin
                                     if NonkelDebug then writeln('T_EQUAL');
                                     return(T_EQUAL);
                                end;

  11:
                                begin
                                     if NonkelDebug then writeln('T_COLON');
                                     return(T_COLON);
                                end;

  12:
                                begin
                                     if NonkelDebug then writeln('T_PRINT');
                                     return(T_PRINT);
                                end;

  13:
                                begin
                                     if NonkelDebug then writeln('T_PRINT');
                                     return(T_EXIT);
                                end;

  14:
                                begin
                                     if NonkelDebug then writeln('T_IF');
                                     return(T_IF);
                                end;

  15:
                                begin
                                     if NonkelDebug then writeln('T_WHILE');
                                     return(T_WHILE);
                                end;

  16:
                                begin
                                     if NonkelDebug then writeln('T_VAR');
                                     return(T_VAR);
                                end;

  17:
                                begin
                                     if NonkelDebug then writeln('T_SCRIPT');
                                     return(T_SCRIPT);
                                end;

  18:
           			begin
                                     if NonkelDebug then writeln('T_NUMBER');
                                     yylval.yyTValue:= TValue.Create(StrToFloat(yytext));
                                     return(T_NUMBER);
                                end;

  19:
                                begin
                                     if NonkelDebug then writeln('T_IDENTIFIER');
                                     yylval.yyshortstring := yytext;
                                     return(T_IDENTIFIER);
                                end;

  20:
   				begin
                                     if NonkelDebug then writeln('T_SEMICOLON');
                                     return(T_SEMICOLON);
                                end;
  21:
       				;
  22:
 				begin
                                     writeln('error: unknown character', yytext);
                                end;
  end;
end(*yyaction*);

(* DFA table: *)

type YYTRec = record
                cc : set of Char;
                s  : Integer;
              end;

const

yynmarks   = 70;
yynmatches = 70;
yyntrans   = 93;
yynstates  = 46;

yyk : array [1..yynmarks] of Integer = (
  { 0: }
  { 1: }
  { 2: }
  1,
  22,
  { 3: }
  2,
  22,
  { 4: }
  3,
  22,
  { 5: }
  4,
  22,
  { 6: }
  5,
  22,
  { 7: }
  6,
  22,
  { 8: }
  7,
  22,
  { 9: }
  8,
  22,
  { 10: }
  9,
  22,
  { 11: }
  11,
  22,
  { 12: }
  19,
  22,
  { 13: }
  19,
  22,
  { 14: }
  19,
  22,
  { 15: }
  19,
  22,
  { 16: }
  19,
  22,
  { 17: }
  19,
  22,
  { 18: }
  18,
  22,
  { 19: }
  19,
  22,
  { 20: }
  20,
  22,
  { 21: }
  21,
  { 22: }
  21,
  22,
  { 23: }
  22,
  { 24: }
  10,
  { 25: }
  19,
  { 26: }
  19,
  { 27: }
  19,
  { 28: }
  14,
  19,
  { 29: }
  19,
  { 30: }
  19,
  { 31: }
  19,
  { 32: }
  18,
  { 33: }
  19,
  { 34: }
  19,
  { 35: }
  19,
  { 36: }
  16,
  19,
  { 37: }
  19,
  { 38: }
  19,
  { 39: }
  13,
  19,
  { 40: }
  19,
  { 41: }
  19,
  { 42: }
  12,
  19,
  { 43: }
  15,
  19,
  { 44: }
  19,
  { 45: }
  17,
  19
);

yym : array [1..yynmatches] of Integer = (
{ 0: }
{ 1: }
{ 2: }
  1,
  22,
{ 3: }
  2,
  22,
{ 4: }
  3,
  22,
{ 5: }
  4,
  22,
{ 6: }
  5,
  22,
{ 7: }
  6,
  22,
{ 8: }
  7,
  22,
{ 9: }
  8,
  22,
{ 10: }
  9,
  22,
{ 11: }
  11,
  22,
{ 12: }
  19,
  22,
{ 13: }
  19,
  22,
{ 14: }
  19,
  22,
{ 15: }
  19,
  22,
{ 16: }
  19,
  22,
{ 17: }
  19,
  22,
{ 18: }
  18,
  22,
{ 19: }
  19,
  22,
{ 20: }
  20,
  22,
{ 21: }
  21,
{ 22: }
  21,
  22,
{ 23: }
  22,
{ 24: }
  10,
{ 25: }
  19,
{ 26: }
  19,
{ 27: }
  19,
{ 28: }
  14,
  19,
{ 29: }
  19,
{ 30: }
  19,
{ 31: }
  19,
{ 32: }
  18,
{ 33: }
  19,
{ 34: }
  19,
{ 35: }
  19,
{ 36: }
  16,
  19,
{ 37: }
  19,
{ 38: }
  19,
{ 39: }
  13,
  19,
{ 40: }
  19,
{ 41: }
  19,
{ 42: }
  12,
  19,
{ 43: }
  15,
  19,
{ 44: }
  19,
{ 45: }
  17,
  19
);

yyt : array [1..yyntrans] of YYTrec = (
{ 0: }
  ( cc: [ #1..#8,#11..#31,'!'..')',',','.','0','?','@',
            '['..'`','|','~'..#255 ]; s: 23),
  ( cc: [ #9,' ' ]; s: 22),
  ( cc: [ #10 ]; s: 21),
  ( cc: [ '*' ]; s: 4),
  ( cc: [ '+' ]; s: 2),
  ( cc: [ '-' ]; s: 3),
  ( cc: [ '/' ]; s: 5),
  ( cc: [ '1'..'9' ]; s: 18),
  ( cc: [ ':' ]; s: 11),
  ( cc: [ ';' ]; s: 20),
  ( cc: [ '<' ]; s: 6),
  ( cc: [ '=' ]; s: 8),
  ( cc: [ '>' ]; s: 7),
  ( cc: [ 'A'..'Z','a'..'d','f'..'h','j'..'o','q','r',
            't','u','x'..'z' ]; s: 19),
  ( cc: [ 'e' ]; s: 13),
  ( cc: [ 'i' ]; s: 14),
  ( cc: [ 'p' ]; s: 12),
  ( cc: [ 's' ]; s: 17),
  ( cc: [ 'v' ]; s: 16),
  ( cc: [ 'w' ]; s: 15),
  ( cc: [ '{' ]; s: 9),
  ( cc: [ '}' ]; s: 10),
{ 1: }
  ( cc: [ #1..#8,#11..#31,'!'..')',',','.','0','?','@',
            '['..'`','|','~'..#255 ]; s: 23),
  ( cc: [ #9,' ' ]; s: 22),
  ( cc: [ #10 ]; s: 21),
  ( cc: [ '*' ]; s: 4),
  ( cc: [ '+' ]; s: 2),
  ( cc: [ '-' ]; s: 3),
  ( cc: [ '/' ]; s: 5),
  ( cc: [ '1'..'9' ]; s: 18),
  ( cc: [ ':' ]; s: 11),
  ( cc: [ ';' ]; s: 20),
  ( cc: [ '<' ]; s: 6),
  ( cc: [ '=' ]; s: 8),
  ( cc: [ '>' ]; s: 7),
  ( cc: [ 'A'..'Z','a'..'d','f'..'h','j'..'o','q','r',
            't','u','x'..'z' ]; s: 19),
  ( cc: [ 'e' ]; s: 13),
  ( cc: [ 'i' ]; s: 14),
  ( cc: [ 'p' ]; s: 12),
  ( cc: [ 's' ]; s: 17),
  ( cc: [ 'v' ]; s: 16),
  ( cc: [ 'w' ]; s: 15),
  ( cc: [ '{' ]; s: 9),
  ( cc: [ '}' ]; s: 10),
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
  ( cc: [ '=' ]; s: 24),
{ 12: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'q','s'..'z' ]; s: 26),
  ( cc: [ 'r' ]; s: 25),
{ 13: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'w','y','z' ]; s: 26),
  ( cc: [ 'x' ]; s: 27),
{ 14: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'e','g'..'z' ]; s: 26),
  ( cc: [ 'f' ]; s: 28),
{ 15: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'g','i'..'z' ]; s: 26),
  ( cc: [ 'h' ]; s: 29),
{ 16: }
  ( cc: [ '0'..'9','A'..'Z','_','b'..'z' ]; s: 26),
  ( cc: [ 'a' ]; s: 30),
{ 17: }
  ( cc: [ '0'..'9','A'..'Z','_','a','b','d'..'z' ]; s: 26),
  ( cc: [ 'c' ]; s: 31),
{ 18: }
  ( cc: [ '0'..'9' ]; s: 32),
{ 19: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'z' ]; s: 26),
{ 20: }
{ 21: }
{ 22: }
{ 23: }
{ 24: }
{ 25: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'h','j'..'z' ]; s: 26),
  ( cc: [ 'i' ]; s: 33),
{ 26: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'z' ]; s: 26),
{ 27: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'h','j'..'z' ]; s: 26),
  ( cc: [ 'i' ]; s: 34),
{ 28: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'z' ]; s: 26),
{ 29: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'h','j'..'z' ]; s: 26),
  ( cc: [ 'i' ]; s: 35),
{ 30: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'q','s'..'z' ]; s: 26),
  ( cc: [ 'r' ]; s: 36),
{ 31: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'q','s'..'z' ]; s: 26),
  ( cc: [ 'r' ]; s: 37),
{ 32: }
  ( cc: [ '0'..'9' ]; s: 32),
{ 33: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'m','o'..'z' ]; s: 26),
  ( cc: [ 'n' ]; s: 38),
{ 34: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'s','u'..'z' ]; s: 26),
  ( cc: [ 't' ]; s: 39),
{ 35: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'k','m'..'z' ]; s: 26),
  ( cc: [ 'l' ]; s: 40),
{ 36: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'z' ]; s: 26),
{ 37: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'h','j'..'z' ]; s: 26),
  ( cc: [ 'i' ]; s: 41),
{ 38: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'s','u'..'z' ]; s: 26),
  ( cc: [ 't' ]; s: 42),
{ 39: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'z' ]; s: 26),
{ 40: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'d','f'..'z' ]; s: 26),
  ( cc: [ 'e' ]; s: 43),
{ 41: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'o','q'..'z' ]; s: 26),
  ( cc: [ 'p' ]; s: 44),
{ 42: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'z' ]; s: 26),
{ 43: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'z' ]; s: 26),
{ 44: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'s','u'..'z' ]; s: 26),
  ( cc: [ 't' ]; s: 45),
{ 45: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'z' ]; s: 26)
);

yykl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 1,
{ 2: } 1,
{ 3: } 3,
{ 4: } 5,
{ 5: } 7,
{ 6: } 9,
{ 7: } 11,
{ 8: } 13,
{ 9: } 15,
{ 10: } 17,
{ 11: } 19,
{ 12: } 21,
{ 13: } 23,
{ 14: } 25,
{ 15: } 27,
{ 16: } 29,
{ 17: } 31,
{ 18: } 33,
{ 19: } 35,
{ 20: } 37,
{ 21: } 39,
{ 22: } 40,
{ 23: } 42,
{ 24: } 43,
{ 25: } 44,
{ 26: } 45,
{ 27: } 46,
{ 28: } 47,
{ 29: } 49,
{ 30: } 50,
{ 31: } 51,
{ 32: } 52,
{ 33: } 53,
{ 34: } 54,
{ 35: } 55,
{ 36: } 56,
{ 37: } 58,
{ 38: } 59,
{ 39: } 60,
{ 40: } 62,
{ 41: } 63,
{ 42: } 64,
{ 43: } 66,
{ 44: } 68,
{ 45: } 69
);

yykh : array [0..yynstates-1] of Integer = (
{ 0: } 0,
{ 1: } 0,
{ 2: } 2,
{ 3: } 4,
{ 4: } 6,
{ 5: } 8,
{ 6: } 10,
{ 7: } 12,
{ 8: } 14,
{ 9: } 16,
{ 10: } 18,
{ 11: } 20,
{ 12: } 22,
{ 13: } 24,
{ 14: } 26,
{ 15: } 28,
{ 16: } 30,
{ 17: } 32,
{ 18: } 34,
{ 19: } 36,
{ 20: } 38,
{ 21: } 39,
{ 22: } 41,
{ 23: } 42,
{ 24: } 43,
{ 25: } 44,
{ 26: } 45,
{ 27: } 46,
{ 28: } 48,
{ 29: } 49,
{ 30: } 50,
{ 31: } 51,
{ 32: } 52,
{ 33: } 53,
{ 34: } 54,
{ 35: } 55,
{ 36: } 57,
{ 37: } 58,
{ 38: } 59,
{ 39: } 61,
{ 40: } 62,
{ 41: } 63,
{ 42: } 65,
{ 43: } 67,
{ 44: } 68,
{ 45: } 70
);

yyml : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 1,
{ 2: } 1,
{ 3: } 3,
{ 4: } 5,
{ 5: } 7,
{ 6: } 9,
{ 7: } 11,
{ 8: } 13,
{ 9: } 15,
{ 10: } 17,
{ 11: } 19,
{ 12: } 21,
{ 13: } 23,
{ 14: } 25,
{ 15: } 27,
{ 16: } 29,
{ 17: } 31,
{ 18: } 33,
{ 19: } 35,
{ 20: } 37,
{ 21: } 39,
{ 22: } 40,
{ 23: } 42,
{ 24: } 43,
{ 25: } 44,
{ 26: } 45,
{ 27: } 46,
{ 28: } 47,
{ 29: } 49,
{ 30: } 50,
{ 31: } 51,
{ 32: } 52,
{ 33: } 53,
{ 34: } 54,
{ 35: } 55,
{ 36: } 56,
{ 37: } 58,
{ 38: } 59,
{ 39: } 60,
{ 40: } 62,
{ 41: } 63,
{ 42: } 64,
{ 43: } 66,
{ 44: } 68,
{ 45: } 69
);

yymh : array [0..yynstates-1] of Integer = (
{ 0: } 0,
{ 1: } 0,
{ 2: } 2,
{ 3: } 4,
{ 4: } 6,
{ 5: } 8,
{ 6: } 10,
{ 7: } 12,
{ 8: } 14,
{ 9: } 16,
{ 10: } 18,
{ 11: } 20,
{ 12: } 22,
{ 13: } 24,
{ 14: } 26,
{ 15: } 28,
{ 16: } 30,
{ 17: } 32,
{ 18: } 34,
{ 19: } 36,
{ 20: } 38,
{ 21: } 39,
{ 22: } 41,
{ 23: } 42,
{ 24: } 43,
{ 25: } 44,
{ 26: } 45,
{ 27: } 46,
{ 28: } 48,
{ 29: } 49,
{ 30: } 50,
{ 31: } 51,
{ 32: } 52,
{ 33: } 53,
{ 34: } 54,
{ 35: } 55,
{ 36: } 57,
{ 37: } 58,
{ 38: } 59,
{ 39: } 61,
{ 40: } 62,
{ 41: } 63,
{ 42: } 65,
{ 43: } 67,
{ 44: } 68,
{ 45: } 70
);

yytl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 23,
{ 2: } 45,
{ 3: } 45,
{ 4: } 45,
{ 5: } 45,
{ 6: } 45,
{ 7: } 45,
{ 8: } 45,
{ 9: } 45,
{ 10: } 45,
{ 11: } 45,
{ 12: } 46,
{ 13: } 48,
{ 14: } 50,
{ 15: } 52,
{ 16: } 54,
{ 17: } 56,
{ 18: } 58,
{ 19: } 59,
{ 20: } 60,
{ 21: } 60,
{ 22: } 60,
{ 23: } 60,
{ 24: } 60,
{ 25: } 60,
{ 26: } 62,
{ 27: } 63,
{ 28: } 65,
{ 29: } 66,
{ 30: } 68,
{ 31: } 70,
{ 32: } 72,
{ 33: } 73,
{ 34: } 75,
{ 35: } 77,
{ 36: } 79,
{ 37: } 80,
{ 38: } 82,
{ 39: } 84,
{ 40: } 85,
{ 41: } 87,
{ 42: } 89,
{ 43: } 90,
{ 44: } 91,
{ 45: } 93
);

yyth : array [0..yynstates-1] of Integer = (
{ 0: } 22,
{ 1: } 44,
{ 2: } 44,
{ 3: } 44,
{ 4: } 44,
{ 5: } 44,
{ 6: } 44,
{ 7: } 44,
{ 8: } 44,
{ 9: } 44,
{ 10: } 44,
{ 11: } 45,
{ 12: } 47,
{ 13: } 49,
{ 14: } 51,
{ 15: } 53,
{ 16: } 55,
{ 17: } 57,
{ 18: } 58,
{ 19: } 59,
{ 20: } 59,
{ 21: } 59,
{ 22: } 59,
{ 23: } 59,
{ 24: } 59,
{ 25: } 61,
{ 26: } 62,
{ 27: } 64,
{ 28: } 65,
{ 29: } 67,
{ 30: } 69,
{ 31: } 71,
{ 32: } 72,
{ 33: } 74,
{ 34: } 76,
{ 35: } 78,
{ 36: } 79,
{ 37: } 81,
{ 38: } 83,
{ 39: } 84,
{ 40: } 86,
{ 41: } 88,
{ 42: } 89,
{ 43: } 90,
{ 44: } 92,
{ 45: } 93
);


var yyn : Integer;

label start, scan, action;

begin

start:

  (* initialize: *)

  yynew;

scan:

  (* mark positions and matches: *)

  for yyn := yykl[yystate] to     yykh[yystate] do yymark(yyk[yyn]);
  for yyn := yymh[yystate] downto yyml[yystate] do yymatch(yym[yyn]);

  if yytl[yystate]>yyth[yystate] then goto action; (* dead state *)

  (* get next character: *)

  yyscan;

  (* determine action: *)

  yyn := yytl[yystate];
  while (yyn<=yyth[yystate]) and not (yyactchar in yyt[yyn].cc) do inc(yyn);
  if yyn>yyth[yystate] then goto action;
    (* no transition on yyactchar in this state *)

  (* switch to new state: *)

  yystate := yyt[yyn].s;

  goto scan;

action:

  (* execute action: *)

  if yyfind(yyrule) then
    begin
      yyaction(yyrule);
      if yyreject then goto action;
    end
  else if not yydefault and yywrap() then
    begin
      yyclear;
      return(0);
    end;

  if not yydone then goto start;

  yylex := yyretval;

end(*yylex*);



