program warcaby;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Unit1, ManVSMan, globalne, bialyPionekFS, bialyPionekFP,
  czarnyPionekFS, czarnyPionekFP, bialaDamkaFS, czarnaDamkaFS, uniwersalne,
  ManVSAI, czarnyPionekFPAI, czarnaDamkaFSAI
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
