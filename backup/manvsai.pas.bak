unit ManVSAI;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Pole2, bialyPionekFS, bialyPionekFP, globalne, globalne2,
  czarnyPionekFSAI, uniwersalne;

type

  { TForm3 }

  TForm3 = class(TForm)
    ButtonMVAR: TButton;
    ButtonMVAE: TButton;
    Image1: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    Image18: TImage;
    Image19: TImage;
    Image2: TImage;
    Image20: TImage;
    Image21: TImage;
    Image22: TImage;
    Image23: TImage;
    Image24: TImage;
    Image25: TImage;
    Image26: TImage;
    Image27: TImage;
    Image28: TImage;
    Image29: TImage;
    Image3: TImage;
    Image30: TImage;
    Image31: TImage;
    Image32: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
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
    Pole2_4: TPole2;
    Pole2_5: TPole2;
    Pole2_6: TPole2;
    Pole2_7: TPole2;
    Pole2_8: TPole2;
    Pole2_9: TPole2;
    procedure ButtonMVAEClick(Sender: TObject);
    procedure ButtonMVARClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Pole2_10Click(Sender: TObject);
    procedure Pole2_11Click(Sender: TObject);
    procedure Pole2_12Click(Sender: TObject);
    procedure Pole2_13Click(Sender: TObject);
    procedure Pole2_14Click(Sender: TObject);
    procedure Pole2_15Click(Sender: TObject);
    procedure Pole2_16Click(Sender: TObject);
    procedure Pole2_17Click(Sender: TObject);
    procedure Pole2_18Click(Sender: TObject);
    procedure Pole2_19Click(Sender: TObject);
    procedure Pole2_1Click(Sender: TObject);
    procedure Pole2_20Click(Sender: TObject);
    procedure Pole2_21Click(Sender: TObject);
    procedure Pole2_22Click(Sender: TObject);
    procedure Pole2_23Click(Sender: TObject);
    procedure Pole2_24Click(Sender: TObject);
    procedure Pole2_25Click(Sender: TObject);
    procedure Pole2_26Click(Sender: TObject);
    procedure Pole2_27Click(Sender: TObject);
    procedure Pole2_28Click(Sender: TObject);
    procedure Pole2_29Click(Sender: TObject);
    procedure Pole2_2Click(Sender: TObject);
    procedure Pole2_30Click(Sender: TObject);
    procedure Pole2_31Click(Sender: TObject);
    procedure Pole2_32Click(Sender: TObject);
    procedure Pole2_3Click(Sender: TObject);
    procedure Pole2_4Click(Sender: TObject);
    procedure Pole2_5Click(Sender: TObject);
    procedure Pole2_6Click(Sender: TObject);
    procedure Pole2_7Click(Sender: TObject);
    procedure Pole2_8Click(Sender: TObject);
    procedure Pole2_9Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form3: TForm3;

implementation
uses Unit1;

//******* Sprawdzenie czyj ruch i dalsza interakcja *************************
procedure rozpocznijRuchDlaBialego();
begin
     if (not czyKoniecGry) then
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
               czyWybrany := false;
               czyJestBicie := false;
               dezaktywujPionkiBiale();
               SprawdzZwyciezce();
               rozpocznijRuchDlaCzarnego();
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
     rozpocznijRuchDlaBialego();
end;
//*************************************************************************


{$R *.lfm}

{ TForm3 }

procedure TForm3.ButtonMVAEClick(Sender: TObject);
begin
  Form3.Release();
  Form1.Show();
end;

procedure TForm3.ButtonMVARClick(Sender: TObject);
begin
  rezygnuj();
end;

procedure TForm3.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
     Form3.Release();
     Form1.Show();
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
     //showMessage('Przypisuje wstepne wartosci dla pionkow i tablic');
     iloscBialychPionkow := 12;
     iloscCzarnychPionkow := 12;
     iloscPolSz := 32;

     Randomize();

     //Przypisanie czarnych pionków
     bialePionki[1] := Pole2_21;
     bialePionki[2] := Pole2_22;
     bialePionki[3] := Pole2_23;
     bialePionki[4] := Pole2_24;
     bialePionki[5] := Pole2_25;
     bialePionki[6] := Pole2_26;
     bialePionki[7] := Pole2_27;
     bialePionki[8] := Pole2_28;
     bialePionki[9] := Pole2_29;
     bialePionki[10] := Pole2_30;
     bialePionki[11] := Pole2_31;
     bialePionki[12] := Pole2_32;

     //Przypisanie bialych pionków
     czarnePionki[1] := Pole2_1;
     czarnePionki[2] := Pole2_2;
     czarnePionki[3] := Pole2_3;
     czarnePionki[4] := Pole2_4;
     czarnePionki[5] := Pole2_5;
     czarnePionki[6] := Pole2_6;
     czarnePionki[7] := Pole2_7;
     czarnePionki[8] := Pole2_8;
     czarnePionki[9] := Pole2_9;
     czarnePionki[10] := Pole2_10;
     czarnePionki[11] := Pole2_11;
     czarnePionki[12] := Pole2_12;

     //Pzypisanie pol szachownicy
     polaSzachownicy[1] := Pole2_1;
     polaSzachownicy[2] := Pole2_2;
     polaSzachownicy[3] := Pole2_3;
     polaSzachownicy[4] := Pole2_4;
     polaSzachownicy[5] := Pole2_5;
     polaSzachownicy[6] := Pole2_6;
     polaSzachownicy[7] := Pole2_7;
     polaSzachownicy[8] := Pole2_8;
     polaSzachownicy[9] := Pole2_9;
     polaSzachownicy[10] := Pole2_10;
     polaSzachownicy[11] := Pole2_11;
     polaSzachownicy[12] := Pole2_12;
     polaSzachownicy[13] := Pole2_13;
     polaSzachownicy[14] := Pole2_14;
     polaSzachownicy[15] := Pole2_15;
     polaSzachownicy[16] := Pole2_16;
     polaSzachownicy[17] := Pole2_17;
     polaSzachownicy[18] := Pole2_18;
     polaSzachownicy[19] := Pole2_19;
     polaSzachownicy[20] := Pole2_20;
     polaSzachownicy[21] := Pole2_21;
     polaSzachownicy[22] := Pole2_22;
     polaSzachownicy[23] := Pole2_23;
     polaSzachownicy[24] := Pole2_24;
     polaSzachownicy[25] := Pole2_25;
     polaSzachownicy[26] := Pole2_26;
     polaSzachownicy[27] := Pole2_27;
     polaSzachownicy[28] := Pole2_28;
     polaSzachownicy[29] := Pole2_29;
     polaSzachownicy[30] := Pole2_30;
     polaSzachownicy[31] := Pole2_31;
     polaSzachownicy[32] := Pole2_32;

     //Pzypisanie ruchu bialym pionkom
     //czyjRuch := 0;
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

procedure TForm3.Pole2_10Click(Sender: TObject);
begin
  start(Pole2_10);
end;

procedure TForm3.Pole2_11Click(Sender: TObject);
begin
  start(Pole2_11);
end;

procedure TForm3.Pole2_12Click(Sender: TObject);
begin
  start(Pole2_12);
end;

procedure TForm3.Pole2_13Click(Sender: TObject);
begin
  start(Pole2_13);
end;

procedure TForm3.Pole2_14Click(Sender: TObject);
begin
  start(Pole2_14);
end;

procedure TForm3.Pole2_15Click(Sender: TObject);
begin
  start(Pole2_15);
end;

procedure TForm3.Pole2_16Click(Sender: TObject);
begin
  start(Pole2_16);
end;

procedure TForm3.Pole2_17Click(Sender: TObject);
begin
  start(Pole2_17);
end;

procedure TForm3.Pole2_18Click(Sender: TObject);
begin
  start(Pole2_18);
end;

procedure TForm3.Pole2_19Click(Sender: TObject);
begin
  start(Pole2_19);
end;

procedure TForm3.Pole2_1Click(Sender: TObject);
begin
  start(Pole2_1);
end;

procedure TForm3.Pole2_20Click(Sender: TObject);
begin
  start(Pole2_20);
end;

procedure TForm3.Pole2_21Click(Sender: TObject);
begin
  start(Pole2_21);
end;

procedure TForm3.Pole2_22Click(Sender: TObject);
begin
  start(Pole2_22);
end;

procedure TForm3.Pole2_23Click(Sender: TObject);
begin
  start(Pole2_23);
end;

procedure TForm3.Pole2_24Click(Sender: TObject);
begin
  start(Pole2_24);
end;

procedure TForm3.Pole2_25Click(Sender: TObject);
begin
  start(Pole2_25);
end;

procedure TForm3.Pole2_26Click(Sender: TObject);
begin
  start(Pole2_26);
end;

procedure TForm3.Pole2_27Click(Sender: TObject);
begin
  start(Pole2_27);
end;

procedure TForm3.Pole2_28Click(Sender: TObject);
begin
  start(Pole2_28);
end;

procedure TForm3.Pole2_29Click(Sender: TObject);
begin
  start(Pole2_29);
end;

procedure TForm3.Pole2_2Click(Sender: TObject);
begin
  start(Pole2_2);
end;

procedure TForm3.Pole2_30Click(Sender: TObject);
begin
  start(Pole2_30);
end;

procedure TForm3.Pole2_31Click(Sender: TObject);
begin
  start(Pole2_31);
end;

procedure TForm3.Pole2_32Click(Sender: TObject);
begin
  start(Pole2_32);
end;

procedure TForm3.Pole2_3Click(Sender: TObject);
begin
  start(Pole2_3);
end;

procedure TForm3.Pole2_4Click(Sender: TObject);
begin
  start(Pole2_4);
end;

procedure TForm3.Pole2_5Click(Sender: TObject);
begin
  start(Pole2_5);
end;

procedure TForm3.Pole2_6Click(Sender: TObject);
begin
  start(Pole2_6);
end;

procedure TForm3.Pole2_7Click(Sender: TObject);
begin
  start(Pole2_7);
end;

procedure TForm3.Pole2_8Click(Sender: TObject);
begin
  start(Pole2_8);
end;

procedure TForm3.Pole2_9Click(Sender: TObject);
begin
  start(Pole2_9);
end;

end.

