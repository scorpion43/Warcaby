unit czarnyPionekFPAI;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Pole2, czarnyPionekFP, czarnaDamkaFS, czarnaDamkaFP, globalne, globalne2, uniwersalne;

procedure utworzTabliceZPionkamiDoRuchu();
function wylosujElement() : TPole2;
function znajdzOdpowiedniePoleDocelowe_CP() : TPole2;
procedure utworzTabliceZPionkamiDoBicia();

implementation

procedure utworzTabliceZPionkamiDoBicia();
var
  i : integer;
begin
     iloscCzarnychPionkowAI := 0;
     for i := 1 to iloscCzarnychPionkow do
     begin
          if (czarnePionki[i].MyStan = 'CzarnyPionek') then
          begin
               if (SprMozliwoscBiciaDlaCzarnegoPionka(czarnePionki[i])) then
               begin
                  iloscCzarnychPionkowAI := iloscCzarnychPionkowAI + 1;
                  czarnePionkiAI[iloscCzarnychPionkowAI] := czarnePionki[i];
               end;
          end
          else
          begin
               //Sprawdzenie czy jest mozliwosc ruchu dla damki
               if (SprMozliwoscBicia_CD(czarnePionki[i])) then
               begin
                  iloscCzarnychPionkowAI := iloscCzarnychPionkowAI + 1;
                  czarnePionkiAI[iloscCzarnychPionkowAI] := czarnePionki[i];
               end;
          end;
     end;
end;

function znajdzOdpowiedniePoleDocelowe_CP() : TPole2;
var
  element : TPole2;
  row, colummn : integer;
  wariant : integer;
begin
     Randomize();
     wariant := Random(1);
     row := kliknietePole.MyRow + 1;
     if (wariant = 0) then
     begin
          colummn := kliknietePole.MyColummn - 1;
          if (colummn > 0) then
          begin
               if (SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)
               OR SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)) then
               begin
                    colummn := kliknietePole.MyColummn + 1;
               end;
          end
          else
          begin
               colummn := kliknietePole.MyColummn + 1;
          end;
     end
     else
     begin
          colummn := kliknietePole.MyColummn + 1;
          if (colummn < 9) then
          begin
               if (SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)
               OR SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)) then
               begin
                    colummn := kliknietePole.MyColummn - 1;
               end;
          end
          else
          begin
               colummn := kliknietePole.MyColummn - 1;
          end;
     end;


     element := zwrocElementTablicy(polaSzachownicy, iloscPolSz, row, colummn);
     znajdzOdpowiedniePoleDocelowe_CP := element;
end;

function wylosujElement() : TPole2;
var
  element : TPole2;
  indeks : integer;
begin
     Randomize;
     indeks := Random(iloscCzarnychPionkowAI - 1) + 1;

     element := czarnePionkiAI[indeks];

     wylosujElement := element;
end;

procedure utworzTabliceZPionkamiDoRuchu();
var
  i : integer;
begin
     iloscCzarnychPionkowAI := 0;
     for i := 1 to iloscCzarnychPionkow do
     begin
          if (czarnePionki[i].MyStan = 'CzarnyPionek') then
          begin
               if (not SprZastawCP(czarnePionki[i])) then
               begin
                  iloscCzarnychPionkowAI := iloscCzarnychPionkowAI + 1;
                  czarnePionkiAI[iloscCzarnychPionkowAI] := czarnePionki[i];
               end;
          end
          else
          begin
               //Sprawdzenie czy jest mozliwosc ruchu dla damki
               if (not SprZastaw_CD(czarnePionki[i])) then
               begin
                  iloscCzarnychPionkowAI := iloscCzarnychPionkowAI + 1;
                  czarnePionkiAI[iloscCzarnychPionkowAI] := czarnePionki[i];
               end;
          end;
     end;
end;

end.


