unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonSinglePl: TButton;
    ButtonTwoPl: TButton;
    ExitButton: TButton;
    Label1: TLabel;
    procedure ButtonSinglePlClick(Sender: TObject);
    procedure ButtonTwoPlClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

uses ManVSMan, ManVSAI;

{$R *.lfm}

{ TForm1 }

procedure TForm1.ButtonTwoPlClick(Sender: TObject);
begin
  Form1.Hide();
  Application.CreateForm(TForm2, Form2);
  Form2.Show();
end;

procedure TForm1.ButtonSinglePlClick(Sender: TObject);
begin
     Form1.Hide();
     Application.CreateForm(TForm3, Form3);
     Form3.Show();
end;

procedure TForm1.ExitButtonClick(Sender: TObject);
begin
  Form1.Close();
end;

end.

