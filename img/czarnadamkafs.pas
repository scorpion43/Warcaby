unit czarnaDamkaFS;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Pole2, CzarnaDamkaFP, globalne, uniwersalne;

procedure wykonajRuchAlboBicie_CD();
procedure SprDalszaMozliwoscBicia_CD();

implementation

//------------- Sprawdzenie dalszej mozliwosc bicia dla czarnej damki
procedure SprDalszaMozliwoscBicia_CD();
begin
     if (SprMozliwoscBicia_CD(wybranePoleDoc)) then
     begin
          dezaktywujPionkiCzarne();
          wybranePoleDoc.Enabled := true;
          pomylka := true;
     end;
end;

//wykonanie bicia bialej damki do dolu na prawo DP
procedure WykonajBicie_CD_DP();
begin
     if (SprMozliwoscWykonaniaBicia_CD_DP()) then
     begin
          ZbijFigury_CD_DP();
          wykonajRuchDlaDamki();
          SprDalszaMozliwoscBicia_CD();
     end
     else
     begin
          pomylka := true;
     end;
end;

//wykonanie bicia czarnej damki do dolu na lewo
procedure WykonajBicie_CD_DL();
begin
     if (SprMozliwoscWykonaniaBicia_CD_DL()) then
     begin
          ZbijFigury_CD_DL();
          wykonajRuchDlaDamki();
          SprDalszaMozliwoscBicia_CD();
     end
     else
     begin
          pomylka := true;
     end;
end;

//wykonanie bicia dla czarnej damki do gory na prawo
procedure WykonajBicie_CD_GP();
begin
     if (SprMozliwoscWykonaniaBicia_CD_GP()) then
     begin
          ZbijFigury_CD_GP();
          wykonajRuchDlaDamki();
          SprDalszaMozliwoscBicia_CD();
     end
     else
     begin
          pomylka := true;
     end;
end;

//wykonanie bicia czarnej damki do gory na lewo
procedure WykonajBicie_CD_GL();
begin
     if (SprMozliwoscWykonaniaBicia_CD_GL()) then
     begin
          ZbijFigury_CD_GL();
          wykonajRuchDlaDamki();
          SprDalszaMozliwoscBicia_CD();
     end
     else
     begin
          pomylka := true;
     end;
end;

procedure RozstrzygnijOpcjeBicia_CD();
var
  odstepR, odstepC : integer;
begin
     odstepR := wybranePoleDoc.MyRow - kliknietePole.MyRow;
     odstepC := wybranePoleDoc.MyColummn - kliknietePole.MyColummn;
     if (odstepR > 0) then
     begin
          if (odstepC > 0) then
          begin
               WykonajBicie_CD_DP();
          end
          else
          begin
               WykonajBicie_CD_DL();
          end;
     end
     else
     begin
          if (odstepC > 0) then
          begin
               WykonajBicie_CD_GP();
          end
          else
          begin
               WykonajBicie_CD_GL();
          end;
     end;
end;

procedure RozstrzygnijOpcjeRuchu_CD();
var
  warunek : boolean;
begin
     warunek := SprMozliowscWykonaniaRuchuDlaDamki();
     if (warunek) then
     begin
          wykonajRuchDlaDamki();
     end
     else
     begin
          pomylka := true;
     end;
end;

procedure wykonajRuchAlboBicie_CD();
begin
     if (not warunekKonRuchuAlboBiciaDlaDamki()) then
     begin
       pomylka := true;
     end
     else
     begin
          if (czyJestBicie) then
          begin
               RozstrzygnijOpcjeBicia_CD();
          end
          else
          begin
               RozstrzygnijOpcjeRuchu_CD();
          end;
     end;
end;

end.


