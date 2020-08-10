unit dfmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB,MyConstats,
  AdvUtil, Vcl.ExtCtrls, Vcl.Grids, AdvObj, BaseGrid, AdvGrid,dfmAutorization,
  Vcl.StdCtrls,User,Reception,Patient,Generics.Collections,MyFunctions,
  Vcl.Buttons,dfmRedact, Vcl.Menus,clipbrd, Vcl.ComCtrls;

type
  TfmMain = class(TForm)

    que_sql: TADOQuery;
    ADOConnection: TADOConnection;
    ADVSgReception: TAdvStringGrid;
    pnl1: TPanel;
    lblUser: TLabel;
    pnlInfo: TPanel;
    pnl2: TPanel;
    btnDel: TSpeedButton;
    btnAdd: TSpeedButton;
    btnExcel: TSpeedButton;
    btnOpen: TSpeedButton;
    dlgSave_Export: TSaveDialog;
    pnlSort: TPanel;
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    DateTimePickerPrev: TDateTimePicker;
    DateTimePickerAfter: TDateTimePicker;
    Panel1: TPanel;
    lblAfter: TLabel;
    lblPrev: TLabel;
    cbbUser: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure ADVSgReceptionSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure Sorted(Sender: TObject);
  private
    { Private declarations }
  public
  User : TUser;
  procedure AppIdle(Sender: TObject; var Done: Boolean);
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

procedure TfmMain.FormCreate(Sender: TObject);
var
i:integer;
begin
  AppFolderPath:=copy(ExtractFilePath(Application.ExeName),1,length(ExtractFilePath(Application.ExeName))-1);
  ADOConnection.Connected := false;
  DbPath := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source="' +AppFolderPath + '\MyDatabase.mdb"';
  ADOConnection.ConnectionString := DbPath;
  if ListUsers = nil then
     ListUsers :=  TObjectList<TUser>.Create;
  LoadAllUsers(Que_sql);

  if User = nil then
  User := TUser.Create;
  // форма выбора организации
  if fmAutorization = nil then
    fmAutorization := TfmAutorization.Create(Application);
  fmAutorization.ShowModal;
  if fmAutorization.ModalResult = mrOk then
  begin
    lblUser.Caption := 'Пользователь :' + User.UserName;
    if ListReception = nil then
       ListReception :=  TObjectList<TReception>.Create;
    if ListPatient = nil then
       ListPatient :=  TObjectList<TPatient>.Create;

    LoadAllReceptions(que_sql);
    LoadAllPatient(que_sql);

    ShowAllReceptions(ADVSgReception,ListReception,ListPatient,ListUsers);

    for i := 0 to ListUsers.Count - 1 do
      cbbUser.Items.Add(ListUsers[i].UserName);

    DateTimePickerAfter.Date := IncMonth(Now,-24);
    DateTimePickerPrev.Date := IncMonth(Now,1);
    DateTimePickerAfter.MaxDate := DateTimePickerPrev.Date;
    DateTimePickerPrev.MinDate := DateTimePickerAfter.Date;
    Sorted(nil);
  end
  else
   Halt;
end;

procedure TfmMain.FormShow(Sender: TObject);
begin
  Application.OnIdle:= Self.AppIdle;
end;

procedure TfmMain.N2Click(Sender: TObject);
var
  s: string;
begin
  s := '';
  s := CopyCell(AdvSGReception);
  Clipboard.AsText := s;
end;


procedure TfmMain.ADVSgReceptionSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
//тунц тунц

end;


procedure TfmMain.btnClick(Sender: TObject);
var
idx : integer;
NewReception,RedactedReception:TReception;
NewPatient,RedactedPatient:TPatient;
fTypefmRedact: TypefmRedact;
begin
  if NewReception = nil then
   NewReception := TReception.Create;
  if RedactedReception = nil then
   RedactedReception := TReception.Create;
  if NewPatient = nil then
   NewPatient := TPatient.Create;
  if RedactedPatient = nil then
   RedactedPatient := TPatient.Create;


    if fmRedact = nil then
      fmRedact := TfmRedact.Create(Application);

    if (Sender is TSpeedButton) then
    case (Sender as TSpeedButton).Tag of
     1: fTypefmRedact := fRedact;
     2: fTypefmRedact := fAdd;
    end
    else
    fTypefmRedact := fRedact;


    case fTypefmRedact of
     fRedact:
     begin
       for idx := 0 to ListReception.Count - 1 do
         if ListReception[idx].IdRec = StrToInt(ADVSgReception.Cells[0,ADVSgReception.Row]) then
           break;
       RedactedReception := ListReception[idx];

       with fmRedact do
       begin
         btnSubmit.Enabled := RedactedReception.IdUser = User.IDUser;
         //Кабала с обычным компонентом....
         DateTimePicker.Date := RedactedReception.Date;
         DateTimePicker.Time := 0;
         DateTimePickerTime.Time := RedactedReception.Date;
         DateTimePickerTime.Date := 0;

         for idx := 0 to ListPatient.Count - 1 do
            if RedactedReception.IdPatient = ListPatient[idx].IdPatient then
              break;
         RedactedPatient := ListPatient[idx];

         lblFio.Text := RedactedPatient.FIO;
         lblPolisNumber.Text := RedactedPatient.NumPol;
         MemoDiagnosis.Text := RedactedReception.Diagnosis;
         MemoTreatment.Text := RedactedReception.Treatment;
         lblPrice.Text := FormatFloat('0.00',RedactedReception.Price);

         cbbChangeMed.Items.Clear;
         cbbChangeMed.Enabled := True;
         for idx := 0 to ListUsers.count - 1 do
         begin
            cbbChangeMed.Items.Add(ListUsers[idx].UserName);
            if ListUsers[idx].IdUser = RedactedReception.IDUser then
               cbbChangeMed.ItemIndex := idx;
         end;

         lblFio.Visible := True;
         cbbPatient.Visible := False;
         btnSubmit.Caption := 'Изменить';
       end;
     end;
     fAdd:
     Begin
     with fmRedact do
       begin
         //Кабала с обычным компонентом....
         DateTimePickerTime.Time := Now;
         DateTimePickerTime.Date := 0;
         DateTimePicker.Date := Now;
         DateTimePicker.Time := 0;

         btnSubmit.Enabled := True;
         lblFio.Text := '';
         MemoDiagnosis.Text := '';
         MemoTreatment.Text := '';
         lblPrice.Text := '0,00';
         cbbChangeMed.Items.Clear;
         for idx := 0 to ListUsers.count - 1 do
         begin
            cbbChangeMed.Items.Add(ListUsers[idx].UserName);
            if ListUsers[idx].IdUser = User.IDUser then
               cbbChangeMed.ItemIndex := idx;
         end;
         cbbChangeMed.Enabled := False;
         lblFio.Visible := False;
         cbbPatient.Visible := True;
         cbbPatient.Clear;
         for idx := 0 to ListPatient.count - 1 do
         begin
            cbbPatient.Items.Add(ListPatient[idx].FIO);
            lblPolisNumber.Text := ListPatient[idx].NumPol;
         end;
         cbbPatient.ItemIndex := 0;

         btnSubmit.Caption := 'Добавить';
       end;
     End;
    end;

    fmRedact.Caption := 'Осмотр :' + ADVSgReception.Cells[0,ADVSgReception.Row];

    fmRedact.ShowModal;
    if fmRedact.ModalResult = mrOk then
    begin
     case fTypefmRedact of
       fRedact:          //Изменяем запись
         begin
          with fmRedact do
             begin
               NewReception.IdRec := RedactedReception.IdRec;

               NewReception.Price := StrToFLoat(lblPrice.Text);
               NewReception.Date := DateTimePicker.DateTime + DateTimePickerTime.Time;
               //Поскольку в ТЗ ничего не сказано о добавлении удалении пациентов...
               //просто обновляем ФИО пациента при изменении в полях ФИО и Номер полиса....
               NewPatient.FIO := lblFIO.Text;
               NewPatient.NumPol := lblPolisNumber.Text;
               NewPatient.IdPatient := RedactedReception.IdPatient;

               NewReception.IdPatient := RedactedReception.IdPatient;
               NewReception.IdUser := ListUsers[cbbChangeMed.ItemIndex].IDUser;
               NewReception.Diagnosis := MemoDiagnosis.Text;
               NewReception.Treatment := MemoTreatment.Text;

             end;
           RedactedReception.UpdateReception(que_sql,NewReception);
           RedactedPatient.UpdatePatient(que_sql,NewPatient);
         end;
       fAdd:         //Добавляем запись
         begin
          with fmRedact do
             begin
               NewReception.Price := StrToFloat(lblPrice.Text);
               NewReception.Date := DateTimePicker.DateTime + DateTimePickerTime.Time;
               //Поскольку в ТЗ ничего не сказано о добавлении удалении пациентов...
               //просто обновляем ФИО пациента при изменении в полях ФИО и Номер полиса....
               NewPatient.FIO := cbbPatient.Text;
               NewPatient.NumPol := lblPolisNumber.Text;
               NewPatient.IdPatient := cbbPatient.ItemIndex + 1;

               NewReception.IdPatient := cbbPatient.ItemIndex + 1;
               NewReception.IdUser := User.IDUser;
               NewReception.Diagnosis := MemoDiagnosis.Text;
               NewReception.Treatment := MemoTreatment.Text;

               for idx := 0 to ListPatient.Count - 1 do
                 if ListPatient[idx].IdPatient = NewPatient.IdPatient then
                    begin
                      ListPatient[idx] := NewPatient;
                      break;
                    end;
             end;

           NewReception.IdPatient := fmRedact.cbbPatient.ItemIndex + 1;
           InsertReception(que_sql,NewReception);
         end;
     end;
     ShowAllReceptions(ADVSgReception,ListReception,ListPatient,ListUsers);
    end;
end;

procedure TfmMain.btnDelClick(Sender: TObject);
var
idx:Integer;
begin
  if MessageBox(fmMain.Handle,
    PChar('Удалить прием с ID ' + ADVSgReception.Cells[0,ADVSgReception.Row]+ '? '),
    PChar('Удаление'), MB_YESNO or MB_ICONASTERISK) = mrYes
  then
  for idx := 0 to ListReception.Count - 1 do
    if ListReception[idx].IdRec = StrToInt(ADVSgReception.Cells[0,ADVSgReception.Row]) then
    begin
     ListReception[idx].DeleteReception(que_sql);
     ListReception.Delete(idx);
     ShowAllReceptions(ADVSgReception,ListReception,ListPatient,ListUsers);
     Break;
    end;
end;

procedure TfmMain.btnExcelClick(Sender: TObject);
begin
  fmMain.dlgSave_Export.Filter := 'Импорт в XLS|*.xls';
  if fmMain.dlgSave_Export.Execute then
    SaveXLS(fmMain.dlgSave_Export.FileName, ADVSgReception, [2], [4, 5], [], []);
end;

procedure TfmMain.Sorted(Sender: TObject);
begin
  if cbbUser.Itemindex <> 0 then
    SortSGWithUser(AdvSgReception,cbbUser.Text)
  else
    ShowAllReceptions(ADVSgReception,ListReception,ListPatient,ListUsers);

  DateTimePickerAfter.MaxDate := DateTimePickerPrev.Date;
  DateTimePickerPrev.MinDate := DateTimePickerAfter.Date;
  SortedWithDate(ADVSgReception,DateTimePickerAfter.Date,DateTimePickerPrev.Date);
end;

//откючаем объекты GUI только когда не занят основной поток.
procedure TfmMain.AppIdle(Sender: TObject; var Done: Boolean);
var
qwe:string;
begin
  qwe := ADVSgReception.Cells[7,ADVSgReception.Row];
  btnDel.Enabled := User.UserName = ADVSgReception.Cells[7,ADVSgReception.Row];
  N3.Enabled := User.UserName = ADVSgReception.Cells[7,ADVSgReception.Row];
end;

end.
