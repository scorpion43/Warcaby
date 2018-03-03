unit bialyPionekFP;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Pole2, bialaDamkaFP, globalne, uniwersalne;


function SprMozliwoscBiciaDlaBialegoPionka(Pionek : TPole2) : Boolean;
function SprCzyJestMozliwoscBiciaDlaBialego() : boolean;
procedure AktywujFiguryBijaceDlaBialego();
procedure AkwtywujOdpowiednieFiguryDlaBialego();
procedure AktywujBialeFiguryZMozliwosciaRuchu();
procedure sprIZmienObrazekDamkaLubPionekB();

function SprMozliwoscBiciaBP(): boolean;
function SprMozliwoscRuchuBP() : boolean;



implementation

//procedure zmieniająca obrazki na odpowiednie, kiedy nastapi wybranie figury z tej samej drużyny
procedure sprIZmienObrazekDamkaLubPionekB();
begin
     if (kliknietePole.MyStan = 'BialaDamka') then
     begin
          zmianaStanuIObrazka(kliknietePole, 'nieRusz', sciezkaBD);
     end
     else if (kliknietePole.MyStan = 'BialyPionek') then
     begin
          zmianaStanuIObrazka(kliknietePole, 'nieRusz', sciezkaBP);
     end;

     if (wybranePoleDoc.MyStan = 'BialaDamka') then
     begin
          zmianaStanuIObrazka(wybranePoleDoc, 'nieRusz', sciezkaBDZ);
     end
     else if (wybranePoleDoc.MyStan = 'BialyPionek') then
     begin
          zmianaStanuIObrazka(wybranePoleDoc, 'nieRusz', sciezkaBPZ);
     end;
end;
//sprawdza czy gracz moze wykonac zamierzony ruch
function SprMozliwoscRuchuBP() : boolean;
var
   odstepC, odstepR : integer;
   warunek : boolean;
begin
     warunek := false;
     odstepR := kliknietePole.MyRow - wybranePoleDoc.MyRow;
     odstepC := kliknietePole.MyColummn - wybranePoleDoc.MyColummn;
     if ((odstepR  = 1)) then
     begin
          if ((odstepC = 1) OR (odstepC = (-1))) then
          begin
               warunek := true;
          end;
     end ;
     SprMozliwoscRuchuBP := warunek;
end;

//sprawdza czy gracz moze wykonac takie bicie jakie chce wykonac
function SprMozliwoscBiciaBP(): boolean;
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
              warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
          end;
     end;

     SprMozliwoscBiciaBP := warunek;
end;

//-------- Funkcje sprawdzajace mozliwsoci bicia dla bialych pionkow -------------------------------------------

//Funkcja sprawdza czy jest mozliwosc bicia do Gory Na Prawo
//zwraca wartosc true jest jesli taka mozliwosc, false jestli nie ma takiej mozliwosci
function SprBicieDoGoryNaPrawoDlaBialegoPionka(Pionek : TPole2) : Boolean;
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
               if (SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)) then
               begin
                    row := row - 1;
                    colummn := colummn + 1;
                    if (not SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)) then
                    begin
                         if (not SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)) then
                         begin
                              warunek := true;
                         end;
                    end;
               end;
          end;
     end;
     SprBicieDoGoryNaPrawoDlaBialegoPionka := warunek;
end;

//Funkcja sprawdza czy jest bicie do dou na prawo dla bialego pionka
//zwraca wartosc true jesli jest taka mozliwosc natomiast false jesli nie ma
function SprBicieDoDoluNaPrawoDlaBialegoPionka(Pionek : TPole2) : Boolean;
var
  row, colummn : Integer;
  warunek : Boolean;
begin
     row := Pionek.MyRow;
     colummn := Pionek.MyColummn;
     warunek := false;
     if (row < 7) then
     begin
          if (colummn < 7) then
          begin
               row := row + 1;
               colummn := colummn + 1;
               if (SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)) then
               begin
                    row := row + 1;
                    colummn := colummn + 1;
                    if (not SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)) then
                    begin
                         if (not SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)) then
                         begin
                              warunek := true;
                         end;
                    end;
               end;
          end;
     end;
     SprBicieDoDoluNaPrawoDlaBialegoPionka := warunek;
end;

//Sprawdza czy jest mozliwosc bicia dla pionka do góry na lewo
//Zwraca wartosc true jesli jest, false jestli nie ma
function SprBicieDoGoryNaLewoDlaBialegoPionka(Pionek : TPole2) : Boolean;
var
  row, colummn : Integer;
  warunek : Boolean;
begin
     row := Pionek.MyRow;
     colummn := Pionek.MyColummn;
     warunek := false;
     if (row > 2) then
     begin
          if (colummn > 2) then
          begin
               row := row - 1;
               colummn := colummn - 1;
               if (SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)) then
               begin
                    row := row - 1;
                    colummn := colummn - 1;
                    if (not SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)) then
                    begin
                         if (not SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)) then
                         begin
                              warunek := true;
                         end;
                    end;
               end;
          end;
     end;
     SprBicieDoGoryNaLewoDlaBialegoPionka := warunek;
end;

//Funkcja sprawdza czy pionek ma mozliwosc bicia do dolu na lewo
//argumenty: pole do sprawdzenia
//zwraca wartosc true jesli jest taka mozliwosc bicia natomiast false jesli takiej mozliwosc nie ma
function sprBicieDoDoluNaLewoDlaBialegoPionka(Pionek : TPole2) : Boolean;
var
  row, colummn : Integer;
  warunek : Boolean;
begin
     row := Pionek.MyRow;
     colummn := Pionek.MyColummn;
     warunek := false;
     if (row < 7) then
     begin
          if (colummn > 2) then
          begin
               row := row + 1;
               colummn := colummn - 1;
               if (SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)) then
               begin
                    row := row + 1;
                    colummn := colummn - 1;
                    if (not SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn)) then
                    begin
                         if (not SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn)) then
                         begin
                              warunek := true;
                         end;
                    end;
               end;
          end;
     end;
     SprBicieDoDoluNaLewoDlaBialegoPionka := warunek;
end;

//------------ Koniec funkcji sprawdzajacych mozliwosc bicia dla bialego pionka ----------------------------------

//Sprawdza czy podany pionek ma mozliwosc bicia
//argumenty: pole do sprawdzenia
//zwraca wartosc true jesli pionek ma mozliwosc bicia, natomiast false jesli takie bicie nie wystepuje
function SprMozliwoscBiciaDlaBialegoPionka(Pionek : TPole2) : Boolean;
var
  warunek : boolean;
begin
     warunek := false;
     if (SprBicieDoGoryNaPrawoDlaBialegoPionka(Pionek)) then
     begin
          warunek := true;
     end
     else if (SprBicieDoDoluNaPrawoDlaBialegoPionka(Pionek)) then
     begin
          warunek := true;
     end
     else if (SprBicieDoGoryNaLewoDlaBialegoPionka(Pionek)) then
     begin
          warunek := true;
     end
     else if (SprBicieDoDoluNaLewoDlaBialegoPionka(Pionek)) then
     begin
          warunek := true;
     end;

     SprMozliwoscBiciaDlaBialegoPionka := warunek;
end;

//Sprawdza czy w turze gracza występuje jakiekolwiek bicie
//argumenty: tablica pionkow, ilosc
//zwraca wartosc true jesli znajdzie bicie, natomiast false jesli takich bic nie ma wcale
function SprCzyJestMozliwoscBiciaDlaBialego() : boolean;
var
  i : integer;
  warunek : boolean;
begin
     warunek := false;
     for i := 1 to iloscBialychPionkow do
     begin
          if (bialePionki[i].MyStan = 'BialyPionek') then
          begin
               if (SprMozliwoscBiciaDlaBialegoPionka(bialePionki[i])) then
               begin
                    warunek := true;
                    break;
               end;
          end
          else
          begin
               //Sprwadzenie dla damki
               if (SprMozliwoscBicia_BD(bialePionki[i])) then
               begin
                    warunek := true;
                    break;
               end;
          end;
     end;

     SprCzyJestMozliwoscBiciaDlaBialego := warunek;
end;

//Aktywacja pionkow bijacych dla bialego gracza
procedure AktywujFiguryBijaceDlaBialego();
var
  i : Integer;
begin
     for i := 1 to iloscBialychPionkow do
     begin
          if (bialePionki[i].MyStan = 'BialyPionek') then
          begin
               if (SprMozliwoscBiciaDlaBialegoPionka(bialePionki[i])) then
               begin
                    bialePionki[i].Enabled := true;
               end;
          end
          else
          begin
               if (SprMozliwoscBicia_BD(bialePionki[i])) then
               begin
                    bialePionki[i].Enabled := true;
               end;
          end;
     end;
end;

//--------------------- Funckje sprawdzajace czy jest mozliwosc ruchu dla bialego pionka -----------------------//



// ---------------- Sprawdzanie czy bialy pionek nie jest zastawiony przez czarnePionki ---------------------- //



//Funkcja ktora sprawdza czy pionek jest zastawiony do gory na prawo przez czarne pionki
function SprZastawBP_GP(Pole : TPole2) : boolean;
var
   row, colummn : integer;
   warunek : boolean;
begin
     warunek := false;
     row := Pole.MyRow - 1;
     colummn := Pole.MyColummn + 1;
     warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow,  row, colummn);
     if (warunek) then
     begin
          row := row - 1;
          colummn := colummn + 1;
          warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow,  row, colummn);
     end;
     SprZastawBP_GP := warunek;
end;

//Funkcja ktora sprawdza czy pionek jest zastawiony do gory na lewo przez czarne pionki
function SprZastawBP_GL(Pole : TPole2) : boolean;
var
   row, colummn : integer;
   warunek : boolean;
begin
     warunek := false;
     row := Pole.MyRow - 1;
     colummn := Pole.MyColummn - 1;
     warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
     if (warunek) then
     begin
          row := row - 1;
          colummn := colummn - 1;
          warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
     end;
     SprZastawBP_GL := warunek;
end;

//sprawdzanie bialego pionka czy nie jest zastawiony w rzedzie 2
function SprZastawBP_R2(Pole : TPole2) : Boolean;
var
   row, colummn : integer;
   warunek : boolean;
begin
     row := Pole.MyRow;
     colummn := Pole.MyColummn;
     if (colummn = 8) then
     begin
          row := row - 1;
          colummn := colummn - 1;
          warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          if (not warunek) then
          begin
               warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
          end;
     end
     else
     begin
         row := row - 1;
         colummn := colummn - 1;
         warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
         if (not warunek) then
         begin
              warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
         end;
         if (warunek) then
         begin
              colummn := Pole.MyColummn + 1;
              warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
              if (not warunek) then
              begin
                   warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
              end;
         end;
     end;

     SprZastawBP_R2 := warunek;
end;

//sprawdzanie bialego pionka czy nie jest zastawiony w columnie 1
function SprZastawBP_C1(Pole : TPole2) : Boolean;
var
   row, colummn : integer;
   warunek : boolean;
begin
     row := Pole.MyRow - 1;
     colummn := Pole.MyColummn + 1;
     warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
     if (not warunek) then
     begin
          warunek := SprZastawBP_GP(Pole);
     end;

     SprZastawBP_C1 := warunek;
end;

//funkcja która sprawdza czy pionek w kolumnie 2 jest zastawiony
//przez czarne pionki
function SprZastawBP_C2(Pole : TPole2) : boolean;
var
   row, colummn : integer;
   warunek : boolean;
begin
     row := Pole.MyRow - 1;
     colummn := Pole.MyColummn - 1;
     warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
     if (not warunek) then
     begin
          warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
     end;
     if (warunek) then
     begin
          warunek := SprZastawBP_GP(Pole);
          if (not warunek) then
          begin
               colummn := Pole.MyColummn + 1;
               warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          end;
     end;

     SprZastawBP_C2 := warunek;
end;

//Funkcja która sprawdza czy pionek jest zastawiony w kolumnie 7
function SprZastawBP_C7(Pole : TPole2) : boolean;
var
   row, colummn : integer;
   warunek : boolean;
begin
     row := Pole.MyRow - 1;
     colummn := Pole.MyColummn + 1;
     warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
     if (not warunek) then
     begin
          warunek := SprawdzElementTablicy(czarnePionki, iloscCzarnychPionkow, row, colummn);
     end;
     if (warunek) then
     begin
          warunek := SprZastawBP_GL(Pole);
          if (not warunek) then
          begin
               row := Pole.MyRow - 1;
               colummn := Pole.MyColummn - 1;
               warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          end;
     end;
     SprZastawBP_C7 := warunek;
end;

//sprawdzenie czy bialy pionek w kolumnie 8 jest zastowiony
function SprZastawBP_C8(Pole : TPole2) : boolean;
var
   row, colummn : integer;
   warunek : boolean;
begin
     row := Pole.MyRow - 1;
     colummn := Pole.MyColummn - 1;
     warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
     if (not warunek) then
     begin
          warunek := SprZastawBP_GL(Pole);
     end;
     SprZastawBP_C8 := warunek;
end;

//sprawdzanie czy pionki (2, 7) nie sa zastawione
function SprZastawBP_IP(Pole : TPole2) : boolean;
var
   row, colummn : integer;
   warunek : boolean;
begin
     row := Pole.MyRow - 1;
     colummn := Pole.MyColummn - 1;
     warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
     if (not warunek) then
     begin
          warunek := SprZastawBP_GL(Pole);
     end;
     if (warunek) then
     begin
          colummn := Pole.MyColummn + 1;
          warunek := SprawdzElementTablicy(bialePionki, iloscBialychPionkow, row, colummn);
          if (not warunek) then
          begin
               warunek := SprZastawBP_GP(Pole);
          end;
     end;
     SprZastawBP_IP := warunek;
end;

//Funkcja ktora skupia wyszystkie funkcje sprawdzające czy bialy pionek nie jest zastoawiony
function SprZastawBP(Pole : TPole2): boolean;
var
   warunek : boolean;
   row, colummn : integer;
begin
     warunek := false;
     row := Pole.MyRow;
     colummn := Pole.MyColummn;

     if (row = 2) then
     begin
          warunek := SprZastawBP_R2(Pole);
     end
     else
     if (colummn = 1) then
     begin
          warunek := SprZastawBP_C1(Pole);
     end
     else
     if (colummn = 2) then
     begin
          warunek := SprZastawBP_C2(Pole);
     end
     else
     if (colummn = 7) then
     begin
          warunek := SprZastawBP_C7(Pole);
     end
     else
     if (colummn = 8) then
     begin
          warunek := SprZastawBP_C8(Pole);
     end
     else
     begin
          warunek := SprZastawBP_IP(Pole);
     end;

     SprZastawBP := warunek;
end;

//Sprawdzenie sa pionki z mozliwoscia ruchą dla bialego pionka
function SprawdzCzyJestMozliwoscRuchuDlaBialego() : Boolean;
var
   warunek : boolean;
   i : integer;
begin
     warunek := false;
     for i := 1 to iloscBialychPionkow do
     begin
          if (bialePionki[i].MyStan = 'BialyPionek') then
          begin
               if (not SprZastawBP(bialePionki[i])) then
               begin
                  warunek := true;
                  break;
               end;
          end
          else
          begin
               if (not SprZastaw_BD(bialePionki[i])) then
               begin
                  warunek := true;
                  break;
               end;
          end;
     end;

     SprawdzCzyJestMozliwoscRuchuDlaBialego := warunek;
end;

//---------------------- Koniec funkcji sprawdzajacych mozliwosc ruchu dla bialego pionka ---------------------


//Aktywowanie odpowiednich pionkow bialych
procedure AktywujBialeFiguryZMozliwosciaRuchu();
var
   i : integer;
begin
     for i := 1 to iloscBialychPionkow do
     begin
          if (bialePionki[i].MyStan = 'BialyPionek') then
          begin
             if (not SprZastawBP(bialePionki[i])) then
             begin
                bialePionki[i].Enabled := true;
             end;
          end
          else
          begin
               if (not SprZastaw_BD(bialePionki[i])) then
               begin
                    bialePionki[i].Enabled := true;
               end;
          end;
     end;
end;



//---------------- Koniec funkcji spradzających czy bialy pionek jest zastawiony prze czarne Pionki ------------//

//Aktywacja odpowiednich figur
procedure AkwtywujOdpowiednieFiguryDlaBialego();
begin
     if (SprCzyJestMozliwoscBiciaDlaBialego()) then
     begin
          czyJestBicie := true;
          aktywujFiguryBijaceDlaBialego();
     end
     else if (SprawdzCzyJestMozliwoscRuchuDlaBialego()) then
     begin
          AktywujBialeFiguryZMozliwosciaRuchu();
     end
     else
     begin
          showMessage('Gracz o kolorze czarnym wygrywa!!!!!!!!!!! Brak możliwosici ruchu dla Bialego Gracza');
     end;
end;

end.

