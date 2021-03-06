unit uniwersalne;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Pole2, globalne;

function SprawdzElementTablicy(var tablica : array of TPole2;Ilosc : Integer; Row : Integer; Colummn : Integer): Boolean;
procedure dezaktywujPionkiCzarne();
procedure dezaktywujPionkiBiale();
procedure zmianaStanuIObrazka(var Pole : TPole2;Stan : String; var sciezka : String);
function zwrocElementTablicy(var tablica : array of TPole2;Ilosc : Integer; Row : Integer; Colummn : Integer): TPole2;
procedure zmienPionekWTablicy(var tablica : array Of TPole2; var ilosc : Integer; var wzor : TPole2; var zamiennik : TPole2);
procedure aktywujPionkiCzarne();
procedure WykasujElementZTablicy(var tablica : array of TPole2; var ilosc : Integer; var wzorzec : TPole2);
procedure SprawdzZwyciezce();

function warunekKonRuchuAlboBiciaDlaDamki() : boolean;
procedure zbijCzarnyElement(element : TPole2);
procedure zbijBialyElement(element : TPole2);
procedure wykonajRuchDlaDamki();

function SprMozliowscWykonaniaRuchuDlaDamki() : boolean;

procedure rezygnuj();

implementation

procedure rezygnuj();
begin
     if (czyjRuch = 0) then
     begin
          showMessage('Czarny Gracz wygyrywa!!!!!!!!!!!!!!!!!!!! Biały gracz zrezygnował z dalszej rogrywki.');
     end
     else
     begin
          showMessage('Biały Gracz wygyrywa!!!!!!!!!!!!!!!!!!!! Czarny gracz zrezygnował z dalszej rogrywki.');
     end;
     czyKoniecGry := true;
end;

procedure SprawdzZwyciezce();
begin
     if (iloscCzarnychPionkow = 0) then
     begin
          showMessage('Biały Gracza Wygrywa!!!!!!!!!!!!!!!!!!! Czarny Gracz stracil wszystkie mozliwe figury!!!!!!!');
          czyKoniecGry := true;
     end
     else
     if (iloscBialychPionkow = 0) then
     begin
          showMessage('Czarny Gracza Wygrywa!!!!!!!!!!!!!!!!!!! Bialy Gracz stracil wszystkie mozliwe figury!!!!!!!');
          czyKoniecGry := true;
     end;
end;

function SprawdzElementTablicy(var tablica : array of TPole2;Ilosc : Integer; Row : Integer; Colummn : Integer): Boolean;
var
  i : integer;
  warunek : boolean;
begin
     warunek := false;
     for i := 1 to Ilosc do
     begin
       if ((tablica[i].MyColummn = Colummn) AND (tablica[i].MyRow = Row)) then
       begin
            warunek := true;
            break;
       end;
     end;
     SprawdzElementTablicy := warunek;
end;

//Dezaktywacja pionkow czarnych
procedure dezaktywujPionkiCzarne();
var
  i : Integer;
begin
     for i := 1 to iloscCzarnychPionkow do
     begin
          czarnePionki[i].Enabled := False;
     end;
end;

//Dezaktywacja pionkow bialych
procedure dezaktywujPionkiBiale();
var
  i : Integer;
begin
     for i := 1 to iloscBialychPionkow do
     begin
       bialePionki[i].Enabled := False;
     end;
end;

//Aktywuj Pionki Czarne
procedure aktywujPionkiCzarne();
var
  i : Integer;
begin
     for i := 1 to iloscCzarnychPionkow do
     begin
       czarnePionki[i].Enabled := True;
     end;
end;

//Aktywacja pionkow bialych
procedure aktywujPionkiBiale();
var
  i : Integer;
begin
     for i := 1 to iloscBialychPionkow do
     begin
       bialePionki[i].Enabled := True;
     end;
end;

//Podmiana stanu i obrazka
procedure zmianaStanuIObrazka(var Pole : TPole2;Stan : String; var sciezka : String);
begin
     Pole.Picture.LoadFromFile(sciezka);
     if (stan <> 'nieRusz') then
     begin
          Pole.MyStan := Stan;
     end;
end;

//zwracanie elementu o podanym rzędzie i kolumnie
function zwrocElementTablicy(var tablica : array of TPole2;Ilosc : Integer; Row : Integer; Colummn : Integer): TPole2;
var
  i : integer;
  warunek : boolean;
begin
     warunek := false;
     for i := 1 to Ilosc do
     begin
       if ((tablica[i].MyColummn = Colummn) AND (tablica[i].MyRow = Row)) then
       begin
            warunek := true;
            break;
       end;
     end;
     if (warunek) then
     begin
          zwrocElementTablicy := tablica[i];
     end
     else
     begin
          zwrocElementTablicy := nil;
     end;
end;

//zmien pionek w tablicy
procedure zmienPionekWTablicy(var tablica : array Of TPole2; var ilosc : Integer; var wzor : TPole2; var zamiennik : TPole2);
var
  i : Integer;
begin
     for i := 1 to ilosc do
     begin
       if (tablica[i] = wzor) then
       begin
            tablica[i] := zamiennik;
            break;
       end;
     end;
end;

//Kasowanie elementu z tablicy
procedure WykasujElementZTablicy(var tablica : array of TPole2; var ilosc : Integer; var wzorzec : TPole2);
var
  i, pozycja : Integer;
begin
     i := 1;
     while (tablica[i] <> wzorzec) do
     begin
          i := i + 1;
     end;

     ilosc := ilosc - 1;
     pozycja := i;

     for i := pozycja to ilosc do
     begin
          tablica[i] := tablica[i + 1];
     end;
end;

//sprawdzenie warunku koniecznego ruchu albo bicia dla damki
function warunekKonRuchuAlboBiciaDlaDamki() : boolean;
var
  odstepR, odstepC : integer;
  warunek : boolean;
begin
     warunek := false;
     odstepR := wybranePoleDoc.MyRow - kliknietePole.MyRow;
     odstepC := wybranePoleDoc.MyColummn - kliknietePole.MyColummn;

     if ((odstepR = odstepC) OR  ((odstepR + odstepC) = 0)) then
     begin
          warunek := true;
     end;
     warunekKonRuchuAlboBiciaDlaDamki := warunek;
end;

//bicie czarnego elementu
procedure zbijCzarnyElement(element : TPole2);
begin
     element.Enabled := true;
     wykasujElementZTablicy(czarnePionki, iloscCzarnychPionkow, element);
     zmianaStanuIObrazka(element, 'PustePole', sciezkaCPole);
end;

//bicie czarnego elementu
procedure zbijBialyElement(element : TPole2);
begin
     element.Enabled := true;
     wykasujElementZTablicy(bialePionki, iloscBialychPionkow, element);
     zmianaStanuIObrazka(element, 'PustePole', sciezkaCPole);
end;

//wykonanie ruchu dla damki
procedure wykonajRuchDlaDamki();
begin
     if (kliknietePole.MyStan = 'BialaDamka') then
     begin
          zmianaStanuIObrazka(wybranePoleDoc, 'BialaDamka', sciezkaBD);
          zmienPionekWTablicy(bialePionki, iloscBialychPionkow, kliknietePole, wybranePoleDoc);
     end
     else
     begin
          zmianaStanuIObrazka(wybranePoleDoc,'CzarnaDamka', sciezkaCD);
          zmienPionekWTablicy(czarnePionki, iloscCzarnychPionkow, kliknietePole, wybranePoleDoc);
     end;
     zmianaStanuIObrazka(kliknietePole, 'PustePole', sciezkaCPole);
end;

//------------------------------ Rozstrzyganie ruchow dla damki ------------------------------------------

//sprawdzenie mozliwosc wykonania ruchu damki do dolu na prawo DP
function SprMozliwoscRuchu_D_DP() : boolean;
var
  row, colummn : integer;
  rowD, colummnD : integer;
  warunek : boolean;
begin
     warunek := true;
     row := kliknietePole.MyRow + 1;
     colummn := wybranePoleDoc.MyColummn + 1;
     rowD := wybranePoleDoc.MyRow;
     colummnD := wybranePoleDoc.MyColummn;

     while ((row < rowD) AND (colummn < colummnD)) do
     begin
          if (SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)
             OR SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)) then
          begin
               warunek := false;
               break;
          end;
          row := row + 1;
          colummn := colummn + 1;
     end;
     SprMozliwoscRuchu_D_DP := warunek;
end;

//sprawdzenie mozliwosc wykonania ruchu damki do dolu na lewo DL
function SprMozliwoscRuchu_D_DL() : boolean;
var
  row, colummn : integer;
  rowD, colummnD : integer;
  warunek : boolean;
begin
     warunek := true;
     row := kliknietePole.MyRow + 1;
     colummn := wybranePoleDoc.MyColummn - 1;
     rowD := wybranePoleDoc.MyRow;
     colummnD := wybranePoleDoc.MyColummn;

     while ((row < rowD) AND (colummn > colummnD)) do
     begin
          if (SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)
             OR SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)) then
          begin
               warunek := false;
               break;
          end;
          row := row + 1;
          colummn := colummn - 1;
     end;
     SprMozliwoscRuchu_D_DL := warunek;
end;

//sprawdzenie mozliwosc wykonania ruchu damki do gory na prawo GP
function SprMozliwoscRuchu_D_GP() : boolean;
var
  row, colummn : integer;
  rowD, colummnD : integer;
  warunek : boolean;
begin
     warunek := true;
     row := kliknietePole.MyRow - 1;
     colummn := wybranePoleDoc.MyColummn + 1;
     rowD := wybranePoleDoc.MyRow;
     colummnD := wybranePoleDoc.MyColummn;

     while ((row > rowD) AND (colummn < colummnD)) do
     begin
          if (SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)
             OR SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)) then
          begin
               warunek := false;
               break;
          end;
          row := row - 1;
          colummn := colummn + 1;
     end;
     SprMozliwoscRuchu_D_GP := warunek;
end;

//sprawdzenie mozliwosc wykonania ruchu damki do gory na prawo DL
function SprMozliwoscRuchu_D_GL() : boolean;
var
  row, colummn : integer;
  rowD, colummnD : integer;
  warunek : boolean;
begin
     warunek := true;
     row := kliknietePole.MyRow - 1;
     colummn := wybranePoleDoc.MyColummn - 1;
     rowD := wybranePoleDoc.MyRow;
     colummnD := wybranePoleDoc.MyColummn;

     while ((row > rowD) AND (colummn > colummnD)) do
     begin
          if (SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)
             OR SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)) then
          begin
               warunek := false;
               break;
          end;
          row := row - 1;
          colummn := colummn - 1;
     end;
     SprMozliwoscRuchu_D_GL := warunek;
end;

function SprMozliowscWykonaniaRuchuDlaDamki() : boolean;
var
  odstepR, odstepC : integer;
  warunek : boolean;
begin
     warunek := false;
     odstepR := wybranePoleDoc.MyRow - kliknietePole.MyRow;
     odstepC := wybranePoleDoc.MyColummn - kliknietePole.MyColummn;
     if (odstepR > 0) then
     begin
          if (odstepC > 0) then
          begin
               warunek := SprMozliwoscRuchu_D_DP();
          end
          else
          begin
               warunek := SprMozliwoscRuchu_D_DL();
          end;
     end
     else
     begin
          if (odstepC > 0) then
          begin
               warunek := SprMozliwoscRuchu_D_GP();
          end
          else
          begin
               warunek := SprMozliwoscRuchu_D_GL();
          end;
     end;
     SprMozliowscWykonaniaRuchuDlaDamki := warunek;
end;

//--------------------------------------------------------------------------------------------------------

end.


