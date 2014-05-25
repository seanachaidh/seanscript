
(* lexical analyzer template (TP Lex V3.0), V1.0 3-2-91 AG *)

(* global definitions: *)



function yylex : Integer;

procedure yyaction ( yyruleno : Integer );
  (* local definitions: *)

begin
  (* actions: *)
  case yyruleno of
  1:
   				return(T_PLUS);
  2:
   				return(T_MIN);
  3:
   				return(T_MUL);
  4:
                                return(T_DIV);
  5:
                                return(T_EQUAL);
  6:
                                return(T_COLON);
  7:
                                return(T_PRINT);
  8:
                                return(T_EXIT);
  9:
                                return(T_IF);


  10:
           			begin
                                     yylval.yyTNonkelVar:= TNonkelVar.Create('number', strtoint(yytext));
                                     return(T_NUMBER);
                                     end;

  11:
                                     begin
                                          case yytext of
                                               '<': yylval.yyTCmpType:= LESSER;
                                               '>': yylval.yyTCmpType:= GREATER;
                                               '=': yylval.yyTCmpType:= EQUAL;
                                          end;
                                          return(T_CMP);
                                          end;
  12:
                                begin yylval.yynstring := yytext; return(T_IDENTIFIER); end;
  13:
  				return(T_EOL);
  14:
     				;
  15:
 				writeln('error: unknown character', yytext);

  end;
end(*yyaction*);

(* DFA table: *)

type YYTRec = record
                cc : set of Char;
                s  : Integer;
              end;

const

yynmarks   = 42;
yynmatches = 42;
yyntrans   = 53;
yynstates  = 27;

yyk : array [1..yynmarks] of Integer = (
  { 0: }
  { 1: }
  { 2: }
  1,
  15,
  { 3: }
  2,
  15,
  { 4: }
  3,
  15,
  { 5: }
  4,
  15,
  { 6: }
  5,
  11,
  15,
  { 7: }
  6,
  15,
  { 8: }
  12,
  15,
  { 9: }
  12,
  15,
  { 10: }
  12,
  15,
  { 11: }
  10,
  15,
  { 12: }
  11,
  15,
  { 13: }
  12,
  15,
  { 14: }
  13,
  { 15: }
  14,
  15,
  { 16: }
  15,
  { 17: }
  12,
  { 18: }
  12,
  { 19: }
  12,
  { 20: }
  9,
  12,
  { 21: }
  10,
  { 22: }
  12,
  { 23: }
  12,
  { 24: }
  12,
  { 25: }
  8,
  12,
  { 26: }
  7,
  12
);

yym : array [1..yynmatches] of Integer = (
{ 0: }
{ 1: }
{ 2: }
  1,
  15,
{ 3: }
  2,
  15,
{ 4: }
  3,
  15,
{ 5: }
  4,
  15,
{ 6: }
  5,
  11,
  15,
{ 7: }
  6,
  15,
{ 8: }
  12,
  15,
{ 9: }
  12,
  15,
{ 10: }
  12,
  15,
{ 11: }
  10,
  15,
{ 12: }
  11,
  15,
{ 13: }
  12,
  15,
{ 14: }
  13,
{ 15: }
  14,
  15,
{ 16: }
  15,
{ 17: }
  12,
{ 18: }
  12,
{ 19: }
  12,
{ 20: }
  9,
  12,
{ 21: }
  10,
{ 22: }
  12,
{ 23: }
  12,
{ 24: }
  12,
{ 25: }
  8,
  12,
{ 26: }
  7,
  12
);

yyt : array [1..yyntrans] of YYTrec = (
{ 0: }
  ( cc: [ #1..#8,#11..#31,'!'..')',',','.','0',';',
            '?','@','['..'`','{'..#255 ]; s: 16),
  ( cc: [ #9,' ' ]; s: 15),
  ( cc: [ #10 ]; s: 14),
  ( cc: [ '*' ]; s: 4),
  ( cc: [ '+' ]; s: 2),
  ( cc: [ '-' ]; s: 3),
  ( cc: [ '/' ]; s: 5),
  ( cc: [ '1'..'9' ]; s: 11),
  ( cc: [ ':' ]; s: 7),
  ( cc: [ '<','>' ]; s: 12),
  ( cc: [ '=' ]; s: 6),
  ( cc: [ 'A'..'Z','a'..'d','f'..'h','j'..'o','q'..'z' ]; s: 13),
  ( cc: [ 'e' ]; s: 9),
  ( cc: [ 'i' ]; s: 10),
  ( cc: [ 'p' ]; s: 8),
{ 1: }
  ( cc: [ #1..#8,#11..#31,'!'..')',',','.','0',';',
            '?','@','['..'`','{'..#255 ]; s: 16),
  ( cc: [ #9,' ' ]; s: 15),
  ( cc: [ #10 ]; s: 14),
  ( cc: [ '*' ]; s: 4),
  ( cc: [ '+' ]; s: 2),
  ( cc: [ '-' ]; s: 3),
  ( cc: [ '/' ]; s: 5),
  ( cc: [ '1'..'9' ]; s: 11),
  ( cc: [ ':' ]; s: 7),
  ( cc: [ '<','>' ]; s: 12),
  ( cc: [ '=' ]; s: 6),
  ( cc: [ 'A'..'Z','a'..'d','f'..'h','j'..'o','q'..'z' ]; s: 13),
  ( cc: [ 'e' ]; s: 9),
  ( cc: [ 'i' ]; s: 10),
  ( cc: [ 'p' ]; s: 8),
{ 2: }
{ 3: }
{ 4: }
{ 5: }
{ 6: }
{ 7: }
{ 8: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'q','s'..'z' ]; s: 18),
  ( cc: [ 'r' ]; s: 17),
{ 9: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'w','y','z' ]; s: 18),
  ( cc: [ 'x' ]; s: 19),
{ 10: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'e','g'..'z' ]; s: 18),
  ( cc: [ 'f' ]; s: 20),
{ 11: }
  ( cc: [ '0'..'9' ]; s: 21),
{ 12: }
{ 13: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'z' ]; s: 18),
{ 14: }
{ 15: }
{ 16: }
{ 17: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'h','j'..'z' ]; s: 18),
  ( cc: [ 'i' ]; s: 22),
{ 18: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'z' ]; s: 18),
{ 19: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'h','j'..'z' ]; s: 18),
  ( cc: [ 'i' ]; s: 23),
{ 20: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'z' ]; s: 18),
{ 21: }
  ( cc: [ '0'..'9' ]; s: 21),
{ 22: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'m','o'..'z' ]; s: 18),
  ( cc: [ 'n' ]; s: 24),
{ 23: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'s','u'..'z' ]; s: 18),
  ( cc: [ 't' ]; s: 25),
{ 24: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'s','u'..'z' ]; s: 18),
  ( cc: [ 't' ]; s: 26),
{ 25: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'z' ]; s: 18),
{ 26: }
  ( cc: [ '0'..'9','A'..'Z','_','a'..'z' ]; s: 18)
);

yykl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 1,
{ 2: } 1,
{ 3: } 3,
{ 4: } 5,
{ 5: } 7,
{ 6: } 9,
{ 7: } 12,
{ 8: } 14,
{ 9: } 16,
{ 10: } 18,
{ 11: } 20,
{ 12: } 22,
{ 13: } 24,
{ 14: } 26,
{ 15: } 27,
{ 16: } 29,
{ 17: } 30,
{ 18: } 31,
{ 19: } 32,
{ 20: } 33,
{ 21: } 35,
{ 22: } 36,
{ 23: } 37,
{ 24: } 38,
{ 25: } 39,
{ 26: } 41
);

yykh : array [0..yynstates-1] of Integer = (
{ 0: } 0,
{ 1: } 0,
{ 2: } 2,
{ 3: } 4,
{ 4: } 6,
{ 5: } 8,
{ 6: } 11,
{ 7: } 13,
{ 8: } 15,
{ 9: } 17,
{ 10: } 19,
{ 11: } 21,
{ 12: } 23,
{ 13: } 25,
{ 14: } 26,
{ 15: } 28,
{ 16: } 29,
{ 17: } 30,
{ 18: } 31,
{ 19: } 32,
{ 20: } 34,
{ 21: } 35,
{ 22: } 36,
{ 23: } 37,
{ 24: } 38,
{ 25: } 40,
{ 26: } 42
);

yyml : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 1,
{ 2: } 1,
{ 3: } 3,
{ 4: } 5,
{ 5: } 7,
{ 6: } 9,
{ 7: } 12,
{ 8: } 14,
{ 9: } 16,
{ 10: } 18,
{ 11: } 20,
{ 12: } 22,
{ 13: } 24,
{ 14: } 26,
{ 15: } 27,
{ 16: } 29,
{ 17: } 30,
{ 18: } 31,
{ 19: } 32,
{ 20: } 33,
{ 21: } 35,
{ 22: } 36,
{ 23: } 37,
{ 24: } 38,
{ 25: } 39,
{ 26: } 41
);

yymh : array [0..yynstates-1] of Integer = (
{ 0: } 0,
{ 1: } 0,
{ 2: } 2,
{ 3: } 4,
{ 4: } 6,
{ 5: } 8,
{ 6: } 11,
{ 7: } 13,
{ 8: } 15,
{ 9: } 17,
{ 10: } 19,
{ 11: } 21,
{ 12: } 23,
{ 13: } 25,
{ 14: } 26,
{ 15: } 28,
{ 16: } 29,
{ 17: } 30,
{ 18: } 31,
{ 19: } 32,
{ 20: } 34,
{ 21: } 35,
{ 22: } 36,
{ 23: } 37,
{ 24: } 38,
{ 25: } 40,
{ 26: } 42
);

yytl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 16,
{ 2: } 31,
{ 3: } 31,
{ 4: } 31,
{ 5: } 31,
{ 6: } 31,
{ 7: } 31,
{ 8: } 31,
{ 9: } 33,
{ 10: } 35,
{ 11: } 37,
{ 12: } 38,
{ 13: } 38,
{ 14: } 39,
{ 15: } 39,
{ 16: } 39,
{ 17: } 39,
{ 18: } 41,
{ 19: } 42,
{ 20: } 44,
{ 21: } 45,
{ 22: } 46,
{ 23: } 48,
{ 24: } 50,
{ 25: } 52,
{ 26: } 53
);

yyth : array [0..yynstates-1] of Integer = (
{ 0: } 15,
{ 1: } 30,
{ 2: } 30,
{ 3: } 30,
{ 4: } 30,
{ 5: } 30,
{ 6: } 30,
{ 7: } 30,
{ 8: } 32,
{ 9: } 34,
{ 10: } 36,
{ 11: } 37,
{ 12: } 37,
{ 13: } 38,
{ 14: } 38,
{ 15: } 38,
{ 16: } 38,
{ 17: } 40,
{ 18: } 41,
{ 19: } 43,
{ 20: } 44,
{ 21: } 45,
{ 22: } 47,
{ 23: } 49,
{ 24: } 51,
{ 25: } 52,
{ 26: } 53
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


