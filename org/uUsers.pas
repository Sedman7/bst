unit uUsers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBaseGrid, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, dxSkinsdxBarPainter,
  cxClasses, System.Actions, Vcl.ActnList, dxBar, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, cxDBNavigator, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxContainer, cxTextEdit, cxDBEdit, cxLabel, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxMemo, Vcl.StdCtrls, Vcl.Menus, cxSplitter, cxButtons, cxGroupBox,
  cxCheckBox, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox;

type TRoleList=record
  rList:string;
  rCount:integer;
end;

type
  TfmUsers = class(TfmBaseGrid)
    grBaseDBTableView1iduser: TcxGridDBColumn;
    grBaseDBTableView1ulogin: TcxGridDBColumn;
    cxGridRolesDBTableView1: TcxGridDBTableView;
    cxGridRolesLevel1: TcxGridLevel;
    cxGridRoles: TcxGrid;
    qRole: TZQuery;
    dsRole: TDataSource;
    grBaseDBTableView1statustext: TcxGridDBColumn;
    cxDBTextEdit1: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    cxDBDateEdit1: TcxDBDateEdit;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel6: TcxLabel;
    cxTextPass1: TcxTextEdit;
    cxTextPass2: TcxTextEdit;
    cxLabel7: TcxLabel;
    cxTextuLogin: TcxTextEdit;
    cxMemoNote: TcxMemo;
    cxCheckBlock: TcxCheckBox;
    cxGridRolesDBTableView1id: TcxGridDBColumn;
    cxGridRolesDBTableView1userole: TcxGridDBColumn;
    cxGridRolesDBTableView1rolename: TcxGridDBColumn;
    cxGridRolesDBTableView1describe: TcxGridDBColumn;
    qRoleuserole: TBooleanField;
    qRolerolename: TWideStringField;
    qRoledescribe: TWideStringField;
    cxDBTextEdit2: TcxDBTextEdit;
    cxLabel8: TcxLabel;
    cxCheckLog: TcxCheckBox;
    cxChecFullDell: TcxCheckBox;
    EditULogin: TEdit;
    cxLookupStatus: TcxLookupComboBox;
    qStat: TZQuery;
    dsStat: TDataSource;
    procedure grBaseDBTableView1CellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure actCreateExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure EditULoginChange(Sender: TObject);
    procedure cxLookupStatusPropertiesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actEraserExecute(Sender: TObject);
  private
    { Private declarations }
    Procedure CreateInit;   //активируем нужные поля для редактирования
    Procedure CreateFinish; //деактивируем после редактирования
    Procedure EditInit;   //активируем нужные поля для редактирования

    Function MakeColors(errMessage:boolean):integer;    //возвращает 0 - ошибок нет, >0 - Ошибки; true - показать отчет об ошибках
    Function MakeRolesList:TRoleList; //формирует список выбранных атрибутов
  public
    { Public declarations }
  end;

var
  fmUsers: TfmUsers;

implementation

{$R *.dfm}

uses uRes;

Const
  SQLqRole:string=
  ' select ur.id, ur.userole, ur.rolename, ro."describe" from org.user_roles ur '+
  ' join org.roles ro on ur.rolename = ro.rolename '+
  ' where iduser=:piduser '+
  ' order by ro.idrole ';

  SQLqRoleNew:string=' select idrole,false as userole, rolename, describe  from org.roles r where idrole>1 order by idrole ';
  SQLqRoleEdit:string=' select idrole, '+
  ' (case when (select count(*) from org.user_roles where rolename=r.rolename and ulogin=:PULOGIN)>0 then true else false end) as userole, '+
  ' rolename, describe  from org.roles r where idrole>1 order by idrole ';


Function TfmUsers.MakeRolesList:TRoleList; //формирует список выбранных атрибутов
Var
  s:string;
  Count:integer;
Begin
  s:='{';
  Count:=0;

  //формируем список
  qRole.First;
  while not qRole.eof do begin
    if qRole.FieldByName('userole').AsBoolean then Begin
      s:=s+qRole.FieldByName('rolename').AsString+',';
      inc(Count);
    End;
    qRole.Next;
  End;

  //удаляем последнюю ','
  if length(s)>1 then delete(s,length(s),1);
  s:=s+'}';

  Result.rList:=s;
  Result.rCount:=Count;
End;


procedure TfmUsers.actSaveExecute(Sender: TObject);
Const
  SQL:string='select org.user_create(:pulogin, :ppas, :proles, :pnote, :pce, :pblocked, :plog)';
Var
  RoleList:TRoleList;
  pblock:integer;
  plog:boolean;
  pce:string;
begin
  inherited;

  //если все поля заполнены правильно - формируем пользователя, иначе - показываем сообщение (true)
  If MakeColors(True)=0 then Begin

    //формируем список ролей и параметров
    RoleList:=MakeRolesList;
    //тип вызова процедуры
    If FormStatus='create' then pce:='create';
    if FormStatus='edit' then pce:='edit';
    //блокировка
    If cxCheckBlock.Checked then pblock:=1 else pblock:=0;
    //блокировка
    If cxCheckLog.Checked then plog:=true else plog:=false;

    if RoleList.rCount=1 then Begin

      If Res.ExecSQL(SQL,'pulogin;ppas;proles;pnote;pce;pblocked;plog',[cxTextuLogin.Text,cxTextPass1.EditValue,RoleList.rList,cxMemoNote.Text,pce,pblock,plog])>0 then Begin
        ShowMessage('Регистрация пользователя '+cxTextuLogin.Text+' завершена.');
        CreateFinish;
      End
      Else ShowMessage('Ошибка создания пользователя.');

      qBase.Refresh;
    End else Begin
      If RoleList.rCount>1 then ShowMessage('Для пользователя должна быть выбрана одна роль.');
      If RoleList.rCount=0 then ShowMessage('Роль пользователя не указана.');
    End;

  End;
end;

Procedure TfmUsers.CreateInit;
Begin
  //Активируем поля
  cxTextuLogin.Enabled:=true;
  cxTextPass1.Enabled:=true;
  cxTextPass2.Enabled:=true;
  cxMemoNote.Enabled:=true;

  //Активируем кнопки
  cxButSave.Enabled:=true;
  cxButCancel.Enabled:=true;

  //обнуляем значения
  cxTextuLogin.Text:='';
  cxTextPass1.Text:='';
  cxTextPass2.Text:='';
  cxMemoNote.Text:='';

  //очищаем список ролей (показывам для пользователя Default)
  qRoleuserole.ReadOnly:=false;
  qRole.Close;
  qRole.SQL.Text:=SQLqRoleNew;
  //qRole.Params.ParamByName('piduser').Value:=1;
  qRole.Open;

  cxCheckBlock.Enabled:=true;
  cxCheckLog.Enabled:=true;
End;

procedure TfmUsers.cxLookupStatusPropertiesChange(Sender: TObject);
begin
  inherited;
  actRefresh.Execute;
end;

procedure TfmUsers.EditULoginChange(Sender: TObject);
begin
  inherited;
  actRefresh.Execute;
end;

Procedure TfmUsers.EditInit;
Begin
  //Активируем поля
//  cxTextuLogin.Enabled:=true;
  cxTextPass1.Enabled:=true;
  cxTextPass2.Enabled:=true;
  cxMemoNote.Enabled:=true;

  //Активируем кнопки
  cxButSave.Enabled:=true;
  cxButCancel.Enabled:=true;

  //обнуляем значения
//  cxTextuLogin.Text:='';
  cxTextPass1.Text:='';
  cxTextPass2.Text:='';
  cxMemoNote.Text:='';

//очищаем список ролей (показывам для пользователя Default)
  qRoleuserole.ReadOnly:=false;
  qRole.Close;
  qRole.SQL.Text:=SQLqRoleEdit;
  qRole.Params.ParamByName('PULOGIN').Value:=cxTextuLogin.Text;
  qRole.Open;

  cxCheckBlock.Enabled:=true;
  cxCheckLog.Enabled:=true;
End;

Procedure TfmUsers.CreateFinish;
Begin
  //Дективируем поля
  cxTextuLogin.Enabled:=false;
  cxTextPass1.Enabled:=false;
  cxTextPass2.Enabled:=false;
  cxMemoNote.Enabled:=false;

  //Дективируем кнопки
  cxButSave.Enabled:=false;
  cxButCancel.Enabled:=false;

  //обнуляем значения
  cxTextuLogin.Text:='';
  cxTextPass1.Text:='';
  cxTextPass2.Text:='';
  cxMemoNote.Text:='';

  qRoleuserole.ReadOnly:=True;
  FormStatus:='view';

  cxCheckBlock.Enabled:=false;
  cxCheckLog.Enabled:=false;
End;

Function TfmUsers.MakeColors(errMessage:boolean):integer;
Var
  err:integer;
  s:string;
Begin
  err:=0;
  s:='';

  cxTextuLogin.Style.Color:=clWhite;
  cxTextPass1.Style.Color:=clWhite;
  cxTextPass2.Style.Color:=clWhite;

  //длина логина не может быть меньше 3 символов
  if Length(cxTextuLogin.Text)<3 then Begin
    cxTextuLogin.Style.Color:=uRes.rose;
    s:=s+'Логин должен быть не менее 3-х символов. ';
    inc(err);
  End;


  //длина пароля не может быть меньше 3 символов
  if ((Length(cxTextPass1.Text)<3) or (Length(cxTextPass2.Text)<3)) and (FormStatus<>'edit') then Begin
    cxTextPass1.Style.Color:=uRes.rose;
    cxTextPass2.Style.Color:=uRes.rose;
    s:=s+'Пароль должен быть не менее 3-х символов. ';
    inc(err);
  End;

  //совпадение паролей
  if cxTextPass1.Text<>cxTextPass2.Text then Begin
    cxTextPass1.Style.Color:=uRes.rose;
    cxTextPass2.Style.Color:=uRes.rose;
    s:=s+'Пароли не совпадают. ';
    inc(err);
  End;

  if (err>0) and (errMessage) then ShowMessage(s);

  Result:=err;
End;

procedure TfmUsers.actCancelExecute(Sender: TObject);
begin
  inherited;
  CreateFinish;
end;

procedure TfmUsers.actCreateExecute(Sender: TObject);
begin
  inherited;

  CreateInit;
  MakeColors(False);

end;

procedure TfmUsers.actDelExecute(Sender: TObject);
Const
  SQL:string='select org.user_delete(:pulogin, :pfulldelete)';
begin
  inherited;
  //запрос на удаление
//  if MessageDlg('Удалить пользователя '+cxTextuLogin.Text+' ?',mtConfirmation ,[mbYes,mbNo], 0)=mrYes then
  If MessageBox(handle, PChar('Удалить пользователя '+cxTextuLogin.Text+' ?'), PChar('Удаление пользователя'), MB_YESNO+MB_ICONQUESTION)=idyes then
    if cxChecFullDell.Checked then Begin
      if MessageDlg('Включен режим удаления из базы, восстановление будет невозможно, удалить безвозвратно пользователя '+cxTextuLogin.Text+' ?',mtWarning ,[mbYes,mbNo], 0)=mrYes then
        Res.ExecSQL(SQL,'pulogin;pfulldelete',[cxTextuLogin.Text,true]);

    End Else Res.ExecSQL(SQL,'pulogin;pfulldelete',[cxTextuLogin.Text,false]);

  qBase.Refresh;
end;

procedure TfmUsers.actEditExecute(Sender: TObject);
begin
  inherited;
  EditInit;
  MakeColors(False);
end;

procedure TfmUsers.actEraserExecute(Sender: TObject);
begin
  inherited;
  EditULogin.Text:='';
  cxLookupStatus.EditValue:=null;
  actRefresh.Execute;
end;

procedure TfmUsers.actRefreshExecute(Sender: TObject);
Const
  SQL:string=
' select iduser,idclient,ulogin,pass,regdate, znach as statustext, status, note '+
' from org.users us '+
' join spr.status st on st.kod = us.status '+
' where us.ulogin <>  ''default'' ';
Var
  S:String;
begin
  inherited;
  S:=SQL;

  if Length(EditULogin.Text)>0 then S:=S+' AND ulogin like ''%'+EditULogin.Text+'%'' ';
  if NOT VarIsNull(cxLookupStatus.EditValue) then S:=S+' AND status= '+VarToStr(cxLookupStatus.EditValue);

  S:=S+' ORDER BY ulogin';

  qBase.Close;
  qBase.SQL.Text:=S;
  qBase.Open;
end;

procedure TfmUsers.FormCreate(Sender: TObject);
begin
  inherited;
  qRole.Close;
  qRole.Params.ParamByName('piduser').Value:=1;
  qRole.Open;

  qStat.Close;
  qStat.Open;

  cxCheckBlock.Enabled:=false;
  cxCheckLog.Enabled:=false;

  qRole.Close;
  qRole.SQL.Text:=SQLqRole;
  qRole.Params.ParamByName('piduser').Value:=qBase.FieldByName('iduser').AsInteger;
  qrole.Open;

  //прописываем логин
  cxTextuLogin.Text:=qBase.FieldByName('uLogin').AsString;

  //прописываем примечание
  cxMemoNote.Text:=qBase.FieldByName('note').AsString;

  //фиксируем блокировку если она есть
  if qBase.FieldByName('status').AsInteger=1 then cxCheckBlock.Checked:=true
    else cxCheckBlock.Checked:=false;
end;

procedure TfmUsers.FormShow(Sender: TObject);
begin
  inherited;
  qBase.First;
end;

procedure TfmUsers.grBaseDBTableView1CellClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
 if FormStatus='view' then Begin

  inherited;
  qRole.Close;
  qRole.SQL.Text:=SQLqRole;
  qRole.Params.ParamByName('piduser').Value:=qBase.FieldByName('iduser').AsInteger;
  qrole.Open;

  //прописываем логин
  cxTextuLogin.Text:=qBase.FieldByName('uLogin').AsString;

  //прописываем примечание
  cxMemoNote.Text:=qBase.FieldByName('note').AsString;

  //фиксируем блокировку если она есть
  if qBase.FieldByName('status').AsInteger=1 then cxCheckBlock.Checked:=true
    else cxCheckBlock.Checked:=false;
 end;
end;

end.
