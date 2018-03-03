unit czarnaDamkaFPAI;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Pole2,
  globalne, globalne2, uniwersalne;

function znajdzOdpowiedniePoleDocelowe_CD() : TPole2;

implementation

//szukanie pola docelowego do góry na lewo
function znajdz_PD_GL() : TPole2;
var
  poleD : TPole2;
  rowD, colummnD : integer;
  row, colummn : integer;
  odstep : integer;
begin
     poleD := nil;
     row := kliknietePole.MyRow - 1;
     colummn := kliknietePole.MyColummn - 1;
     rowD := 1;
     colummnD := 1;
     while ((row > rowD) AND (colummn > colummnD)) do
     begin
          if (not SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)
             AND not SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)) then
          begin
               row := row - 1;
               colummn := colummn - 1;
          end;
     end;
     odstep := kliknietePole.MyRow - row;
     if (odstep > 1) then
     begin
          row := row + 1;
          colummn := colummn + 1;
          poleD := zwrocElementTablicy(polaSzachownicy, iloscPolSz, row, colummn);
     end
     else
     begin
          if (not SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)
             AND not SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)
          ) then
          begin
               poleD := zwrocElementTablicy(polaSzachownicy, iloscPolSz, row, colummn);
          end;
     end;
     znajdz_PD_GL := poleD;
end;

//szukanie pola docelowego do góry na prawo
function znajdz_PD_GP() : TPole2;
var
  poleD : TPole2;
  rowD, colummnD : integer;
  row, colummn : integer;
  odstep : integer;
begin
     poleD := nil;
     row := kliknietePole.MyRow - 1;
     colummn := kliknietePole.MyColummn + 1;
     rowD := 1;
     colummnD := 8;
     while ((row > rowD) AND (colummn < colummnD)) do
     begin
          if (not SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)
             AND not SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)) then
          begin
               row := row - 1;
               colummn := colummn + 1;
          end;
     end;
     odstep := kliknietePole.MyRow - row;
     if (odstep > 1) then
     begin
          row := row + 1;
          colummn := colummn - 1;
          poleD := zwrocElementTablicy(polaSzachownicy, iloscPolSz, row, colummn);
     end
     else
     begin
          if (not SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)
             AND not SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)
          ) then
          begin
               poleD := zwrocElementTablicy(polaSzachownicy, iloscPolSz, row, colummn);
          end;
     end;
     znajdz_PD_GP := poleD;
end;

//szukania pola docelowego do dólu na prawo
function znajdz_PD_DP() : TPole2;
var
  poleD : TPole2;
  rowD, colummnD : integer;
  row, colummn : integer;
  odstep : integer;
begin
     poleD := nil;
     row := kliknietePole.MyRow + 1;
     colummn := kliknietePole.MyColummn + 1;
     rowD := 8;
     colummnD := 8;
     while ((row < rowD) AND (colummn < colummnD)) do
     begin
          if (not SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)
             AND not SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)) then
          begin
               row := row + 1;
               colummn := colummn + 1;
          end;
     end;
     odstep := row - kliknietePole.MyRow;
     if (odstep > 1) then
     begin
          row := row - 1;
          colummn := colummn - 1;
          poleD := zwrocElementTablicy(polaSzachownicy, iloscPolSz, row, colummn);
     end
     else
     begin
          if (not SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)
             AND not SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)
          ) then
          begin
               poleD := zwrocElementTablicy(polaSzachownicy, iloscPolSz, row, colummn);
          end;
     end;
     znajdz_PD_DP := poleD;
end;

//szukanie pola docelowego do dolu na lewo
function znajdz_PD_DL() : TPole2;
var
  poleD : TPole2;
  rowD, colummnD : integer;
  row, colummn : integer;
  odstep : integer;
begin
     poleD := nil;
     row := kliknietePole.MyRow + 1;
     colummn := kliknietePole.MyColummn - 1;
     rowD := 8;
     colummnD := 1;
     while ((row < rowD) AND (colummn > colummnD)) do
     begin
          if (not SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)
             AND not SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)) then
          begin
               row := row + 1;
               colummn := colummn - 1;
          end;
     end;
     odstep := row - kliknietePole.MyRow;
     if (odstep > 1) then
     begin
          row := row - 1;
          colummn := colummn + 1;
          poleD := zwrocElementTablicy(polaSzachownicy, iloscPolSz, row, colummn);
     end
     else
     begin
          if (not SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)
             AND not SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)
          ) then
          begin
               poleD := zwrocElementTablicy(polaSzachownicy, iloscPolSz, row, colummn);
          end;
     end;
     znajdz_PD_DL := poleD;
end;

//znajdowanie pola docelowego opcja 1
function znajdz_PD_OP1_D() : TPole2;
var
  pole : TPole2;
begin
     pole := znajdz_PD_GL();
     if (pole = nil) then
     begin
          pole := znajdz_PD_GP();
          if (pole = nil) then
          begin
              pole := znajdz_PD_DL();
              if (pole = nil) then
              begin
                  pole := znajdz_PD_DP();
              end;
          end;
     end;

     znajdz_PD_OP1_D := pole;
end;

//znajdowanie pola docelowego opcja 2
function znajdz_PD_OP2_D() : TPole2;
var
  pole : TPole2;
begin
     pole := znajdz_PD_GP();
     if (pole = nil) then
     begin
          pole := znajdz_PD_DL();
          if (pole = nil) then
          begin
              pole := znajdz_PD_DP();
              if (pole = nil) then
              begin
                  pole := znajdz_PD_GL();
              end;
          end;
     end;

     znajdz_PD_OP2_D := pole;
end;

//znajdowanie pola docelowego opcja 3
function znajdz_PD_OP3_D() : TPole2;
var
  pole : TPole2;
begin
     pole := znajdz_PD_DL();
     if (pole = nil) then
     begin
          pole := znajdz_PD_DP();
          if (pole = nil) then
          begin
              pole := znajdz_PD_GL();
              if (pole = nil) then
              begin
                  pole := znajdz_PD_GP();
              end;
          end;
     end;

     znajdz_PD_OP3_D := pole;
end;

//znajdowanie pola docelowego opcja 4
function znajdz_PD_OP4_D() : TPole2;
var
  pole : TPole2;
begin
     pole := znajdz_PD_DP();
     if (pole = nil) then
     begin
          pole := znajdz_PD_GL();
          if (pole = nil) then
          begin
              pole := znajdz_PD_GP();
              if (pole = nil) then
              begin
                  pole := znajdz_PD_DL();
              end;
          end;
     end;

     znajdz_PD_OP4_D := pole;
end;

function znajdzOdpowiedniePoleDocelowe_CD() : TPole2;
var
  wariant : integer;
  pole : TPole2;
begin
     Randomize();
     wariant := Random(3) + 1;
     if (wariant = 1) then
     begin
          pole := znajdz_PD_OP1_D();
     end
     else if (wariant = 2) then
     begin
          pole := znajdz_PD_OP2_D();
     end
     else if (wariant = 3) then
     begin
          pole := znajdz_PD_OP3_D();
     end
     else if (wariant = 4) then
     begin
          pole := znajdz_PD_OP4_D();
     end;

     znajdzOdpowiedniePoleDocelowe_CD := pole;
end;

end.



