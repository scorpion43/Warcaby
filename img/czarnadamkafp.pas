unit czarnaDamkaFP;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Pole2, globalne, uniwersalne;

function SprZastaw_CD(Pole : TPole2) : boolean;
function SprMozliwoscBicia_CD(Pole : TPole2) : boolean;

procedure ZbijFigury_CD_DP();
function SprMozliwoscWykonaniaBicia_CD_DP() : boolean;

function SprMozliwoscWykonaniaBicia_CD_DL() : boolean;
procedure ZbijFigury_CD_DL();

function SprMozliwoscWykonaniaBicia_CD_GP() : boolean;
procedure ZbijFigury_CD_GP();

procedure ZbijFigury_CD_GL();
function SprMozliwoscWykonaniaBicia_CD_GL() : boolean;

function SprZastaw1_CD_DL(Pole : TPole2) : boolean;
function SprZastaw1_CD_DP(Pole : TPole2) : boolean;
function SprZastaw1_CD_GL(Pole : TPole2) : boolean;
function SprZastaw1_CD_GP(Pole : TPole2) : boolean;

function SprMozliwoscBicia_CD_DP(Pole : TPole2) : boolean;
function SprMozliwoscBicia_CD_GL(Pole : TPole2) : boolean;
function SprMozliwoscBicia_CD_DL(Pole : TPole2) : boolean;
function SprMozliwoscBicia_CD_GP(Pole : TPole2) : boolean;

implementation

//---------------- Funkcje sprawdzające możliwosc wykonywania bicia -----------------------------------

//------ Funkcje sprawdzajace mozliwosc wykonywania bicia dla damki DP

procedure ZbijFigury_CD_DP();
var
  row, colummn : integer;
  rowD, colummnD : integer;
  element : TPole2;
begin
     row := kliknietePole.MyRow + 1;
     colummn := kliknietePole.MyColummn + 1;
     rowD := wybranePoleDoc.MyRow;
     colummnD := wybranePoleDoc.MyColummn;

     while ((row < rowD) AND (colummn < colummnD)) do
     begin
          element := zwrocElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          if (element <> nil) then
          begin
               if ((element.MyStan = 'BialyPionek') OR (element.MyStan = 'BialaDamka')) then
               begin
                    zbijBialyElement(element);
               end;
          end;
          row := row + 1;
          colummn := colummn + 1;
     end;
end;

//sprawdzenie czy na lini ruchu jest choć jedna biala figura
function Spr_CF_NaLini_CD_DP(kliknietePole : TPole2; wybranePoleDoc : TPole2) : boolean;
var
   row, colummn : integer;
   rowD, colummnD : integer;
   warunek : boolean;
begin
     row := kliknietePole.MyRow + 1;
     colummn := kliknietePole.MyColummn + 1;
     rowD := wybranePoleDoc.MyRow;
     colummnD := wybranePoleDoc.MyColummn;
     warunek := false;

     while ((row < rowD) AND (colummn < colummnD)) do
     begin
          warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
          if (warunek) then
          begin
               break;
          end;
          row := row + 1;
          colummn := colummn + 1;
     end;
     Spr_CF_NaLini_CD_DP := warunek;
end;

//Sprawdzenie czy na lini bicia bialej damki znajduje się czarna figura
function Spr_BF_NaLini_CD_DP(kliknietePole : TPole2; wybranePoleDoc : TPole2) : boolean;
var
   row, colummn : integer;
   rowD, colummnD : integer;
   warunek : boolean;
begin
     row := kliknietePole.MyRow + 1;
     colummn := kliknietePole.MyColummn + 1;
     rowD := wybranePoleDoc.MyRow;
     colummnD := wybranePoleDoc.MyColummn;
     warunek := false;

     while ((row < rowD) AND (colummn < colummnD)) do
     begin
          warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          if (warunek) then
          begin
               break;
          end;
          row := row + 1;
          colummn := colummn + 1;
     end;
     Spr_BF_NaLini_CD_DP := warunek;
end;

//Sprawdzenie czy na lini są dwie te same figury tego samego rodzaju
function Spr_2BF_NaLini_CD_DP(kliknietePole : TPole2; wybranePoleDoc : TPole2) : boolean;
var
   row, colummn : integer;
   rowD, colummnD : integer;
   warunek, warunekF, warunekF2 : boolean;
begin
     row := kliknietePole.MyRow + 1;
     colummn := kliknietePole.MyColummn + 1;
     rowD := wybranePoleDoc.MyRow;
     colummnD := wybranePoleDoc.MyColummn;
     warunek := false;

     while ((row < rowD) AND (colummn < colummnD)) do
     begin
          warunekF := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          warunekF2 := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row + 1, colummn + 1);
          if (warunekF AND warunekF2) then
          begin
               warunek := true;
               break;
          end;
          row := row + 1;
          colummn := colummn + 1;
     end;
     Spr_2BF_NaLini_CD_DP := warunek;
end;

//sprawdzenie ogolnie mozliwosc wykonania bicia dla damki DP
function SprMozliwoscWykonaniaBicia_CD_DP() : boolean;
var
   warunek : boolean;
begin
     warunek := not Spr_CF_NaLini_CD_DP(kliknietePole, wybranePoleDoc);
     if (warunek) then
     begin
          warunek := Spr_BF_NaLini_CD_DP(kliknietePole, wybranePoleDoc);
          if (warunek) then
          begin
               warunek := not Spr_2BF_NaLini_CD_DP(kliknietePole, wybranePoleDoc);
          end;
     end;

     SprMozliwoscWykonaniaBicia_CD_DP := warunek;
end;

//------ Funkcje sprawdzajace mozliwosc wykonywania bicia dla damki DL

procedure ZbijFigury_CD_DL();
var
  row, colummn : integer;
  rowD, colummnD : integer;
  element : TPole2;
begin
     row := kliknietePole.MyRow + 1;
     colummn := kliknietePole.MyColummn - 1;
     rowD := wybranePoleDoc.MyRow;
     colummnD := wybranePoleDoc.MyColummn;

     while ((row < rowD) AND (colummn > colummnD)) do
     begin
          element := zwrocElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          if (element <> nil) then
          begin
               if ((element.MyStan = 'BialyPionek') OR (element.MyStan = 'BialaDamka')) then
               begin
                    zbijBialyElement(element);
               end;
          end;
          row := row + 1;
          colummn := colummn - 1;
     end;
end;

//sprawdzenie czy na lini ruchu jest choć jedna biala figura
function Spr_CF_NaLini_CD_DL(kliknietePole : TPole2; wybranePoleDoc : TPole2) : boolean;
var
   row, colummn : integer;
   rowD, colummnD : integer;
   warunek : boolean;
begin
     row := kliknietePole.MyRow + 1;
     colummn := kliknietePole.MyColummn - 1;
     rowD := wybranePoleDoc.MyRow;
     colummnD := wybranePoleDoc.MyColummn;
     warunek := false;

     while ((row < rowD) AND (colummn > colummnD)) do
     begin
          warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
          if (warunek) then
          begin
               break;
          end;
          row := row + 1;
          colummn := colummn - 1;
     end;
     Spr_CF_NaLini_CD_DL := warunek;
end;

//Sprawdzenie czy na lini bicia bialej damki znajduje się czarna figura
function Spr_BF_NaLini_CD_DL(kliknietePole : TPole2; wybranePoleDoc : TPole2) : boolean;
var
   row, colummn : integer;
   rowD, colummnD : integer;
   warunek : boolean;
begin
     row := kliknietePole.MyRow + 1;
     colummn := kliknietePole.MyColummn - 1;
     rowD := wybranePoleDoc.MyRow;
     colummnD := wybranePoleDoc.MyColummn;
     warunek := false;

     while ((row < rowD) AND (colummn > colummnD)) do
     begin
          warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          if (warunek) then
          begin
               break;
          end;
          row := row + 1;
          colummn := colummn - 1;
     end;
     Spr_BF_NaLini_CD_DL := warunek;
end;

//Sprawdzenie czy na lini są dwie te same figury tego samego rodzaju
function Spr_2BF_NaLini_CD_DL(kliknietePole : TPole2; wybranePoleDoc : TPole2) : boolean;
var
   row, colummn : integer;
   rowD, colummnD : integer;
   warunek, warunekF, warunekF2 : boolean;
begin
     row := kliknietePole.MyRow + 1;
     colummn := kliknietePole.MyColummn - 1;
     rowD := wybranePoleDoc.MyRow;
     colummnD := wybranePoleDoc.MyColummn;
     warunek := false;

     while ((row < rowD) AND (colummn > colummnD)) do
     begin
          warunekF := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          warunekF2 := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row + 1, colummn - 1);
          if (warunekF AND warunekF2) then
          begin
               warunek := true;
               break;
          end;
          row := row + 1;
          colummn := colummn - 1;
     end;
     Spr_2BF_NaLini_CD_DL := warunek;
end;

//sprawdzenie ogolnie mozliwosc wykonania bicia dla damki DL
function SprMozliwoscWykonaniaBicia_CD_DL() : boolean;
var
   warunek : boolean;
begin
     warunek := not Spr_CF_NaLini_CD_DL(kliknietePole, wybranePoleDoc);
     if (warunek) then
     begin
          warunek := Spr_BF_NaLini_CD_DL(kliknietePole, wybranePoleDoc);
          if (warunek) then
          begin
               warunek := not Spr_2BF_NaLini_CD_DL(kliknietePole, wybranePoleDoc);
          end;
     end;

     SprMozliwoscWykonaniaBicia_CD_DL := warunek;
end;

//------ Funkcje sprawdzajace mozliwosc wykonywania bicia dla damki GP

procedure ZbijFigury_CD_GP();
var
  row, colummn : integer;
  rowD, colummnD : integer;
  element : TPole2;
begin
     row := kliknietePole.MyRow - 1;
     colummn := kliknietePole.MyColummn + 1;
     rowD := wybranePoleDoc.MyRow;
     colummnD := wybranePoleDoc.MyColummn;

     while ((row > rowD) AND (colummn < colummnD)) do
     begin
          element := zwrocElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          if (element <> nil) then
          begin
               if ((element.MyStan = 'BialyPionek') OR (element.MyStan = 'BialaDamka')) then
               begin
                    zbijBialyElement(element);
               end;
          end;
          row := row - 1;
          colummn := colummn + 1;
     end;
end;

//sprawdzenie czy na lini ruchu jest choć jedna biala figura
function Spr_CF_NaLini_CD_GP(kliknietePole : TPole2; wybranePoleDoc : TPole2) : boolean;
var
   row, colummn : integer;
   rowD, colummnD : integer;
   warunek : boolean;
begin
     row := kliknietePole.MyRow - 1;
     colummn := kliknietePole.MyColummn + 1;
     rowD := wybranePoleDoc.MyRow;
     colummnD := wybranePoleDoc.MyColummn;
     warunek := false;

     while ((row > rowD) AND (colummn < colummnD)) do
     begin
          warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
          if (warunek) then
          begin
               break;
          end;
          row := row - 1;
          colummn := colummn + 1;
     end;
     Spr_CF_NaLini_CD_GP := warunek;
end;

//Sprawdzenie czy na lini bicia bialej damki znajduje się czarna figura
function Spr_BF_NaLini_CD_GP(kliknietePole : TPole2; wybranePoleDoc : TPole2) : boolean;
var
   row, colummn : integer;
   rowD, colummnD : integer;
   warunek : boolean;
begin
     row := kliknietePole.MyRow - 1;
     colummn := kliknietePole.MyColummn + 1;
     rowD := wybranePoleDoc.MyRow;
     colummnD := wybranePoleDoc.MyColummn;
     warunek := false;

     while ((row > rowD) AND (colummn < colummnD)) do
     begin
          warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          if (warunek) then
          begin
               break;
          end;
          row := row - 1;
          colummn := colummn + 1;
     end;
     Spr_BF_NaLini_CD_GP := warunek;
end;

//Sprawdzenie czy na lini są dwie te same figury tego samego rodzaju
function Spr_2BF_NaLini_CD_GP(kliknietePole : TPole2; wybranePoleDoc : TPole2) : boolean;
var
   row, colummn : integer;
   rowD, colummnD : integer;
   warunek, warunekF, warunekF2 : boolean;
begin
     row := kliknietePole.MyRow - 1;
     colummn := kliknietePole.MyColummn + 1;
     rowD := wybranePoleDoc.MyRow;
     colummnD := wybranePoleDoc.MyColummn;
     warunek := false;

     while ((row > rowD) AND (colummn < colummnD)) do
     begin
          warunekF := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          warunekF2 := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row - 1, colummn + 1);
          if (warunekF AND warunekF2) then
          begin
               warunek := true;
               break;
          end;
          row := row - 1;
          colummn := colummn + 1;
     end;
     Spr_2BF_NaLini_CD_GP := warunek;
end;

//sprawdzenie ogolnie mozliwosc wykonania bicia dla damki GP
function SprMozliwoscWykonaniaBicia_CD_GP() : boolean;
var
   warunek : boolean;
begin
     warunek := not Spr_CF_NaLini_CD_GP(kliknietePole, wybranePoleDoc);
     if (warunek) then
     begin
          warunek := Spr_BF_NaLini_CD_GP(kliknietePole, wybranePoleDoc);
          if (warunek) then
          begin
               warunek := not Spr_2BF_NaLini_CD_GP(kliknietePole, wybranePoleDoc);
          end;
     end;

     SprMozliwoscWykonaniaBicia_CD_GP := warunek;
end;

//------ Funkcje sprawdzajace mozliwosc wykonywania bicia dla damki GL

procedure ZbijFigury_CD_GL();
var
  row, colummn : integer;
  rowD, colummnD : integer;
  element : TPole2;
begin
     row := kliknietePole.MyRow - 1;
     colummn := kliknietePole.MyColummn - 1;
     rowD := wybranePoleDoc.MyRow;
     colummnD := wybranePoleDoc.MyColummn;

     while ((row > rowD) AND (colummn > colummnD)) do
     begin
          element := zwrocElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          if (element <> nil) then
          begin
               if ((element.MyStan = 'BialyPionek') OR (element.MyStan = 'BialaDamka')) then
               begin
                    zbijBialyElement(element);
               end;
          end;
          row := row - 1;
          colummn := colummn - 1;
     end;
end;

//sprawdzenie czy na lini ruchu jest choć jedna biala figura
function Spr_CF_NaLini_CD_GL(kliknietePole : TPole2; wybranePoleDoc : TPole2) : boolean;
var
   row, colummn : integer;
   rowD, colummnD : integer;
   warunek : boolean;
begin
     row := kliknietePole.MyRow - 1;
     colummn := kliknietePole.MyColummn - 1;
     rowD := wybranePoleDoc.MyRow;
     colummnD := wybranePoleDoc.MyColummn;
     warunek := false;

     while ((row > rowD) AND (colummn > colummnD)) do
     begin
          warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
          if (warunek) then
          begin
               break;
          end;
          row := row - 1;
          colummn := colummn - 1;
     end;
     Spr_CF_NaLini_CD_GL := warunek;
end;

//Sprawdzenie czy na lini bicia bialej damki znajduje się czarna figura
function Spr_BF_NaLini_CD_GL(kliknietePole : TPole2; wybranePoleDoc : TPole2) : boolean;
var
   row, colummn : integer;
   rowD, colummnD : integer;
   warunek : boolean;
begin
     row := kliknietePole.MyRow - 1;
     colummn := kliknietePole.MyColummn - 1;
     rowD := wybranePoleDoc.MyRow;
     colummnD := wybranePoleDoc.MyColummn;
     warunek := false;

     while ((row > rowD) AND (colummn > colummnD)) do
     begin
          warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          if (warunek) then
          begin
               break;
          end;
          row := row - 1;
          colummn := colummn - 1;
     end;
     Spr_BF_NaLini_CD_GL := warunek;
end;

//Sprawdzenie czy na lini są dwie te same figury tego samego rodzaju
function Spr_2BF_NaLini_CD_GL(kliknietePole : TPole2; wybranePoleDoc : TPole2) : boolean;
var
   row, colummn : integer;
   rowD, colummnD : integer;
   warunek, warunekF, warunekF2 : boolean;
begin
     row := kliknietePole.MyRow - 1;
     colummn := kliknietePole.MyColummn - 1;
     rowD := wybranePoleDoc.MyRow;
     colummnD := wybranePoleDoc.MyColummn;
     warunek := false;

     while ((row > rowD) AND (colummn > colummnD)) do
     begin
          warunekF := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          warunekF2 := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row - 1, colummn - 1);
          if (warunekF AND warunekF2) then
          begin
               warunek := true;
               break;
          end;
          row := row - 1;
          colummn := colummn - 1;
     end;
     Spr_2BF_NaLini_CD_GL := warunek;
end;

//sprawdzenie ogolnie mozliwosc wykonania bicia dla damki GL
function SprMozliwoscWykonaniaBicia_CD_GL() : boolean;
var
   warunek : boolean;
begin
     warunek := not Spr_CF_NaLini_CD_GL(kliknietePole, wybranePoleDoc);
     if (warunek) then
     begin
          warunek := Spr_BF_NaLini_CD_GL(kliknietePole, wybranePoleDoc);
          if (warunek) then
          begin
               warunek := not Spr_2BF_NaLini_CD_GL(kliknietePole, wybranePoleDoc);
          end;
     end;

     SprMozliwoscWykonaniaBicia_CD_GL := warunek;
end;

//---------------- Koniec algorytmow sprawdzajacych mozliwosc bicia dla bialego pionka ------------------

//-------------------- Funkcje dotyczace algorytmu sprawdzania bicia DP

//sprawdzenie czy na linie znajduje się jakikolwiek pionek
function SprCzyLiniaJestPusta_CD_DP(Pole : TPole2) : boolean;
var
  row, colummn : integer;
  warunek : boolean;
begin
     row := Pole.MyRow + 1;
     colummn := Pole.MyColummn + 1;
     warunek := true;
     while ((colummn < 8) AND (row < 8)) do
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
     SprCzyLiniaJestPusta_CD_DP := warunek;
end;

//Odnalazenie figury tego samego rodzaju na lini jesli istnieje DP
function Znajdz_CF_CD_NaLini_DP(Pole : TPole2) : TPole2;
var
   row, colummn : integer;
   element : TPole2;
begin
     element := nil;
     row := Pole.MyRow + 1;
     colummn := Pole.MyColummn + 1;
     while ((row < 8) AND (colummn < 8)) do
     begin
          element := zwrocElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
          if (element <> nil) then
          begin
               break;
          end;
          row := row + 1;
          colummn := colummn + 1;
     end;
     Znajdz_CF_CD_NaLini_DP := element;
end;

function SprOdstep_F_CD_DP(PoleCD : TPole2; PoleF : TPole2) : boolean;
var
   odstepR : integer;
   warunek : boolean;
begin
     warunek := true;
     odstepR := PoleF.MyRow - PoleCD.MyRow;
     if (odstepR <= 2) then
     begin
          warunek := false;
     end;
     SprOdstep_F_CD_DP := warunek;
end;

//sprawdzenie czy na lini znajduje się jaki kolwiek bialy pionek  DP
function SprCzyNaLiniJest_BF_CD_DP(Pole : TPole2; konPole : TPole2) : boolean;
var
  row, colummn : integer;
  rowD, colummnD : integer;
  warunek : boolean;
begin
     row := Pole.MyRow + 1;
     colummn := Pole.MyColummn + 1;
     warunek := false;
     if (konPole <> nil) then
     begin
          rowD := konPole.MyRow;
          colummnD := konPole.MyColummn;
     end
     else
     begin
          rowD := 8;
          colummnD := 8;
     end;
     while ((colummn < colummnD) AND (row < rowD)) do
     begin
          if (SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)) then
          begin
               warunek := true;
               break;
          end;
          row := row + 1;
          colummn := colummn + 1;
     end;
     SprCzyNaLiniJest_BF_CD_DP := warunek;
end;

//spradzenie czy na lini sa dwie figury tego samego rodzaju po sobie  DP
//jesli funkcja znajdzie taki element zwraca najblizszy damce
function ZnajdzWSzeregu_2BF_CD_DP(Pole : TPole2; konPole : TPole2) : TPole2;
var
  row, colummn : integer;
  rowD, colummnD : integer;
  element, element2 : boolean;
  bElement : TPole2;
  warunek : boolean;
begin
     bElement := nil;
     row := Pole.MyRow + 1;
     colummn := Pole.MyColummn + 1;
     if (konPole = nil) then
     begin
          rowD := 8;
          colummnD := 8;
     end
     else
     begin
          rowD := konPole.MyRow;
          colummnD := konPole.MyColummn;
     end;
     while ((row < rowD) AND (colummn < colummnD)) do
     begin
          element := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          element2 := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row + 1, colummn + 1);
          if (element AND element2) then
          begin
               bElement := zwrocElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
               break;
          end;
          row := row + 1;
          colummn := colummn + 1;
     end;

     ZnajdzWSzeregu_2BF_CD_DP := bElement;
end;

//sprawdznie czy tuż za bialym pionkiem nie znajduje sie czarny
function Spr_BFCF_CD_DP(Pole : TPole2) : boolean;
var
  row, colummn : integer;
  warunek : boolean;
begin
     row := Pole.MyRow + 1;
     colummn := Pole.MyColummn + 1;
     warunek := false;

     while (not warunek) do
     begin
          warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          row := row + 1;
          colummn := colummn + 1;
     end;

     warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
     Spr_BFCF_CD_DP := warunek;
end;

//funkcja ogólna sprawdzajaca mozliwosc bicia DP
function SprMozliwoscBicia_CD_DP(Pole : TPole2) : boolean;
var
  warunek : boolean;
  konElement : TPole2;
begin
     warunek := false;
     warunek := not SprCzyLiniaJestPusta_CD_DP(Pole);
     if (warunek) then
     begin
          konElement := Znajdz_CF_CD_NaLini_DP(Pole);
          if (konElement <> nil) then
          begin
               warunek := SprOdstep_F_CD_DP(Pole, konElement);
          end;
          if (warunek) then
          begin
               warunek := SprCzyNaLiniJest_BF_CD_DP(Pole, konElement);
               if (warunek) then
               begin
                    warunek := not Spr_BFCF_CD_DP(Pole);
                    if (warunek) then
                    begin
                         konElement := ZnajdzWSzeregu_2BF_CD_DP(Pole, konElement);
                         if (konElement <> nil) then
                         begin
                              warunek := SprOdstep_F_CD_DP(Pole, konElement);
                              if (warunek) then
                              begin
                                   //Sprawdzenie czy na lini jest biala figura
                                   warunek := SprCzyNaLiniJest_BF_CD_DP(Pole, konElement);
                              end;
                         end;
                    end;
               end;
          end;

     end;
     SprMozliwoscBicia_CD_DP := warunek;
end;

//--------------------- Koniec funkcji sprawdzajacych mozliowsc bicia dla Damki DP

//-------------------- Funkcje dotyczace algorytmu sprawdzania bicia GL

//sprawdzenie czy na linie znajduje się jakikolwiek pionek
function SprCzyLiniaJestPusta_CD_GL(Pole : TPole2) : boolean;
var
  row, colummn : integer;
  warunek : boolean;
begin
     row := Pole.MyRow - 1;
     colummn := Pole.MyColummn - 1;
     warunek := true;
     while ((colummn > 1) AND (row > 1)) do
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
     SprCzyLiniaJestPusta_CD_GL := warunek;
end;

//Odnalazenie figury tego samego rodzaju na lini jesli istnieje GL
function Znajdz_CF_CD_NaLini_GL(Pole : TPole2) : TPole2;
var
   row, colummn : integer;
   element : TPole2;
begin
     element := nil;
     row := Pole.MyRow - 1;
     colummn := Pole.MyColummn - 1;
     while ((row > 1) AND (colummn > 1)) do
     begin
          element := zwrocElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
          if (element <> nil) then
          begin
               break;
          end;
          row := row - 1;
          colummn := colummn - 1;
     end;
     Znajdz_CF_CD_NaLini_GL := element;
end;

function SprOdstep_F_CD_GL(PoleCD : TPole2; PoleF : TPole2) : boolean;
var
   odstepR : integer;
   warunek : boolean;
begin
     warunek := true;
     odstepR := PoleCD.MyRow - PoleF.MyRow;
     if (odstepR <= 2) then
     begin
          warunek := false;
     end;
     SprOdstep_F_CD_GL := warunek;
end;

//sprawdzenie czy na lini znajduje się jaki kolwiek bialy pionek  GL
function SprCzyNaLiniJest_BF_CD_GL(Pole : TPole2; konPole : TPole2) : boolean;
var
  row, colummn : integer;
  rowD, colummnD : integer;
  warunek : boolean;
begin
     row := Pole.MyRow - 1;
     colummn := Pole.MyColummn - 1;
     warunek := false;
     if (konPole <> nil) then
     begin
          rowD := konPole.MyRow;
          colummnD := konPole.MyColummn;
     end
     else
     begin
          rowD := 1;
          colummnD := 1;
     end;
     while ((colummn > colummnD) AND (row > rowD)) do
     begin
          if (SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)) then
          begin
               warunek := true;
               break;
          end;
          row := row - 1;
          colummn := colummn - 1;
     end;
     SprCzyNaLiniJest_BF_CD_GL := warunek;
end;

//spradzenie czy na lini sa dwie figury tego samego rodzaju po sobie  GL
//jesli funkcja znajdzie taki element zwraca najblizszy damce
function ZnajdzWSzeregu_2BF_CD_GL(Pole : TPole2; konPole : TPole2) : TPole2;
var
  row, colummn : integer;
  rowD, colummnD : integer;
  element, element2 : boolean;
  bElement : TPole2;
begin
     bElement := nil;
     row := Pole.MyRow - 1;
     colummn := Pole.MyColummn - 1;
     if (konPole = nil) then
     begin
          rowD := 1;
          colummnD := 1;
     end
     else
     begin
          rowD := konPole.MyRow;
          colummnD := konPole.MyColummn;
     end;
     while ((row > rowD) AND (colummn > colummnD)) do
     begin
          element := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          element2 := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row - 1, colummn - 1);
          if (element AND element2) then
          begin
               bElement := zwrocElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
               break;
          end;
          row := row - 1;
          colummn := colummn - 1;
     end;

     ZnajdzWSzeregu_2BF_CD_GL := bElement;
end;

//sprawdznie czy tuż za bialym pionkiem nie znajduje sie czarny
function Spr_BFCF_CD_GL(Pole : TPole2) : boolean;
var
  row, colummn : integer;
  warunek : boolean;
begin
     row := Pole.MyRow - 1;
     colummn := Pole.MyColummn - 1;
     warunek := false;

     while (not warunek) do
     begin
          warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          row := row - 1;
          colummn := colummn - 1;
     end;

     warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
     Spr_BFCF_CD_GL := warunek;
end;

//funkcja ogólna sprawdzajaca mozliwosc bicia GL
function SprMozliwoscBicia_CD_GL(Pole : TPole2) : boolean;
var
  warunek : boolean;
  konElement : TPole2;
begin
     warunek := false;
     warunek := not SprCzyLiniaJestPusta_CD_GL(Pole);
     if (warunek) then
     begin
          konElement := Znajdz_CF_CD_NaLini_GL(Pole);
          if (konElement <> nil) then
          begin
               warunek := SprOdstep_F_CD_GL(Pole, konElement);
          end;
          if (warunek) then
          begin
               warunek := SprCzyNaLiniJest_BF_CD_GL(Pole, konElement);
               if (warunek) then
               begin
                    warunek := not Spr_BFCF_CD_GL(Pole);
                    if (warunek) then
                    begin
                         konElement := ZnajdzWSzeregu_2BF_CD_GL(Pole, konElement);
                         if (konElement <> nil) then
                         begin
                              warunek := SprOdstep_F_CD_GL(Pole, konElement);
                              if (warunek) then
                              begin
                                   //Sprawdzenie czy na lini jest biala figura
                                   warunek := SprCzyNaLiniJest_BF_CD_GL(Pole, konElement);
                              end;
                         end;
                    end;
               end;
          end;

     end;
     SprMozliwoscBicia_CD_GL := warunek;
end;

//--------------------- koniec algorytmu sprawdzającego bicia do dolu na lewo dla czarnego pionka -------------------

//-------------------- Funkcje dotyczace algorytmu sprawdzania bicia DL

//sprawdzenie czy na linie znajduje się jakikolwiek pionek
function SprCzyLiniaJestPusta_CD_DL(Pole : TPole2) : boolean;
var
  row, colummn : integer;
  warunek : boolean;
begin
     row := Pole.MyRow + 1;
     colummn := Pole.MyColummn - 1;
     warunek := true;
     while ((colummn > 1) AND (row < 8)) do
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
     SprCzyLiniaJestPusta_CD_DL := warunek;
end;

//Odnalazenie figury tego samego rodzaju na lini jesli istnieje DL
function Znajdz_CF_CD_NaLini_DL(Pole : TPole2) : TPole2;
var
   row, colummn : integer;
   element : TPole2;
begin
     element := nil;
     row := Pole.MyRow + 1;
     colummn := Pole.MyColummn - 1;
     while ((row < 8) AND (colummn > 1)) do
     begin
          element := zwrocElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
          if (element <> nil) then
          begin
               break;
          end;
          row := row + 1;
          colummn := colummn - 1;
     end;
     Znajdz_CF_CD_NaLini_DL := element;
end;

function SprOdstep_F_CD_DL(PoleCD : TPole2; PoleF : TPole2) : boolean;
var
   odstepR : integer;
   warunek : boolean;
begin
     warunek := true;
     odstepR := PoleF.MyRow - PoleCD.MyRow;
     if (odstepR <= 2) then
     begin
          warunek := false;
     end;
     SprOdstep_F_CD_DL := warunek;
end;

//sprawdzenie czy na lini znajduje się jaki kolwiek bialy pionek  DL
function SprCzyNaLiniJest_BF_CD_DL(Pole : TPole2; konPole : TPole2) : boolean;
var
  row, colummn : integer;
  rowD, colummnD : integer;
  warunek : boolean;
begin
     row := Pole.MyRow + 1;
     colummn := Pole.MyColummn - 1;
     warunek := false;
     if (konPole <> nil) then
     begin
          rowD := konPole.MyRow;
          colummnD := konPole.MyColummn;
     end
     else
     begin
          rowD := 8;
          colummnD := 1;
     end;
     while ((colummn > colummnD) AND (row < rowD)) do
     begin
          if (SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)) then
          begin
               warunek := true;
               break;
          end;
          row := row + 1;
          colummn := colummn - 1;
     end;
     SprCzyNaLiniJest_BF_CD_DL := warunek;
end;

//spradzenie czy na lini sa dwie figury tego samego rodzaju po sobie  DL
//jesli funkcja znajdzie taki element zwraca najblizszy damce
function ZnajdzWSzeregu_2BF_CD_DL(Pole : TPole2; konPole : TPole2) : TPole2;
var
  row, colummn : integer;
  rowD, colummnD : integer;
  element, element2 : boolean;
  bElement : TPole2;
begin
     bElement := nil;
     row := Pole.MyRow + 1;
     colummn := Pole.MyColummn - 1;
     if (konPole = nil) then
     begin
          rowD := 8;
          colummnD := 1;
     end
     else
     begin
          rowD := konPole.MyRow;
          colummnD := konPole.MyColummn;
     end;
     while ((row < rowD) AND (colummn > colummnD)) do
     begin
          element := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          element2 := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row + 1, colummn - 1);
          if (element AND element2) then
          begin
               bElement := zwrocElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
               break;
          end;
          row := row + 1;
          colummn := colummn - 1;
     end;

     ZnajdzWSzeregu_2BF_CD_DL := bElement;
end;

//sprawdznie czy tuż za bialym pionkiem nie znajduje sie czarny
function Spr_BFCF_CD_DL(Pole : TPole2) : boolean;
var
  row, colummn : integer;
  warunek : boolean;
begin
     row := Pole.MyRow + 1;
     colummn := Pole.MyColummn - 1;
     warunek := false;

     while (not warunek) do
     begin
          warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          row := row + 1;
          colummn := colummn - 1;
     end;

     warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
     Spr_BFCF_CD_DL := warunek;
end;

//funkcja ogólna sprawdzajaca mozliwosc bicia DL
function SprMozliwoscBicia_CD_DL(Pole : TPole2) : boolean;
var
  warunek : boolean;
  konElement : TPole2;
begin
     warunek := false;
     warunek := not SprCzyLiniaJestPusta_CD_DL(Pole);
     if (warunek) then
     begin
          konElement := Znajdz_CF_CD_NaLini_DL(Pole);
          if (konElement <> nil) then
          begin
               warunek := SprOdstep_F_CD_DL(Pole, konElement);
          end;
          if (warunek) then
          begin
               warunek := SprCzyNaLiniJest_BF_CD_DL(Pole, konElement);
               if (warunek) then
               begin
                    warunek := not Spr_BFCF_CD_DL(Pole);
                    if (warunek) then
                    begin
                         konElement := ZnajdzWSzeregu_2BF_CD_DL(Pole, konElement);
                         if (konElement <> nil) then
                         begin
                              warunek := SprOdstep_F_CD_DL(Pole, konElement);
                              if (warunek) then
                              begin
                                   //Sprawdzenie czy na lini jest biala figura
                                   warunek := SprCzyNaLiniJest_BF_CD_DL(Pole, konElement);
                              end;
                         end;
                    end;
               end;
          end;

     end;
     SprMozliwoscBicia_CD_DL := warunek;
end;

//--------------------- koniec algorytmu sprawdzającego bicia do dolu na lewo dla czarnego pionka -------------------

//-------------------- Funkcje dotyczace algorytmu sprawdzania bicia GP --------------------------------

//sprawdzenie czy na linie znajduje się jakikolwiek pionek
function SprCzyLiniaJestPusta_CD_GP(Pole : TPole2) : boolean;
var
  row, colummn : integer;
  warunek : boolean;
begin
     row := Pole.MyRow - 1;
     colummn := Pole.MyColummn + 1;
     warunek := true;
     while ((colummn < 8) AND (row > 1 )) do
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
     SprCzyLiniaJestPusta_CD_GP := warunek;
end;

//Odnalazenie figury tego samego rodzaju na lini jesli istnieje GP
function Znajdz_CF_CD_NaLini_GP(Pole : TPole2) : TPole2;
var
   row, colummn : integer;
   element : TPole2;
begin
     element := nil;
     row := Pole.MyRow - 1;
     colummn := Pole.MyColummn + 1;
     while ((row > 1) AND (colummn < 8)) do
     begin
          element := zwrocElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
          if (element <> nil) then
          begin
               break;
          end;
          row := row - 1;
          colummn := colummn + 1;
     end;
     Znajdz_CF_CD_NaLini_GP := element;
end;

function SprOdstep_F_CD_GP(PoleCD : TPole2; PoleF : TPole2) : boolean;
var
   odstepR : integer;
   warunek : boolean;
begin
     warunek := true;
     odstepR := PoleCD.MyRow - PoleF.MyRow;
     if (odstepR <= 2) then
     begin
          warunek := false;
     end;
     SprOdstep_F_CD_GP := warunek;
end;

//sprawdzenie czy na lini znajduje się jaki kolwiek bialy pionek  GP
function SprCzyNaLiniJest_BF_CD_GP(Pole : TPole2; konPole : TPole2) : boolean;
var
  row, colummn : integer;
  rowD, colummnD : integer;
  warunek : boolean;
begin
     row := Pole.MyRow - 1;
     colummn := Pole.MyColummn + 1;
     warunek := false;
     if (konPole <> nil) then
     begin
          rowD := konPole.MyRow;
          colummnD := konPole.MyColummn;
     end
     else
     begin
          rowD := 1;
          colummnD := 8;
     end;
     while ((colummn < colummnD) AND (row > rowD)) do
     begin
          if (SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)) then
          begin
               warunek := true;
               break;
          end;
          row := row - 1;
          colummn := colummn + 1;
     end;
     SprCzyNaLiniJest_BF_CD_GP := warunek;
end;

//spradzenie czy na lini sa dwie figury tego samego rodzaju po sobie  GP
//jesli funkcja znajdzie taki element zwraca najblizszy damce
function ZnajdzWSzeregu_2BF_CD_GP(Pole : TPole2; konPole : TPole2) : TPole2;
var
  row, colummn : integer;
  rowD, colummnD : integer;
  element, element2 : boolean;
  bElement : TPole2;
begin
     bElement := nil;
     row := Pole.MyRow - 1;
     colummn := Pole.MyColummn + 1;
     if (konPole = nil) then
     begin
          rowD := 1;
          colummnD := 8;
     end
     else
     begin
          rowD := konPole.MyRow;
          colummnD := konPole.MyColummn;
     end;
     while ((row > rowD) AND (colummn < colummnD)) do
     begin
          element := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          element2 := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row - 1, colummn + 1);
          if (element AND element2) then
          begin
               bElement := zwrocElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
               break;
          end;
          row := row - 1;
          colummn := colummn + 1;
     end;

     ZnajdzWSzeregu_2BF_CD_GP := bElement;
end;

//sprawdznie czy tuż za bialym pionkiem nie znajduje sie czarny
function Spr_BFCF_CD_GP(Pole : TPole2) : boolean;
var
  row, colummn : integer;
  warunek : boolean;
begin
     row := Pole.MyRow - 1;
     colummn := Pole.MyColummn + 1;
     warunek := false;

     while (not warunek) do
     begin
          warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          row := row - 1;
          colummn := colummn + 1;
     end;

     warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
     Spr_BFCF_CD_GP := warunek;
end;

//funkcja ogólna sprawdzajaca mozliwosc bicia DL
function SprMozliwoscBicia_CD_GP(Pole : TPole2) : boolean;
var
  warunek : boolean;
  konElement : TPole2;
begin
     warunek := false;
     warunek := not SprCzyLiniaJestPusta_CD_GP(Pole);
     if (warunek) then
     begin
          konElement := Znajdz_CF_CD_NaLini_GP(Pole);
          if (konElement <> nil) then
          begin
               warunek := SprOdstep_F_CD_GP(Pole, konElement);
          end;
          if (warunek) then
          begin
               warunek := SprCzyNaLiniJest_BF_CD_GP(Pole, konElement);
               if (warunek) then
               begin
                    warunek := not Spr_BFCF_CD_GP(Pole);
                    if (warunek) then
                    begin
                         konElement := ZnajdzWSzeregu_2BF_CD_GP(Pole, konElement);
                         if (konElement <> nil) then
                         begin
                              warunek := SprOdstep_F_CD_GP(Pole, konElement);
                              if (warunek) then
                              begin
                                   //Sprawdzenie czy na lini jest biala figura
                                   warunek := SprCzyNaLiniJest_BF_CD_GP(Pole, konElement);
                              end;
                         end;
                    end;
               end;
          end;

     end;
     SprMozliwoscBicia_CD_GP := warunek;
end;

//--------------------- koniec algorytmu sprawdzającego bicia do dolu na lewo dla czarnego pionka -

//---------- ogolne sprawdzenie dla damki czy jest dla niej możliowosc bicia

function SprMozliwoscBicia_CD(Pole : TPole2) : boolean;
var
  warunek : boolean;
begin
     warunek := SprMozliwoscBicia_CD_DP(Pole);
     if (not warunek) then
     begin
          warunek := SprMozliwoscBicia_CD_DL(Pole);
          if (not warunek) then
          begin
               warunek := SprMozliwoscBicia_CD_GL(Pole);
               if (not warunek) then
               begin
                    warunek := SprMozliwoscBicia_CD_GP(Pole);
               end;
          end;
     end;

     SprMozliwoscBicia_CD := warunek;
end;

//------------------

//--------------------- Funkcje dotyczące sprawdzania zastawienia

//sprawdzenie zastawienia damki do góry na lewo (badane jedno pole)
function SprZastaw1_CD_GL(Pole : TPole2) : boolean;
var
  row, colummn : integer;
  warunek : boolean;
begin
     row := Pole.MyRow - 1;
     colummn := Pole.MyColummn - 1;
     warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
     if (not warunek) then
     begin
          warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
     end;
     SprZastaw1_CD_GL := warunek;
end;

//sprawdzenie zastawienia damki do gory na prawo (badane jedno pole)
function SprZastaw1_CD_GP(Pole : TPole2) : boolean;
var
  row, colummn : integer;
  warunek : boolean;
begin
     row := Pole.MyRow - 1;
     colummn := Pole.MyColummn + 1;
     warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
     if (not warunek) then
     begin
          warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
     end;

     SprZastaw1_CD_GP := warunek;
end;

//sprawdzenie zastawienia damki do dolu na prawo (badane jedno pole)
function SprZastaw1_CD_DP(Pole : TPole2) : boolean;
var
  row, colummn : integer;
  warunek : boolean;
begin
     row := Pole.MyRow + 1;
     colummn := Pole.MyColummn + 1;
     warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
     if (not warunek) then
     begin
          warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
     end;

     SprZastaw1_CD_DP := warunek;
end;

//sprawdzenie zastawienia damki do dolu na lewo (badane jedno pole)
function SprZastaw1_CD_DL(Pole : TPole2) : boolean;
var
  row, colummn : integer;
  warunek : boolean;
begin
     row := Pole.MyRow + 1;
     colummn := Pole.MyColummn - 1;
     warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
     if (not warunek) then
     begin
          warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
     end;

     SprZastaw1_CD_DL := warunek;
end;

//---------------- badanie warunkow 2 pol ------------------------------

//sprawdznie czy damka jest zastawiona gora lewo (badanie 2 pol)
function SprZastaw2_CD_GL(Pole : TPole2) : boolean;
var
  row, colummn : integer;
  warunek : boolean;
begin
     row := Pole.MyRow - 1;
     colummn := Pole.MyColummn - 1;
     warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
     if (not warunek) then
     begin
          warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          if (warunek) then
          begin
               row := row - 1;
               colummn := colummn - 1;
               warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          end;
     end;

     SprZastaw2_CD_GL := warunek;
end;

//sprawdznie czy damka jest zastawiona gora prawo (badanie 2 pol)
function SprZastaw2_CD_GP(Pole : TPole2) : boolean;
var
  row, colummn : integer;
  warunek : boolean;
begin
     row := Pole.MyRow - 1;
     colummn := Pole.MyColummn + 1;
     warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
     if (not warunek) then
     begin
          warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          if (warunek) then
          begin
               row := row - 1;
               colummn := colummn + 1;
               warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          end;
     end;

     SprZastaw2_CD_GP := warunek;
end;

//sprawdznie czy damka jest zastawiona dol prawo (badanie 2 pol)
function SprZastaw2_CD_DP(Pole : TPole2) : boolean;
var
  row, colummn : integer;
  warunek : boolean;
begin
     row := Pole.MyRow + 1;
     colummn := Pole.MyColummn + 1;
     warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
     if (not warunek) then
     begin
          warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          if (warunek) then
          begin
               row := row + 1;
               colummn := colummn + 1;
               warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          end;
     end;

     SprZastaw2_CD_DP := warunek;
end;

//sprawdznie czy damka jest zastawiona dol lewo (badanie 2 pol)
function SprZastaw2_CD_DL(Pole : TPole2) : boolean;
var
  row, colummn : integer;
  warunek : boolean;
begin
     row := Pole.MyRow + 1;
     colummn := Pole.MyColummn - 1;
     warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
     if (not warunek) then
     begin
          warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          if (warunek) then
          begin
               row := row + 1;
               colummn := colummn - 1;
               warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          end;
     end;

     SprZastaw2_CD_DL := warunek;
end;

//funkcja sprawdza zastawienie dla damki z 1 rzedu
function SprZastaw_CD_R1(Pole : TPole2) : boolean;
var
  colummn : integer;
  warunek : boolean;
begin
     colummn := Pole.MyColummn;
     warunek := false;

     if (colummn = 1) then
     begin
          warunek := SprZastaw2_CD_DP(Pole);
     end
     else if (colummn = 7) then
     begin
          warunek := SprZastaw2_CD_DL(Pole);
          if (warunek) then
          begin
               warunek := SprZastaw1_CD_DP(Pole);
          end;
     end
     else
     begin
          warunek := SprZastaw2_CD_DL(Pole);
          if (warunek) then
          begin
               warunek := SprZastaw2_CD_DP(Pole);
          end;
     end;

     SprZastaw_CD_R1 := warunek;
end;

//sprawdzenie czy dammka z rzedu 2 jest zastawiona
function SprZastaw_CD_R2(Pole : TPole2) : boolean;
var
  row, colummn : integer;
  warunek : boolean;
begin
     row := 2;
     colummn := Pole.MyColummn;
     if (colummn = 2) then
     begin
          warunek := SprZastaw1_CD_GL(Pole);
          if (warunek) then
          begin
               warunek := SprZastaw1_CD_GP(Pole);
               if (warunek) then
               begin
                    warunek := SprZastaw2_CD_DP(Pole);
                    if (warunek) then
                    begin
                         warunek := SprZastaw1_CD_DL(Pole);
                    end;
               end;
          end;
     end
     else if (colummn = 8) then
     begin
          warunek := SprZastaw1_CD_GL(Pole);
          if (warunek) then
          begin
               warunek := SprZastaw2_CD_DL(Pole);
          end;
     end
     else
     begin
     warunek := SprZastaw1_CD_GL(Pole);
     if (warunek) then
     begin
          warunek := SprZastaw1_CD_GP(Pole);
          if (warunek) then
          begin
               warunek := SprZastaw2_CD_DP(Pole);
               if (warunek) then
               begin
                    warunek := SprZastaw2_CD_DL(Pole);
               end;
          end;
     end;
     end;
     SprZastaw_CD_R2 := warunek;
end;

//funkcja ktora sprawdza zastawienie damki z rzędu 7
function SprZastaw_CD_R7(Pole : TPole2) : boolean;
var
  row, colummn : integer;
  warunek : boolean;
begin
     row := 7;
     colummn := Pole.MyColummn;
     warunek := false;
     if (colummn = 1) then
     begin
          warunek := SprZastaw2_CD_GP(Pole);
          if (warunek) then
          begin
               warunek := SprZastaw1_CD_DP(Pole)
          end;
     end
     else if (colummn = 7) then
     begin
          warunek := SprZastaw2_CD_GL(Pole);
          if (warunek) then
          begin
               warunek := SprZastaw1_CD_GP(Pole);
               if (warunek) then
               begin
                    warunek := SprZastaw1_CD_DP(Pole);
                    if (warunek) then
                    begin
                         warunek := SprZastaw1_CD_GL(Pole);
                    end;
               end;
          end;
     end
     else
     begin
          warunek := SprZastaw2_CD_GL(Pole);
          if (warunek) then
          begin
               warunek := SprZastaw2_CD_GP(Pole);
               if (warunek) then
               begin
                    warunek := SprZastaw1_CD_DP(Pole);
                    if (warunek) then
                    begin
                         warunek := SprZastaw1_CD_DL(Pole);
                    end;
               end;
          end;
     end;

     SprZastaw_CD_R7 := warunek;
end;

//sprawdzenie czy damka z rzedu 8 jest zastawiona
function SprZastaw_CD_R8(Pole : TPole2) : boolean;
var
  row, colummn : integer;
  warunek : boolean;
begin
     row := 8;
     colummn := Pole.MyColummn;
     if (colummn = 2) then
     begin
          warunek := SprZastaw1_CD_GL(Pole);
          if (warunek) then
          begin
               warunek := SprZastaw2_CD_GP(Pole);
          end;
     end
     else if (colummn = 8) then
     begin
          warunek := SprZastaw2_CD_GL(Pole)
     end
     else
     begin
          warunek := SprZastaw2_CD_GL(Pole);
          if (warunek) then
          begin
               warunek := SprZastaw2_CD_GP(Pole)
          end;
     end;

     SprZastaw_CD_R8 := warunek;
end;

//sprawdzenie damki z kolummny 1 czy jest zastawiona
function SprZastaw_CD_C1(Pole : TPole2) : boolean;
var
  warunek : boolean;
begin
     warunek := SprZastaw2_CD_GP(Pole);
     if (warunek) then
     begin
          warunek := SprZastaw2_CD_DP(Pole);
     end;
     SprZastaw_CD_C1 := warunek;
end;

//sprawdzenie czy damka badaca w 2 kolummnie jest zastawion
function SprZastaw_CD_C2(Pole : TPole2): boolean;
var
  warunek : boolean;
begin
     warunek := SprZastaw1_CD_GL(Pole);
     if (warunek) then
     begin
         warunek := SprZastaw2_CD_GP(Pole);
         if (warunek) then
         begin
             warunek := SprZastaw2_CD_DP(Pole);
             if (warunek) then
             begin
                 warunek := SprZastaw1_CD_DL(Pole);
             end;
         end;
     end;
     SprZastaw_CD_C2 := warunek;
end;

//Sprawdzenie czy damka z kolummny 7 jest zastawiona
function SprZastaw_CD_C7(Pole : TPole2): boolean;
var
  warunek : boolean;
begin
     warunek := SprZastaw2_CD_GL(Pole);
     if (warunek) then
     begin
         warunek := SprZastaw1_CD_GP(Pole);
         if (warunek) then
         begin
             warunek := SprZastaw1_CD_DP(Pole);
             if (warunek) then
             begin
                 warunek := SprZastaw2_CD_DL(Pole);
             end;
         end;
     end;
     SprZastaw_CD_C7 := warunek;
end;

//funkcja ktora sprawdza czy damka z kolummny 8 jest zastawiona przez inne figury
function SprZastaw_CD_C8(Pole : TPole2) : boolean;
var
  warunek : boolean;
begin
     warunek := SprZastaw2_CD_GL(Pole);
     if (warunek) then
     begin
         warunek := SprZastaw2_CD_GP(Pole);
     end;
     SprZastaw_CD_C8 := warunek;
end;

//sprawdzenie czy damka jest zastawiona w innych przypadkach
function SprZastaw_CD_IP(Pole : TPole2) : boolean;
var
  warunek : boolean;
begin
     warunek := SprZastaw2_CD_GL(Pole);
     if (warunek) then
     begin
         warunek := SprZastaw2_CD_GP(Pole);
         if (warunek) then
         begin
             warunek := SprZastaw2_CD_DP(Pole);
             if (warunek) then
             begin
                 warunek := SprZastaw2_CD_DL(Pole);
             end;
         end;
     end;
     SprZastaw_CD_IP := warunek;
end;

//funkcja ogolna ktora sprawdza czy damka jest zastowiona przez inne pionki
function SprZastaw_CD(Pole : TPole2) : boolean;
var
  row, colummn : integer;
  warunek : boolean;
begin
     row := Pole.MyRow;
     colummn := Pole.MyColummn;
     warunek := false;

     if (row = 1) then
     begin
          warunek := SprZastaw_CD_R1(Pole);
     end
     else if (row = 2) then
     begin
          warunek := SprZastaw_CD_R2(Pole);
     end
     else if (row = 7) then
     begin
          warunek := SprZastaw_CD_R7(Pole);
     end
     else if (row = 8) then
     begin
          warunek := SprZastaw_CD_R8(Pole)
     end
     else if (colummn = 1) then
     begin
          warunek := SprZastaw_CD_C1(Pole);
     end
     else if (colummn = 2) then
     begin
          warunek := SprZastaw_CD_C2(Pole);
     end
     else if (colummn = 7) then
     begin
          warunek := SprZastaw_CD_C7(Pole);
     end
     else if (colummn = 8) then
     begin
         warunek := SprZastaw_CD_C8(Pole);
     end
     else
     begin
          warunek := SprZastaw_CD_IP(Pole);
     end;

     SprZastaw_CD := warunek;
end;

end.


