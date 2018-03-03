unit czarnaDamkaFSAI;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Pole2, bialyPionekFP, czarnyPionekFS,czarnyPionekFP, czarnaDamkaFP ,czarnyPionekFPAI, czarnaDamkaFS,
  globalne, czarnaDamkaFPAI, uniwersalne;

procedure przemiesc_CD();
procedure wybierzPoleDocelowe_B_CD();

implementation

//wykonanie bicia dla damki do dolu na prawo
procedure wykonajBicie_CD_DP();
var
  row, colummn : integer;
  wzorzecDoBicia : TPole2;
  czyJestBialaFigura : boolean;
begin
     row := kliknietePole.MyRow + 1;
     colummn := kliknietePole.MyColummn + 1;
     czyJestBialaFigura := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);

     while (not czyJestBialaFigura) do
     begin
          row := row + 1;
          colummn := colummn + 1;
          czyJestBialaFigura := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
     end;

     wzorzecDoBicia := zwrocElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
     wybranePoleDoc := zwrocElementTablicy(polaSzachownicy, iloscPolSz, row + 1, colummn + 1);
     zbijBialyElement(wzorzecDoBicia);
     wykonajRuchDlaDamki();
     kliknietePole.Enabled := true;
     wybranePoleDoc.Enabled := false;
     kliknietePole := wybranePoleDoc;
end;

//wykonanie bicia dla damki do dolu na lewo
procedure wykonajBicie_CD_DL();
var
  row, colummn : integer;
  wzorzecDoBicia : TPole2;
  czyJestBialaFigura : boolean;
begin
     row := kliknietePole.MyRow + 1;
     colummn := kliknietePole.MyColummn - 1;
     czyJestBialaFigura := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);

     while (not czyJestBialaFigura) do
     begin
          row := row + 1;
          colummn := colummn - 1;
          czyJestBialaFigura := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
     end;

     wzorzecDoBicia := zwrocElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
     wybranePoleDoc := zwrocElementTablicy(polaSzachownicy, iloscPolSz, row + 1, colummn - 1);
     zbijBialyElement(wzorzecDoBicia);
     wykonajRuchDlaDamki();
     kliknietePole.Enabled := true;
     wybranePoleDoc.Enabled := false;
     kliknietePole := wybranePoleDoc;
end;

//wykonanie bicia dla damki do gory na prawo
procedure wykonajBicie_CD_GP();
var
  row, colummn : integer;
  wzorzecDoBicia : TPole2;
  czyJestBialaFigura : boolean;
begin
     row := kliknietePole.MyRow - 1;
     colummn := kliknietePole.MyColummn + 1;
     czyJestBialaFigura := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);

     while (not czyJestBialaFigura) do
     begin
          row := row - 1;
          colummn := colummn + 1;
          czyJestBialaFigura := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
     end;

     wzorzecDoBicia := zwrocElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
     wybranePoleDoc := zwrocElementTablicy(polaSzachownicy, iloscPolSz, row - 1, colummn + 1);
     zbijBialyElement(wzorzecDoBicia);
     wykonajRuchDlaDamki();
     kliknietePole.Enabled := true;
     wybranePoleDoc.Enabled := false;
     kliknietePole := wybranePoleDoc;
end;

//wykonanie bicia dla damki do gory na lewwo
procedure wykonajBicie_CD_GL();
var
  row, colummn : integer;
  wzorzecDoBicia : TPole2;
  czyJestBialaFigura : boolean;
begin
     row := kliknietePole.MyRow - 1;
     colummn := kliknietePole.MyColummn - 1;
     czyJestBialaFigura := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);

     while (not czyJestBialaFigura) do
     begin
          row := row - 1;
          colummn := colummn - 1;
          czyJestBialaFigura := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
     end;

     wzorzecDoBicia := zwrocElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
     wybranePoleDoc := zwrocElementTablicy(polaSzachownicy, iloscPolSz, row - 1, colummn - 1);
     zbijBialyElement(wzorzecDoBicia);
     wykonajRuchDlaDamki();
     kliknietePole.Enabled := true;
     wybranePoleDoc.Enabled := false;
     kliknietePole := wybranePoleDoc;
end;

//rozystrzygnięcię w która stronę bić jesli chodzi o damke
procedure wybierzPoleDocelowe_B_CD();
var
  czyBicie : boolean;
begin
     czyBicie := true;
     while (czyBicie) do
     begin
          if (SprMozliwoscBicia_CD_DP(kliknietePole)) then
          begin
               wykonajBicie_CD_DP();
          end
          else if (SprMozliwoscBicia_CD_DL(kliknietePole)) then
          begin
               wykonajBicie_CD_DL();
          end
          else if (SprMozliwoscBicia_CD_GP(kliknietePole)) then
          begin
               wykonajBicie_CD_GP();
          end
          else if (SprMozliwoscBicia_CD_GL(kliknietePole)) then
          begin
               wykonajBicie_CD_GL();
          end
          else
          begin
               czyBicie := false;
          end;
     end;
end;

procedure przemiesc_CD();
begin
     wybranePoleDoc := znajdzOdpowiedniePoleDocelowe_CD;
     kliknietePole.Enabled := True;
     wykonajRuchDlaDamki();
end;

end.

