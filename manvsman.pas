unit ManVSMan;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Pole2, bialyPionekFS, bialyPionekFP, czarnyPionekFS, czarnyPionekFP, globalne, uniwersalne;

type

  { TForm2 }

  TForm2 = class(TForm)
    ButtonRes: TButton;
    ButtonMVMExit: TButton;
    Pole2_1: TPole2;
    Pole2_10: TPole2;
    Pole2_11: TPole2;
    Pole2_12: TPole2;
    Pole2_13: TPole2;
    Pole2_14: TPole2;
    Pole2_15: TPole2;
    Pole2_16: TPole2;
    Pole2_17: TPole2;
    Pole2_18: TPole2;
    Pole2_19: TPole2;
    Pole2_2: TPole2;
    Pole2_20: TPole2;
    Pole2_21: TPole2;
    Pole2_22: TPole2;
    Pole2_23: TPole2;
    Pole2_24: TPole2;
    Pole2_25: TPole2;
    Pole2_26: TPole2;
    Pole2_27: TPole2;
    Pole2_28: TPole2;
    Pole2_29: TPole2;
    Pole2_3: TPole2;
    Pole2_30: TPole2;
    Pole2_31: TPole2;
    Pole2_32: TPole2;
    Pole2_33: TPole2;
    Pole2_34: TPole2;
    Pole2_35: TPole2;
    Pole2_36: TPole2;
    Pole2_37: TPole2;
    Pole2_38: TPole2;
    Pole2_39: TPole2;
    Pole2_4: TPole2;
    Pole2_40: TPole2;
    Pole2_41: TPole2;
    Pole2_42: TPole2;
    Pole2_43: TPole2;
    Pole2_44: TPole2;
    Pole2_45: TPole2;
    Pole2_46: TPole2;
    Pole2_47: TPole2;
    Pole2_48: TPole2;
    Pole2_49: TPole2;
    Pole2_5: TPole2;
    Pole2_50: TPole2;
    Pole2_51: TPole2;
    Pole2_52: TPole2;
    Pole2_53: TPole2;
    Pole2_54: TPole2;
    Pole2_55: TPole2;
    Pole2_56: TPole2;
    Pole2_57: TPole2;
    Pole2_58: TPole2;
    Pole2_59: TPole2;
    Pole2_6: TPole2;
    Pole2_60: TPole2;
    Pole2_61: TPole2;
    Pole2_62: TPole2;
    Pole2_63: TPole2;
    Pole2_64: TPole2;
    Pole2_7: TPole2;
    Pole2_8: TPole2;
    Pole2_9: TPole2;
    procedure ButtonMVMExitClick(Sender: TObject);
    procedure ButtonResClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Pole2_10Click(Sender: TObject);
    procedure Pole2_12Click(Sender: TObject);
    procedure Pole2_14Click(Sender: TObject);
    procedure Pole2_16Click(Sender: TObject);
    procedure Pole2_17Click(Sender: TObject);
    procedure Pole2_19Click(Sender: TObject);
    procedure Pole2_1Click(Sender: TObject);
    procedure Pole2_21Click(Sender: TObject);
    procedure Pole2_23Click(Sender: TObject);
    procedure Pole2_26Click(Sender: TObject);
    procedure Pole2_28Click(Sender: TObject);
    procedure Pole2_30Click(Sender: TObject);
    procedure Pole2_32Click(Sender: TObject);
    procedure Pole2_33Click(Sender: TObject);
    procedure Pole2_35Click(Sender: TObject);
    procedure Pole2_37Click(Sender: TObject);
    procedure Pole2_39Click(Sender: TObject);
    procedure Pole2_3Click(Sender: TObject);
    procedure Pole2_42Click(Sender: TObject);
    procedure Pole2_44Click(Sender: TObject);
    procedure Pole2_46Click(Sender: TObject);
    procedure Pole2_48Click(Sender: TObject);
    procedure Pole2_49Click(Sender: TObject);
    procedure Pole2_51Click(Sender: TObject);
    procedure Pole2_53Click(Sender: TObject);
    procedure Pole2_55Click(Sender: TObject);
    procedure Pole2_58Click(Sender: TObject);
    procedure Pole2_5Click(Sender: TObject);
    procedure Pole2_60Click(Sender: TObject);
    procedure Pole2_62Click(Sender: TObject);
    procedure Pole2_64Click(Sender: TObject);
    procedure Pole2_7Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1;

//******* Sprawdzenie czyj ruch i dalsza interakcja *************************
procedure sprawdzCzyjRuch();
begin
     if (czyjRuch = 0) then
     begin
          if (czyWybrany = false) then
          begin
               rozpoznajBialeFigury();
               if (pomylka = false) then
               begin
                    czyWybrany := true;
               end
               else
               begin
                 pomylka := false;
               end;
          end
          else
          begin
            wybierzPoleDoceloweDlaBialegoGracza();
            if (pomylka = false) then
            begin
                 czyjRuch := 1;
                 czyWybrany := false;
                 czyJestBicie := false;
                 dezaktywujPionkiCzarne();
                 dezaktywujPionkiBiale();
                 SprawdzZwyciezce();
                 if (not czyKoniecGry) then
                 begin
                      AkwtywujOdpowiednieFiguryDlaCzarnego();
                 end;

            end
            else
            begin
              pomylka := false;
            end;
          end;
     end
     else
     begin
          if (czyWybrany = false) then
          begin
               rozpoznajCzarneFigury();
               if (pomylka = false) then
               begin
                    czyWybrany := true;
               end
               else
               begin
                 pomylka := false;
               end;
          end
          else
          begin
            wybierzPoleDoceloweDlaCzarnegoGracza();
            if (pomylka = false) then
            begin
                 czyjRuch := 0;
                 czyJestBicie := false;
                 czyWybrany := false;
                 dezaktywujPionkiCzarne();
                 dezaktywujPionkiBiale();
                 SprawdzZwyciezce();
                 if (not czyKoniecGry) then
                 begin
                      AkwtywujOdpowiednieFiguryDlaBialego();
                 end;

            end
            else
            begin
              pomylka := false;
            end;
          end;
     end;
end;
//*************************************************************************

//****************** Procedura odpalajaca caly kram ***********************
procedure start(var Pole:TPole2);
begin
     if (czyWybrany) then
     begin
          wybranePoleDoc := Pole;
     end
     else
     begin
       kliknietePole := Pole;
     end;
     sprawdzCzyjRuch();
end;
//*************************************************************************

{$R *.lfm}

{ TForm2 }

procedure TForm2.ButtonMVMExitClick(Sender: TObject);
begin
     Form2.Release();
     Form1.Show();
end;

procedure TForm2.ButtonResClick(Sender: TObject);
begin
  rezygnuj();
end;

procedure TForm2.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
     Form2.Release();
     Form1.Show();
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  iloscBialychPionkow := 12;
     iloscCzarnychPionkow := 12;

     //Przypisanie czarnych pionków
     bialePionki[1] := Pole2_42;
     bialePionki[2] := Pole2_44;
     bialePionki[3] := Pole2_46;
     bialePionki[4] := Pole2_48;
     bialePionki[5] := Pole2_49;
     bialePionki[6] := Pole2_51;
     bialePionki[7] := Pole2_53;
     bialePionki[8] := Pole2_55;
     bialePionki[9] := Pole2_58;
     bialePionki[10] := Pole2_60;
     bialePionki[11] := Pole2_62;
     bialePionki[12] := Pole2_64;

     //Przypisanie bialych pionków
     czarnePionki[1] := Pole2_1;
     czarnePionki[2] := Pole2_3;
     czarnePionki[3] := Pole2_5;
     czarnePionki[4] := Pole2_7;
     czarnePionki[5] := Pole2_10;
     czarnePionki[6] := Pole2_12;
     czarnePionki[7] := Pole2_14;
     czarnePionki[8] := Pole2_16;
     czarnePionki[9] := Pole2_17;
     czarnePionki[10] := Pole2_19;
     czarnePionki[11] := Pole2_21;
     czarnePionki[12] := Pole2_23;

     //Pzypisanie ruchu bialym pionkom
     czyjRuch := 0;
     czyWybrany := false;
     pomylka := false;
     czyJestBicie := false;
     czyKoniecGry := false;

     dezaktywujPionkiCzarne();
     dezaktywujPionkiBiale();
     AkwtywujOdpowiednieFiguryDlaBialego();
     //AkwtywujOdpowiednieFiguryDlaCzarnego();

     //Przypisanie odpowiedznich sciezek
     sciezkaBP := 'img/bialyPionek.jpg';
     sciezkaBPZ := 'img/bialyPionekObramowanie.jpg';
     sciezkaBD := 'img/bialaDamka.jpg';
     sciezkaBDZ := 'img/bialaDamkaObramowanie.jpg';
     sciezkaCPole := 'img/blackField.jpg';
     sciezkaCD := 'img/czarnaDamka.jpg';
     sciezkaCDZ := 'img/czarnaDamkaZObramowanie.jpg';
     sciezkaCP := 'img/czarnyPionek.jpg';
     sciezkaCPZ := 'img/czarnyPionekZObramowanie.jpg';
end;

procedure TForm2.Pole2_10Click(Sender: TObject);
begin
     start(Pole2_10);
end;

procedure TForm2.Pole2_12Click(Sender: TObject);
begin
  start(Pole2_12);
end;

procedure TForm2.Pole2_14Click(Sender: TObject);
begin
  start(Pole2_14);
end;

procedure TForm2.Pole2_16Click(Sender: TObject);
begin
  start(Pole2_16);
end;

procedure TForm2.Pole2_17Click(Sender: TObject);
begin
  start(Pole2_17);
end;

procedure TForm2.Pole2_19Click(Sender: TObject);
begin
  start(Pole2_19);
end;

procedure TForm2.Pole2_1Click(Sender: TObject);
begin
  start(Pole2_1);
end;

procedure TForm2.Pole2_21Click(Sender: TObject);
begin
  start(Pole2_21);
end;

procedure TForm2.Pole2_23Click(Sender: TObject);
begin
  start(Pole2_23);
end;

procedure TForm2.Pole2_26Click(Sender: TObject);
begin
  start(Pole2_26);
end;

procedure TForm2.Pole2_28Click(Sender: TObject);
begin
  start(Pole2_28);
end;

procedure TForm2.Pole2_30Click(Sender: TObject);
begin
  start(Pole2_30);
end;

procedure TForm2.Pole2_32Click(Sender: TObject);
begin
  start(Pole2_32);
end;

procedure TForm2.Pole2_33Click(Sender: TObject);
begin
  start(Pole2_33);
end;

procedure TForm2.Pole2_35Click(Sender: TObject);
begin
  start(Pole2_35);
end;

procedure TForm2.Pole2_37Click(Sender: TObject);
begin
  start(Pole2_37);
end;

procedure TForm2.Pole2_39Click(Sender: TObject);
begin
  start(Pole2_39);
end;

procedure TForm2.Pole2_3Click(Sender: TObject);
begin
  start(Pole2_3);
end;

procedure TForm2.Pole2_42Click(Sender: TObject);
begin
  start(Pole2_42);
end;

procedure TForm2.Pole2_44Click(Sender: TObject);
begin
  start(Pole2_44);
end;

procedure TForm2.Pole2_46Click(Sender: TObject);
begin
  start(Pole2_46);
end;

procedure TForm2.Pole2_48Click(Sender: TObject);
begin
  start(Pole2_48);
end;

procedure TForm2.Pole2_49Click(Sender: TObject);
begin
  start(Pole2_49);
end;

procedure TForm2.Pole2_51Click(Sender: TObject);
begin
  start(Pole2_51);
end;

procedure TForm2.Pole2_53Click(Sender: TObject);
begin
     start(Pole2_53);
end;

procedure TForm2.Pole2_55Click(Sender: TObject);
begin
  start(Pole2_55);
end;

procedure TForm2.Pole2_58Click(Sender: TObject);
begin
  start(Pole2_58);
end;

procedure TForm2.Pole2_5Click(Sender: TObject);
begin
  start(Pole2_5);
end;

procedure TForm2.Pole2_60Click(Sender: TObject);
begin
     start(Pole2_60);
end;

procedure TForm2.Pole2_62Click(Sender: TObject);
begin
  start(Pole2_62);
end;

procedure TForm2.Pole2_64Click(Sender: TObject);
begin
  start(Pole2_64);
end;

procedure TForm2.Pole2_7Click(Sender: TObject);
begin
  start(Pole2_7);
end;

end.

