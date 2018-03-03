unit globalne;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Pole2;

var
  czyWybrany : boolean;
  czyjRuch : Byte;
  pomylka : boolean;
  czyJestBicie : boolean;
  czyKoniecGry : boolean;

  kliknietePole : TPole2;
  wybranePoleDoc : TPole2;

  bialePionki : Array[0..12] of TPole2;
  czarnePionki : Array[0..12] of TPole2;
  //elementyDoBicia : array[0..8] Of Integer;

  iloscBialychPionkow : Integer;
  iloscCzarnychPionkow : Integer;
  //iloscElementowDoBicia : Integer;

  sciezkaBP : String; //sciezka bialego pionka
  sciezkaBPZ : String; //sciezka bialego pionka zaznaczonego
  sciezkaBD : String; //sciezka bialej damki
  sciezkaBDZ : String; //sciezka bialej damki zaznaczonej
  sciezkaCPole : String;  //sciezka czarnego pola
  sciezkaCD : String; //sciezka czarnej damki
  sciezkaCDZ : String; //sciezka czarnej damki zaznaczonej
  sciezkaCP : String; //sciezka czarnego pionka
  sciezkaCPZ : String; //sciezka czarnego pionka zaznaczonego

implementation

end.

