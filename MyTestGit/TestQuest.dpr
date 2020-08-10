program TestQuest;

uses
  Forms,
  Windows,
  SysUtils,
  Dialogs,
  dfmMain in 'dfmMain.pas' {fmMain},
  User in 'User.pas',
  MyConstats in 'MyConstats.pas',
  dfmAutorization in 'dfmAutorization.pas' {fmAutorization},
  dfmRedact in 'dfmRedact.pas' {fmRedact},
  Reception in 'Reception.pas',
  Patient in 'Patient.pas',
  MyFunctions in 'MyFunctions.pas';

{$R *.res}
var
hMutex: THandle;

begin

  hMutex := CreateMutex(nil, True, PChar(ExtractFileName(ParamStr(0))));
  // ѕроверка запущено приложение или нет
if GetlastError = ERROR_ALREADY_EXISTS then
  begin
    ShowMessage('Ёкземпл€р программы запущен!');
    //TerminateProcess(GetCurrentProcess, 0);
    Halt;
  end
  else
  begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TfmMain, fmMain);
    Application.Run;
  end;
end.

