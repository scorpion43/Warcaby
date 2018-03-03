unit czarnyPionekFP;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Pole2, CzarnaDamkaFP, globalne, uniwersalne;


function sprMozliwoscBiciaDlaCzarnegoPionka(var Pole : TPole2) : Boolean;
function SprCzyJestMozliwoscBiciaDlaCzarnego() : boolean;
procedure AktywujCzarneFiguryZMozliwosciaRuchu();
procedure AkwtywujOdpowiednieFiguryDlaCzarnego();
procedure sprIZmienObrazekDamkaLubPionekC();

function SprMozliwoscRuchuCP() : boolean;

function SprZastawCP(Pole : TPole2): Boolean;
function SprMozliwoscBiciaCP(): boolean;

function SprawdzCzyJestMozliwoscRuchuDlaCzarnego() : Boolean;

function SprBicieCP_DL(var Pionek : TPole2) : Boolean;
function SprBicieCP_DP(var Pionek : TPole2) : Boolean;
function SprBicieCP_GL(var Pionek : TPole2) : Boolean;
function SprBicieCP_GP(var Pionek : TPole2) : Boolean;


implementation

//procedure zmieniająca obrazki na odpowiednie, kiedy nastapi wybranie figury z tej samej drużyny
procedure sprIZmienObrazekDamkaLubPionekC();
begin
     if (kliknietePole.MyStan = 'CzarnaDamka') then
     begin
          zmianaStanuIObrazka(kliknietePole, 'nieRusz', sciezkaCD);
     end
     else if (kliknietePole.MyStan = 'CzarnyPionek') then
     begin
          zmianaStanuIObrazka(kliknietePole, 'nieRusz', sciezkaCP);
     end;

     if (wybranePoleDoc.MyStan = 'CzarnaDamka') then
     begin
          zmianaStanuIObrazka(wybranePoleDoc, 'nieRusz', sciezkaCDZ);
     end
     else if (wybranePoleDoc.MyStan = 'CzarnyPionek') then
     begin
          zmianaStanuIObrazka(wybranePoleDoc, 'nieRusz', sciezkaCPZ);
     end;
end;

//------- Funkcje zwiazane z biciem i aktywacja pionkow bijacych ----------------------------------------------

//sprawdza czy gracz moze wykonac zamierzony ruch
function SprMozliwoscRuchuCP() : boolean;
var
   odstepC, odstepR : integer;
   warunek : boolean;
begin
     warunek := false;
     odstepR := kliknietePole.MyRow - wybranePoleDoc.MyRow;
     odstepC := kliknietePole.MyColummn - wybranePoleDoc.MyColummn;
     if (odstepR  = (-1)) then
     begin
          if ((odstepC = 1) OR (odstepC = (-1))) then
          begin
               warunek := true;
          end;
     end ;
     SprMozliwoscRuchuCP := warunek;
end;

//sprawdza czy gracz moze wykonac takie bicie jakie chce wykonac
function SprMozliwoscBiciaCP(): boolean;
var
   odstepR, odstepC : integer;
   row, colummn : integer;
   warunek : boolean;
begin
     warunek := true;
     odstepR := kliknietePole.MyRow - wybranePoleDoc.MyRow;
     odstepC := kliknietePole.MyColummn - wybranePoleDoc.MyColummn;
     row := kliknietePole.MyRow;
     colummn := kliknietePole.MyColummn;

     if (odstepR = 2) then
     begin
          row := row - 1;
     end
     else
     if (odstepR = -2) then
     begin
          row := row + 1;
     end
     else
     begin
          warunek := false;
     end;

     if (warunek) then
     begin
          if (odstepC = 2) then
          begin
               colummn := colummn - 1;
          end
          else
          if (odstepC = -2) then
          begin
               colummn := colummn + 1;
          end
          else
          begin
               warunek := false;
          end;
          if (warunek) then
          begin
              warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          end;
     end;

     SprMozliwoscBiciaCP := warunek;
end;

//Sprawdzenie bicia dla czarnego pionka do gory na prawo
function SprBicieCP_GP(var Pionek : TPole2) : Boolean;
var
  row, colummn : Integer;
  warunek : Boolean;
begin
     row := Pionek.MyRow;
     colummn := Pionek.MyColummn;
     warunek := false;
     if (row >= 3) then
     begin
          if (colummn <= 6) then
          begin
               row := row - 1;
               colummn := colummn + 1;
               if (SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)) then
               begin
                    row := row - 1;
                    colummn := colummn + 1;
                    if (not SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)) then
                    begin
                         if (not SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)) then
                         begin
                              warunek := true;
                         end;
                    end;
               end;
          end;
     end;
     SprBicieCP_GP := warunek;
end;

//Sprawdzenie bicia do góry na lewo dla czarnego pionka
function SprBicieCP_GL(var Pionek : TPole2) : Boolean;
var
  row, colummn : Integer;
  warunek : Boolean;
begin
     row := Pionek.MyRow;
     colummn := Pionek.MyColummn;
     warunek := false;
     if (row >= 3) then
     begin
          if (colummn >= 3) then
          begin
               row := row - 1;
               colummn := colummn - 1;
               if (sprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)) then
               begin
                    row := row - 1;
                    colummn := colummn - 1;
                    if (not sprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)) then
                    begin
                         if (not sprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)) then
                         begin
                              warunek := true;
                         end;
                    end;
               end;
          end;
     end;
     SprBicieCP_GL := warunek;
end;

//Sprawdznie mozliwosci bicia do dolu na prawo
function SprBicieCP_DP(var Pionek : TPole2) : Boolean;
var
  row, colummn : Integer;
  warunek : Boolean;
begin
     row := Pionek.MyRow;
     colummn := Pionek.MyColummn;
     warunek := false;
     if (row <= 6) then
     begin
          if (colummn <= 6) then
          begin
               row := row + 1;
               colummn := colummn + 1;
               if (sprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)) then
               begin
                    row := row + 1;
                    colummn := colummn + 1;
                    if (not sprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)) then
                    begin
                         if (not sprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)) then
                         begin
                              warunek := true;
                         end;
                    end;
               end;
          end;
     end;
     SprBicieCP_DP := warunek;
end;

//Sprawdz bicie do dolu na lewo dla czarnego pionka
function SprBicieCP_DL(var Pionek : TPole2) : Boolean;
var
  row, colummn : Integer;
  warunek : Boolean;
begin
     row := Pionek.MyRow;
     colummn := Pionek.MyColummn;
     warunek := false;
     if (row <= 6) then
     begin
          if (colummn >= 3) then
          begin
               row := row + 1;
               colummn := colummn - 1;
               if (sprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)) then
               begin
                    row := row + 1;
                    colummn := colummn - 1;
                    if (not sprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)) then
                    begin
                         if (not sprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)) then
                         begin
                              warunek := true;
                         end;
                    end;
               end;
          end;
     end;
     SprBicieCP_DL := warunek;
end;

//Sprawdzenie ogólnej mozliwosci bicia dla czarnego
//jedna z bardziej glownych funkcji
function sprMozliwoscBiciaDlaCzarnegoPionka(var Pole : TPole2) : Boolean;
var
  warunek : boolean;
begin
     warunek := false;
     if (SprBicieCP_GP(Pole)) then
     begin
          warunek := true;
     end
     else if (SprBicieCP_GL(Pole)) then
     begin
          warunek := true;
     end
     else if (SprBicieCP_DP(Pole)) then
     begin
          warunek := true;
     end
     else if (SprBicieCP_DL(Pole)) then
     begin
          warunek := true;
     end;

     SprMozliwoscBiciaDlaCzarnegoPionka := warunek;
end;

//Sprawdza czy w turze gracza występuje jakiekolwiek bicie
function SprCzyJestMozliwoscBiciaDlaCzarnego() : boolean;
var
  i : integer;
  warunek : boolean;
begin
     warunek := false;
     for i := 1 to iloscCzarnychPionkow do
     begin
          if (czarnePionki[i].MyStan = 'CzarnyPionek') then
          begin
               if (SprMozliwoscBiciaDlaCzarnegoPionka(czarnePionki[i])) then
               begin
                    warunek := true;
                    break;
               end;
          end
          else
          begin
               //Sprwadzenie dla damki
               if (SprMozliwoscBicia_CD(czarnePionki[i])) then
               begin
                    warunek := true;
                    break;
               end;
          end;
     end;

     SprCzyJestMozliwoscBiciaDlaCzarnego := warunek;
end;

//Aktywacja pionkow bijacych dla czarnego gracza
procedure AktywujFiguryBijaceDlaCzarnego();
var
  i : Integer;
begin
     for i := 1 to iloscCzarnychPionkow do
     begin
          if (czarnePionki[i].MyStan = 'CzarnyPionek') then
          begin
               if (SprMozliwoscBiciaDlaCzarnegoPionka(czarnePionki[i])) then
               begin
                    czarnePionki[i].Enabled := true;
               end;
          end
          else
          begin
               //Wykonanie sprawdzanie dla damki
               if (SprMozliwoscBicia_CD(czarnePionki[i])) then
               begin
                    czarnePionki[i].Enabled := true;
               end;
          end;
     end;
end;

//------------- Koniec funkcji związanych z sprawdzanie i aktywowanie pionokow jesli chodzi o bicia ------------

//------------- Funkcje sprawdzajace czy jest mozliwosc ruchu --------------------------------------------------

//Sprawdzenie do dolu na prawo czy czarny pionek nie zastawiony przez biale pionki
function SprZastawCP_BP_DP(row, colummn : integer) : boolean;
var
  warunek : boolean;
begin
     row := row + 1;
     colummn := colummn + 1;
     warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
     if (warunek) then
     begin
          row := row + 1;
          colummn := colummn + 1;
          warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
     end;

     SprZastawCP_BP_DP := warunek;
end;

//sprawdzenie czy czarny pionek jest zastawiony do dolu na lewo przez biale pionki
function SprZastawCP_BP_DL(row, colummn : integer) : boolean;
var
  warunek : boolean;
begin
     row := row + 1;
     colummn := colummn - 1;
     warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
     if (warunek) then
     begin
          row := row + 1;
          colummn := colummn - 1;
          warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
     end;
     SprZastawCP_BP_DL := warunek;
end;

//sprawdzenie zastawienia czarnego pionka w kolumnie 1
function SprZastawCP_C1(Pole : TPole2) : boolean;
var
  row, colummn : integer;
  warunek : boolean;
begin
     row := Pole.MyRow + 1;
     colummn := Pole.MyColummn + 1;
     warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
     if (not warunek) then
     begin
          row := Pole.MyRow;
          colummn := Pole.MyColummn;
          warunek := SprZastawCP_BP_DP(row, colummn);
     end;
     SprZastawCP_C1 := warunek;
end;

//sprawdzenie zastawienia czarnego pionka w kolumnie 2
function SprZastawCP_C2(Pole : TPole2) : boolean;
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
     if (warunek) then
     begin
          colummn := Pole.MyColummn + 1;
          warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
          if (not warunek) then
          begin
               colummn := Pole.MyColummn;
               row := Pole.MyRow;
               warunek := SprZastawCP_BP_DP(row, colummn);
          end;
     end;
     SprZastawCP_C2 := warunek;
end;

//Sprawdzenie zastawienia czarnego pionka w kolumnie 7
function SprZastawCP_C7(Pole : TPole2) : boolean;
var
   row, colummn : integer;
   warunek : boolean;
begin
     row := Pole.MyRow + 1;
     colummn := Pole.MyColummn - 1;
     warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
     if (not warunek) then
     begin
          row := Pole.MyRow;
          colummn := Pole.MyColummn;
          warunek := SprZastawCP_BP_DL(row, colummn);
     end;

     if (warunek) then
          begin
               row := Pole.MyRow + 1;
               colummn := Pole.MyColummn + 1;
               warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
               if (not warunek) then
               begin
                    warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
               end;
          end;

     SprZastawCP_C7 := warunek;
end;

//funkcja sprawdza czy czarny pionek jest zastawiony z kolummny 8
function SprZastawCP_C8(Pole : TPole2) : boolean;
var
   row, colummn : integer;
   warunek : boolean;
begin
     row := Pole.MyRow + 1;
     colummn := Pole.MyColummn - 1;
     warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
     if (not warunek) then
     begin
          row := row - 1;
          colummn := colummn + 1;
          warunek := SprZastawCP_BP_DL(row, colummn);
     end;
     sprZastawCP_C8 := warunek;
end;

//funkcja sprawdza czy pionek z rzedu 7 jest zastawiony
function SprZastawCP_R7(Pole : TPole2) : boolean;
var
   row, colummn : integer;
   warunek : boolean;
begin
     row := Pole.MyRow + 1;
     colummn := Pole.MyColummn;
     if (colummn = 1) then
     begin
          colummn := 2;
          warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
          if (not warunek) then
          begin
                warunek := SprawdzElementTablicy(BialePionki, iloscBialychPionkow, row, colummn);
          end;
     end
     else
     begin
          colummn := Pole.MyColummn + 1;
          warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
          if (not warunek) then
          begin
                warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          end;
          if (warunek) then
                begin
                      colummn := colummn - 2;
                      warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
                      if (not warunek) then
                      begin
                           warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
                      end;
                end;
     end;
     SprZastawCP_R7 := warunek;
end;

//funkcja sprawdzy czy pionek z kolummny (2,7) jest zastawiony
function SprZastawCP_IP(Pole : TPole2) : Boolean;
var
   row, colummn : integer;
   warunek : boolean;
begin
     row := Pole.MyRow + 1;
     colummn := Pole.MyColummn - 1;
     warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
     if (not warunek) then
     begin
          row := Pole.MyRow;
          colummn := Pole.MyColummn;
          warunek := SprZastawCP_BP_DL(row, colummn);
     end;
     if (warunek) then
          begin
               row := Pole.MyRow + 1;
               colummn := Pole.MyColummn + 1;
               warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
               if (not warunek) then
               begin
                    row := Pole.MyRow;
                    colummn := Pole.MyColummn;
                    warunek := SprZastawCP_BP_DP(row, colummn);
               end;
          end;
     SprZastawCP_IP := warunek;
end;

//Sprawdzenie ogolne czy czarny pionek jest zastawiony przez bialePionki
function SprZastawCP(Pole : TPole2): boolean;
var
   row, colummn : integer;
   warunek : boolean;
begin
     row := Pole.MyRow;
     colummn := Pole.MyColummn;
     warunek := false;
     if (row = 7) then
     begin
          warunek := SprZastawCP_R7(Pole);
     end
     else
     if (Pole.MyColummn = 1) then
     begin
          warunek := SprZastawCP_C1(Pole);
     end
     else
     if (colummn = 2) then
     begin
          warunek := SprZastawCP_C2(Pole);
     end
     else
     if (colummn = 7) then
     begin
          warunek := SprZastawCP_C7(Pole);
     end
     else
     if (colummn = 8) then
     begin
          warunek := SprZastawCP_C8(Pole);
     end
     else
     begin
          warunek := SprZastawCP_IP(Pole);
     end;
     SprZastawCP := warunek;
end;


//------------------------------ Koniec sprawdzania zastawien przez czarne pionki ---------------------------------------

//Sprawdza czy jakikolwiek czarny pionek ma mozliowsc ruchu
//czy nie zastawiony przez kolegow
function SprawdzCzyJestMozliwoscRuchuDlaCzarnego() : Boolean;
var
   warunek : boolean;
   i : integer;
begin
     warunek := false;
     for i := 1 to iloscCzarnychPionkow do
     begin
          if (czarnePionki[i].MyStan = 'CzarnyPionek') then
          begin
               if (not SprZastawCP(czarnePionki[i])) then
               begin
                  warunek := true;
                  break;
               end;
          end
          else
          begin
               //Sprawdzenie czy jest mozliwosc ruchu dla damki
               if (not SprZastaw_CD(czarnePionki[i])) then
               begin
                  warunek := true;
                  break;
               end;
          end;
     end;

     SprawdzCzyJestMozliwoscRuchuDlaCzarnego := warunek;
end;

//Aktywuje odpowiednie czarne figury jesli jest taka mozliwosc
procedure AktywujCzarneFiguryZMozliwosciaRuchu();
var
   i : integer;
begin
     for i := 1 to iloscCzarnychPionkow do
     begin
          if (czarnePionki[i].MyStan = 'CzarnyPionek') then
          begin
             if (not SprZastawCP(CzarnePionki[i])) then
             begin
                czarnePionki[i].Enabled := true;
             end;
          end
          else
          begin
               //Aktywacja damki jesli jest taka mozliwosc
               if (not SprZastaw_CD(CzarnePionki[i])) then
               begin
                       czarnePionki[i].Enabled := true;
               end;
          end;
     end;
end;

//Aktywacja odpowiednich figur
procedure AkwtywujOdpowiednieFiguryDlaCzarnego();
begin
     if (SprCzyJestMozliwoscBiciaDlaCzarnego()) then
     begin
          czyJestBicie := true;
          AktywujFiguryBijaceDlaCzarnego();
     end
     else
     if (SprawdzCzyJestMozliwoscRuchuDlaCzarnego()) then
     begin
          AktywujCzarneFiguryZMozliwosciaRuchu();
     end
     else
     begin
          showMessage('Gracz o kolorze bialym wygrywa!!!!!!!!!!! Brak możliwosici ruchu dla Czarnego Gracza');
     end;
end;
end.


