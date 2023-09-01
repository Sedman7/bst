unit uRes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ZAbstractConnection, ZConnection,  IniFiles,
  System.ImageList, Vcl.ImgList, cxGraphics, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TRes = class(TForm)
    ZConnection1: TZConnection;
    cxImageList1: TcxImageList;
    TimerRefresh: TTimer;
    dsRefresh: TDataSource;
    qRefresh: TZQuery;
    GroupBox1: TGroupBox;
    qExec: TZQuery;
    dsExec: TDataSource;
    procedure TimerRefreshTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    //������� ���������� ������ � md5
    function  ShifrMD5(vPass :String) : String;

    //������ � ������������� ini
    Procedure IniWindowSave(name:TForm); //��������� ��������� ����
    Procedure IniWindowLoad(name:TForm;wx,wy:integer); //��������� ��������� ����
    Procedure IniUserSave(pname,pserver,pport:string); //��������� ������������ �����
    Function  IniUserLoginLoad:string; //��������� ��������� ������������ �����
    Function  IniUserServerLoad:string; //��������� ��������� ������������ �����
    Function  IniUserPortLoad:string; //��������� ��������� ������������ �����

    //�������� ������������ �� ��������� � ����
    Function CheckRole(uLogin,rolename:string):boolean;

    //���������� SQL �������
    function ExecSQL(const pSQL, pParamNames: string; const pParamValues: array of Variant; const pOpen: Boolean = TRUE): Integer; overload;
    function ExecSQL(const pZQuery: TZQuery; const pSQL, pParamNames: string; const pParamValues: array of Variant; const pOpen: Boolean = TRUE): Integer; overload;
  end;

//��������� ������� ������
  Type
    TSession = record
    ISCONNECT:BOOLEAN;                        //����������
    USERNAME:string;                          //����� �������� ������������
    bst_Admin,bst_User,bst_Guest:boolean;     //���� �������� ������������
  End;

var
  Res: TRes;
  Ini: Tinifile;
  SESSION:TSession;
  rose:TColor;

implementation

{$R *.dfm}

Uses IdHashMessageDigest, uMain, uArrays;

Function TRes.CheckRole(uLogin,rolename:string):boolean;
Const
  SQL:string='select * from org.user_roles where ulogin=:pulogin and rolename=:purolename and userole = true ';
Begin
  If ExecSQL(SQL,'pulogin;purolename',[uLogin,rolename]) > 0 then result:=true else result:=false;
End;

function TRes.ExecSQL(const pSQL, pParamNames: string; const pParamValues: array of Variant; const pOpen: Boolean = TRUE): Integer;
begin
  Result := ExecSQL(qExec, pSQL, pParamNames, pParamValues);
end;

function TRes.ExecSQL(const pZQuery: TZQuery; const pSQL, pParamNames: string; const pParamValues: array of Variant; const pOpen: Boolean): Integer;
var
  ParamNames: TStringArray;
  ParamName: string;
  ParamIndex, ParamCount: Integer;
  Param: TParam;
  Fqry:TZQuery;

begin
// ��������� ������������ ���������� � ParamNames � ���������, ����� ���������� ���������� ���� ����� ���������� �������� ����������
  ParamNames := StringToArray(pParamNames, ';');
  ParamCount := Length(ParamNames);
  if ParamCount <> Length(pParamValues) then
    raise Exception.CreateFmt('ExecSimpleSQL: ���������� ���������� (%d) �� ������������� ���������� �������� ���������� (%d)', [ParamCount, Length(pParamValues)]);

// ��������� ������
  pZQuery.Active := FALSE;
  pZQuery.SQL.Text := '';
  pZQuery.SQL.Text := pSQL;

// ����������� �������� ����������, ���� �����-�� �������� �� ������ � ������� - ������
  for ParamIndex := 0 to ParamCount - 1 do begin
    ParamName := ParamNames[ParamIndex];
    Param := pZQuery.Params.FindParam(ParamName);
    if not Assigned(Param) then raise Exception.CreateFmt('ExecSimpleSQL: �������� (%s) �� ������ � �������', [ParamName]);
    Param.Value := pParamValues[ParamIndex];
  end;

// ���������, ��� ���� �� ���������� ������ ��������
  for ParamIndex := 0 to pZQuery.Params.Count - 1 do begin
    ParamName := pZQuery.Params[ParamIndex].Name;
    if FindInArray(ParamNames, ParamName) = -1 then
      raise Exception.CreateFmt('ExecSimpleSQL: �������� ��� ��������� ������� (%s) �� ������', [ParamName]);
  end;

// ��������� ������ � ��������� ������ ������ ��� ���
  if pOpen then  begin
    pZQuery.Open;
    Result := pZQuery.RecordCount;
  end  else  begin
    pZQuery.ExecSQL;
    Result := -1;
  end;
end;

procedure TRes.FormCreate(Sender: TObject);
begin
//  showmessage('01');
  zConnection1.Disconnect;
  SESSION.ISCONNECT:=false;
  Rose:=RGB(245,220,220);
end;

Procedure TRes.IniUserSave(pname,pserver,pport:string);
Begin
//������� ���� � ���������� ���������
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'bst.ini');
  Ini.WriteString('Users','login',pname);
  Ini.WriteString('Users','server',pserver);
  Ini.WriteString('Users','port',pport);
  Ini.Free;
End;

Function TRes.IniUserLoginLoad:string;
Begin
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'bst.ini');
  result:=Ini.ReadString('Users','login','');
  Ini.Free;
End;
Function TRes.IniUserServerLoad:string;
Begin
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'bst.ini');
  result:=Ini.ReadString('Users','server','localhost');
  Ini.Free;
End;
Function TRes.IniUserPortLoad:string;
Begin
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'bst.ini');
  result:=Ini.ReadString('Users','port','5432');
  Ini.Free;
End;

Procedure TRes.IniWindowSave(name:TForm);
Var
  n:integer;
Begin
//������� ���� � ���������� ���������
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'bst.ini');
  case name.WindowState of
      wsMinimized: n:=0;
      wsNormal: n:=1;
      wsMaximized: n:=2;
    end;
 // ini.WriteInteger(name.name+'WindowState','WindowState', Integer(WindowState));
  ini.WriteInteger(name.name+'WindowState','WindowState', n);
  Ini.WriteInteger(name.name+'Size','Width',name.width);
  Ini.WriteInteger(name.name+'Size','Height',name.height);
  Ini.WriteInteger(name.name+'Position','X',name.left);
  Ini.WriteInteger(name.name+'Position','Y',name.top);
  Ini.Free;
End;

Procedure TRes.IniWindowLoad(name:TForm;wx,wy:integer);
Var
  n:integer;
Begin
//��������� ����
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'bst.ini');
  name.Width:=Ini.ReadInteger(name.name+'Size','Width',wx); //��������� �������� (100) ��� �������� �� ��������� (default)
  name.Height:=Ini.ReadInteger(name.name+'Size','Height',wy);
  name.Left:=Ini.ReadInteger(name.name+'Position','X',10);
  name.Top:=Ini.ReadInteger(name.name+'Position','Y',10);
  n:=ini.ReadInteger(name.name+'WindowState', 'WindowState', 1);
    case n of
      0: name.WindowState := wsMinimized;
      1: name.WindowState := wsNormal;
      2: name.WindowState := wsMaximized;
    end;
  Ini.Free;
End;

function  TRes.ShifrMD5(vPass :String) : String;
begin
 Result := '';
 with TIdHashMessageDigest5.Create do
  try
   Result := AnsiLowerCase(HashStringAsHex(vPass));
  finally
   Free;
  end;
end;


procedure TRes.TimerRefreshTimer(Sender: TObject);
begin
  if SESSION.ISCONNECT then Begin

  // ������������� ����������� ������� ��� ���� ����� �� ����������� �������
    qRefresh.close;
    fmMain.dxMainStatus.Panels[2].PanelStyle.color:=clGreen;
    Try
      qRefresh.Open;
    Except
      fmMain.dxMainStatus.Panels[2].PanelStyle.color:=clRed;

    End;
  End;

end;

end.
