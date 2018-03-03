{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit Nowy_Pakiet1;

interface

uses
  Pole2, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('Pole2', @Pole2.Register);
end;

initialization
  RegisterPackage('Nowy_Pakiet1', @Register);
end.
