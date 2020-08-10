unit dfmRedact;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,MyFunctions,
  Vcl.ComCtrls,Reception,Patient;

type
  TfmRedact = class(TForm)
    pnl1: TPanel;
    cbbChangeMed: TComboBox;
    pnl2: TPanel;
    btnClose: TSpeedButton;
    btnSubmit: TSpeedButton;
    DateTimePicker: TDateTimePicker;
    lblFio: TLabeledEdit;
    lblPolisNumber: TLabeledEdit;
    lblPrice: TLabeledEdit;
    DateTimePickerTime: TDateTimePicker;
    MemoDiagnosis: TMemo;
    MemoTreatment: TMemo;
    lblTreatment: TLabel;
    lblDiagnosis: TLabel;
    cbbPatient: TComboBox;
    procedure btnCloseClick(Sender: TObject);
    procedure btnSubmitClick(Sender: TObject);
    procedure lblPriceKeyPress(Sender: TObject; var Key: Char);
    procedure cbbPatientSelect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRedact: TfmRedact;

implementation

{$R *.dfm}

procedure TfmRedact.btnCloseClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfmRedact.btnSubmitClick(Sender: TObject);
begin
 ModalResult := mrOk;
end;

procedure TfmRedact.cbbPatientSelect(Sender: TObject);
begin
 lblPolisNumber.Text := ListPatient[cbbPatient.ItemIndex].NumPol;
end;

procedure TfmRedact.lblPriceKeyPress(Sender: TObject; var Key: Char);
begin
  EditKeyPressFilterCena(Sender,Key,2);
end;

end.
