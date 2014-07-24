
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
                                     if NonkelDebug then writeln('T_CMP');
                                     yylval.yyTCompType:= NOT_EQUAL;
                                     return (T_CMP);
                                end;

  9:
                                begin
                                     if NonkelDebug then writeln('T_BEGIN');
                                     return(T_BEGIN);
                                end;

  10:
                                begin
                                     if NonkelDebug then writeln('T_END');
                                     return(T_END);
                                end;

  11:
                                begin
                                     if NonkelDebug then writeln('T_EQUAL');
                                     return(T_EQUAL);
                                end;

  12:
                                begin
                                     if NonkelDebug then writeln('T_COLON');
                                     return(T_COLON);
                                end;

  13:
                                begin
                                     if NonkelDebug then writeln('T_PRINT');
                                     return(T_PRINT);
                                end;

  14:
                                begin
                                     if NonkelDebug then writeln('T_PRINT');
                                     return(T_EXIT);
                                end;

  15:
                                begin
                                     if NonkelDebug then writeln('T_IF');
                                     return(T_IF);
                                end;

  16:
                                begin
                                     if NonkelDebug then writeln('T_WHILE');
                                     return(T_WHILE);
                                end;

  17:
                                begin
                                     if NonkelDebug then writeln('T_VAR');
                                     return(T_VAR);
                                end;

  18:
                                begin
                                     if NonkelDebug then writeln('T_SCRIPT');
                                     return(T_SCRIPT);
                                end;

  19:
                 			begin
                                     if NonkelDebug then writeln('T_NUMBER');
                                     yylval.yyTValue:= TValue.Create(StrToFloat(yytext));
                                     return(T_NUMBER);
                                end;

  20:
                                begin
                                     if NonkelDebug then writeln('T_IDENTIFIER');
                                     yylval.yyshortstring := yytext;
                                     return(T_IDENTIFIER);
                                end;

  21:
   				begin
                                     if NonkelDebug then writeln('T_SEMICOLON');
                                     return(T_SEMICOLON);
                                end;
  22:
       				;
  23:
 				begin
                                     writeln('error: unknown character: ', yytext);
                                end;
  end;
end(*yyaction*);

(* DFA table: *)

type YYTRec = record
                cc : set of Char;
                s  : Integer;
              end;

const

yynmarks   = 75;
yynmatches = 75;
yyntrans   = 99;
yynstates  = 50;

yyk : array [1..yynmarks] of Integer = (
  { 0: }
  19,
  { 1: }
  19,
  { 2: }
  1,
  23,
  { 3: }
  2,
  23,
  { 4: }
  3,
  23,
  { 5: }
  4,
  23,
  { 6: }
  5,
  23,
  { 7: }
  6,
  23,
  { 8: }
  7,
  23,
  { 9: }
  23,
  { 10: }
  9,
  23,
  { 11: }
  10,
  23,
  { 12: }
  12,
  23,
  { 13: }
  20,
  23,
  { 14: }
  20,
  23,
  { 15: }
  20,
  23,
  { 16: }
  20,
  23,
  { 17: }
  20,
  23,
  { 18: }
  20,
  23,
  { 19: }
  19,
  23,
  { 20: }
  23,
  { 21: }
  20,
  23,
  { 22: }
  21,
  23,
  { 23: }
  22,
  { 24: }
  22,
  23,
  { 25: }
  23,
  { 26: }
  8,
  { 27: }
  11,
  { 28: }
  20,
  { 29: }
  20,
  { 30: }
  20,
  { 31: }
  15,
  20,
  { 32: }
  20,
  { 33: }
  20,
  { 34: }
  20,
  { 35: }
  19,
  { 36: }
  20,
  { 37: }
  20,
  { 38: }
  20,
  { 39: }
  17,
  20,
  { 40: }
  20,
  { 41: }
  { 42: }
  20,
  { 43: }
  14,
  20,
  { 44: }
  20,
  { 45: }
  20,
  { 46: }
  13,
  20,
  { 47: }
  16,
  20,
  { 48: }
  20,
  { 49: }
  18,
  20
);

yym : array [1..yynmatches] of Integer = (
{ 0: }
  19,
{ 1: }
  19,
{ 2: }
  1,
  23,
{ 3: }
  2,
  23,
{ 4: }
  3,
  23,
{ 5: }
  4,
  23,
{ 6: }
  5,
  23,
{ 7: }
  6,
  23,
{ 8: }
  7,
  23,
{ 9: }
  23,
{ 10: }
  9,
  23,
{ 11: }
  10,
  23,
{ 12: }
  12,
  23,
{ 13: }
  20,
  23,
{ 14: }
  20,
  23,
{ 15: }
  20,
  23,
{ 16: }
  20,
  23,
{ 17: }
  20,
  23,
{ 18: }
  20,
  23,
{ 19: }
  19,
  23,
{ 20: }
  23,
{ 21: }
  20,
  23,
{ 22: }
  21,
  23,
{ 23: }
  22,
{ 24: }
  22,
  23,
{ 25: }
  23,
{ 26: }
  8,
{ 27: }
  11,
{ 28: }
  20,
{ 29: }
  20,
{ 30: }
  20,
{ 31: }
  15,
  20,
{ 32: }
  20,
{ 33: }
  20,
{ 34: }
  20,
{ 35: }
  19,
{ 36: }
  20,
{ 37: }
  20,
{ 38: }
  20,
{ 39: }
  17,
  20,
{ 40: }
  20,
{ 41: }
{ 42: }
  20,
{ 43: }
  14,
  20,
{ 44: }
  20,
{ 45: }
  20,
{ 46: }
  13,
  20,
{ 47: }
  16,
  20,
{ 48: }
  20,
{ 49: }
  18,
  20
);

yyt : array [1..yyntrans] of YYTrec = (
{ 0: }
  ( cc: [ #1..#8,#11..#31,'"'..')',',','.','?','@',
            '['..'`','|','~'..#255 ]; s: 25),
  ( cc: [ #9,' ' ]; s: 24),
  ( cc: [ #10 ]; s: 23),
  ( cc: [ '!' ]; s: 9),
  ( cc: [ '*' ]; s: 4),
  ( cc: [ '+' ]; s: 2),
  ( cc: [ '-' ]; s: 3),
  ( cc: [ '/' ]; s: 5),
  ( cc: [ '0' ]; s: 19),
  ( cc: [ '1'..'9' ]; s: 20),
  ( cc: [ ':' ]; s: 12),
  ( cc: [ ';' ]; s: 22),
  ( cc: [ '<' ]; s: 6),
  ( cc: [ '=' ]; s: 8),
  ( cc: [ '>' ]; s: 7),
  ( cc: [ 'A'..'Z','a'..'d','f'..'h','j'..'o','q','r',
            't','u','x'..'z' ]; s: 21),
  ( cc: [ 'e' ]; s: 14),
  ( cc: [ 'i' ]; s: 15),
  ( cc: [ 'p' ]; s: 13),
  ( cc: [ 's' ]; s: 18),
  ( cc: [ 'v' ]; s: 17),
  ( cc: [ 'w' ]; s: 16),
  ( cc: [ '{' ]; s: 10),
  ( cc: [ '}' ]; s: 11),
{ 1: }
  ( cc: [ #1..#8,#11..#31,'"'..')',',','.','?','@',
            '['..'`','|','~'..#255 ]; s: 25),
  ( cc: [ #9,' ' ]; s: 24),
  ( cc: [ #10 ]; s: 23),
  ( cc: [ '!' ]; s: 9),
  ( cc: [ '*' ]; s: 4),
  ( cc: [ '+' ]; s: 2),
  ( cc: [ '-' ]; s: 3),
  ( cc: [ '/' ]; s: 5),
  ( cc: [ '0' ]; s: 19),
  ( cc: [ '1'..'9' ]; s: 20),
  ( cc: [ ':' ]; s: 12),
  ( cc: [ ';' ]; s: 22),
  ( cc: [ '<' ]; s: 6),
  ( cc: [ '=' ]; s: 8),
  ( cc: [ '>' ]; s: 7),
  ( cc: [ 'A'..'Z','a'..'d','f'..'h','j'..'o','q','r',
            't','u','x'..'z' ]; s: 21),
  ( cc: [ 'e' ]; s: 14),
  ( cc: [ 'i' ]; s: 15),
  ( cc: [ 'p' ]; s: 13),
  ( cc: [ 's' ]; s: 18),
  ( cc: [ 'v' ]; s: 17),
  ( cc: [ 'w' ]; s: 16),
  ( cc: [ '{' ]; s: 10),
  ( cc: [ '}' ]; s: 11),
{ 2: }
{ 3: }
{ 4: }
{ 5: }
{ 6: }
{ 7: }
{ 8: }
{ 9: }
  ( cc: [ '=' ]; s: 26),
{ 10: }
{ 11: }
{ 12: }
  ( cc: [ '=' ]; s: 27),
{ 13: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'q','s'..'z' ]; s: 29),
  ( cc: [ 'r' ]; s: 28),
{ 14: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'w','y','z' ]; s: 29),
  ( cc: [ 'x' ]; s: 30),
{ 15: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'e','g'..'z' ]; s: 29),
  ( cc: [ 'f' ]; s: 31),
{ 16: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'g','i'..'z' ]; s: 29),
  ( cc: [ 'h' ]; s: 32),
{ 17: }
  ( cc: [ '0'..'9','A'..'Z','_','b'..'z' ]; s: 29),
  ( cc: [ 'a' ]; s: 33),
{ 18: }
  ( cc: [ '0'..'9','A'..'Z','_','a','b','d'..'z' ]; s: 29),
  ( cc: [ 'c' ]; s: 34),
{ 19: }
{ 20: }
  ( cc: [ '0'..'9' ]; s: 35),
{ 21: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'z' ]; s: 29),
{ 22: }
{ 23: }
{ 24: }
{ 25: }
{ 26: }
{ 27: }
{ 28: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'h','j'..'z' ]; s: 29),
  ( cc: [ 'i' ]; s: 36),
{ 29: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'z' ]; s: 29),
{ 30: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'h','j'..'z' ]; s: 29),
  ( cc: [ 'i' ]; s: 37),
{ 31: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'z' ]; s: 29),
{ 32: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'h','j'..'z' ]; s: 29),
  ( cc: [ 'i' ]; s: 38),
{ 33: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'q','s'..'z' ]; s: 29),
  ( cc: [ 'r' ]; s: 39),
{ 34: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'q','s'..'z' ]; s: 29),
  ( cc: [ 'r' ]; s: 40),
{ 35: }
  ( cc: [ '1'..'9' ]; s: 41),
{ 36: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'m','o'..'z' ]; s: 29),
  ( cc: [ 'n' ]; s: 42),
{ 37: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'s','u'..'z' ]; s: 29),
  ( cc: [ 't' ]; s: 43),
{ 38: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'k','m'..'z' ]; s: 29),
  ( cc: [ 'l' ]; s: 44),
{ 39: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'z' ]; s: 29),
{ 40: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'h','j'..'z' ]; s: 29),
  ( cc: [ 'i' ]; s: 45),
{ 41: }
  ( cc: [ '0'..'9' ]; s: 35),
{ 42: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'s','u'..'z' ]; s: 29),
  ( cc: [ 't' ]; s: 46),
{ 43: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'z' ]; s: 29),
{ 44: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'d','f'..'z' ]; s: 29),
  ( cc: [ 'e' ]; s: 47),
{ 45: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'o','q'..'z' ]; s: 29),
  ( cc: [ 'p' ]; s: 48),
{ 46: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'z' ]; s: 29),
{ 47: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'z' ]; s: 29),
{ 48: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'s','u'..'z' ]; s: 29),
  ( cc: [ 't' ]; s: 49),
{ 49: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'z' ]; s: 29)
);

yykl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 2,
{ 2: } 3,
{ 3: } 5,
{ 4: } 7,
{ 5: } 9,
{ 6: } 11,
{ 7: } 13,
{ 8: } 15,
{ 9: } 17,
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
{ 23: } 43,
{ 24: } 44,
{ 25: } 46,
{ 26: } 47,
{ 27: } 48,
{ 28: } 49,
{ 29: } 50,
{ 30: } 51,
{ 31: } 52,
{ 32: } 54,
{ 33: } 55,
{ 34: } 56,
{ 35: } 57,
{ 36: } 58,
{ 37: } 59,
{ 38: } 60,
{ 39: } 61,
{ 40: } 63,
{ 41: } 64,
{ 42: } 64,
{ 43: } 65,
{ 44: } 67,
{ 45: } 68,
{ 46: } 69,
{ 47: } 71,
{ 48: } 73,
{ 49: } 74
);

yykh : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 2,
{ 2: } 4,
{ 3: } 6,
{ 4: } 8,
{ 5: } 10,
{ 6: } 12,
{ 7: } 14,
{ 8: } 16,
{ 9: } 17,
{ 10: } 19,
{ 11: } 21,
{ 12: } 23,
{ 13: } 25,
{ 14: } 27,
{ 15: } 29,
{ 16: } 31,
{ 17: } 33,
{ 18: } 35,
{ 19: } 37,
{ 20: } 38,
{ 21: } 40,
{ 22: } 42,
{ 23: } 43,
{ 24: } 45,
{ 25: } 46,
{ 26: } 47,
{ 27: } 48,
{ 28: } 49,
{ 29: } 50,
{ 30: } 51,
{ 31: } 53,
{ 32: } 54,
{ 33: } 55,
{ 34: } 56,
{ 35: } 57,
{ 36: } 58,
{ 37: } 59,
{ 38: } 60,
{ 39: } 62,
{ 40: } 63,
{ 41: } 63,
{ 42: } 64,
{ 43: } 66,
{ 44: } 67,
{ 45: } 68,
{ 46: } 70,
{ 47: } 72,
{ 48: } 73,
{ 49: } 75
);

yyml : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 2,
{ 2: } 3,
{ 3: } 5,
{ 4: } 7,
{ 5: } 9,
{ 6: } 11,
{ 7: } 13,
{ 8: } 15,
{ 9: } 17,
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
{ 23: } 43,
{ 24: } 44,
{ 25: } 46,
{ 26: } 47,
{ 27: } 48,
{ 28: } 49,
{ 29: } 50,
{ 30: } 51,
{ 31: } 52,
{ 32: } 54,
{ 33: } 55,
{ 34: } 56,
{ 35: } 57,
{ 36: } 58,
{ 37: } 59,
{ 38: } 60,
{ 39: } 61,
{ 40: } 63,
{ 41: } 64,
{ 42: } 64,
{ 43: } 65,
{ 44: } 67,
{ 45: } 68,
{ 46: } 69,
{ 47: } 71,
{ 48: } 73,
{ 49: } 74
);

yymh : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 2,
{ 2: } 4,
{ 3: } 6,
{ 4: } 8,
{ 5: } 10,
{ 6: } 12,
{ 7: } 14,
{ 8: } 16,
{ 9: } 17,
{ 10: } 19,
{ 11: } 21,
{ 12: } 23,
{ 13: } 25,
{ 14: } 27,
{ 15: } 29,
{ 16: } 31,
{ 17: } 33,
{ 18: } 35,
{ 19: } 37,
{ 20: } 38,
{ 21: } 40,
{ 22: } 42,
{ 23: } 43,
{ 24: } 45,
{ 25: } 46,
{ 26: } 47,
{ 27: } 48,
{ 28: } 49,
{ 29: } 50,
{ 30: } 51,
{ 31: } 53,
{ 32: } 54,
{ 33: } 55,
{ 34: } 56,
{ 35: } 57,
{ 36: } 58,
{ 37: } 59,
{ 38: } 60,
{ 39: } 62,
{ 40: } 63,
{ 41: } 63,
{ 42: } 64,
{ 43: } 66,
{ 44: } 67,
{ 45: } 68,
{ 46: } 70,
{ 47: } 72,
{ 48: } 73,
{ 49: } 75
);

yytl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 25,
{ 2: } 49,
{ 3: } 49,
{ 4: } 49,
{ 5: } 49,
{ 6: } 49,
{ 7: } 49,
{ 8: } 49,
{ 9: } 49,
{ 10: } 50,
{ 11: } 50,
{ 12: } 50,
{ 13: } 51,
{ 14: } 53,
{ 15: } 55,
{ 16: } 57,
{ 17: } 59,
{ 18: } 61,
{ 19: } 63,
{ 20: } 63,
{ 21: } 64,
{ 22: } 65,
{ 23: } 65,
{ 24: } 65,
{ 25: } 65,
{ 26: } 65,
{ 27: } 65,
{ 28: } 65,
{ 29: } 67,
{ 30: } 68,
{ 31: } 70,
{ 32: } 71,
{ 33: } 73,
{ 34: } 75,
{ 35: } 77,
{ 36: } 78,
{ 37: } 80,
{ 38: } 82,
{ 39: } 84,
{ 40: } 85,
{ 41: } 87,
{ 42: } 88,
{ 43: } 90,
{ 44: } 91,
{ 45: } 93,
{ 46: } 95,
{ 47: } 96,
{ 48: } 97,
{ 49: } 99
);

yyth : array [0..yynstates-1] of Integer = (
{ 0: } 24,
{ 1: } 48,
{ 2: } 48,
{ 3: } 48,
{ 4: } 48,
{ 5: } 48,
{ 6: } 48,
{ 7: } 48,
{ 8: } 48,
{ 9: } 49,
{ 10: } 49,
{ 11: } 49,
{ 12: } 50,
{ 13: } 52,
{ 14: } 54,
{ 15: } 56,
{ 16: } 58,
{ 17: } 60,
{ 18: } 62,
{ 19: } 62,
{ 20: } 63,
{ 21: } 64,
{ 22: } 64,
{ 23: } 64,
{ 24: } 64,
{ 25: } 64,
{ 26: } 64,
{ 27: } 64,
{ 28: } 66,
{ 29: } 67,
{ 30: } 69,
{ 31: } 70,
{ 32: } 72,
{ 33: } 74,
{ 34: } 76,
{ 35: } 77,
{ 36: } 79,
{ 37: } 81,
{ 38: } 83,
{ 39: } 84,
{ 40: } 86,
{ 41: } 87,
{ 42: } 89,
{ 43: } 90,
{ 44: } 92,
{ 45: } 94,
{ 46: } 95,
{ 47: } 96,
{ 48: } 98,
{ 49: } 99
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



