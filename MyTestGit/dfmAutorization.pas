unit dfmAutorization;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
    TfmAutorization = class(TForm)
    edtPass: TLabeledEdit;
    pnl1: TPanel;
    btn1: TButton;
    btnExit: TButton;
    lbl1: TLabel;
    cbbUserName: TComboBox;
    lblUserName: TLabel;
    procedure btn1Click(Sender: TObject);
    procedure edtPassEnter(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public

    { Public declarations }
  end;

var
    fmAutorization: TfmAutorization;
implementation
uses dfmMain,user;

{$R *.dfm}

procedure TfmAutorization.btn1Click(Sender: TObject);
begin
  fmMain.User.UserName := cbbUserName.Text;

  if fmMain.User.Autorization(fmMain.que_sql,edtPass.Text) then
    modalResult := mrOk
  else
    lbl1.Caption := 'Логин или пароль'+#10#13+'введены не верно';
end;

procedure TfmAutorization.btnExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfmAutorization.edtPassEnter(Sender: TObject);
begin
  lbl1.Caption := '';
end;

procedure TfmAutorization.FormShow(Sender: TObject);
var
  I:integer;
begin
  if ListUsers.Count > 0 then
  begin
    for i := 0 to ListUsers.Count - 1 do
      cbbUserName.Items.Add(ListUsers[i].UserName);
    cbbUserName.ItemIndex := 0;
  end
  else
  begin
    cbbUserName.Style := csSimple;
    cbbUserName.Text := 'Пользоветелей в базе не обнаружено';
    cbbUserName.Hint := cbbUserName.Text;
    cbbUserName.ShowHint := True;
    btn1.Enabled := False;
  end;
end;

end.
