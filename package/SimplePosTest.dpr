program SimplePosTest;

{$APPTYPE CONSOLE}

uses
  uTest in '..\src\test\uTest.pas';

begin
  with TTestSuit.Create do
    try
      Run;
      readln;
    finally
      Free;
    end;
end.

