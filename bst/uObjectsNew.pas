unit uObjectsNew;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBaseForm, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinOffice2016Colorful,
  dxSkinOffice2016Dark, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, Vcl.Menus, System.Actions, Vcl.ActnList, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxSplitter, Vcl.StdCtrls,
  cxButtons, cxGroupBox, cxLabel, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxCurrencyEdit, cxCheckBox;

type
  TfmObjectsNew = class(TfmBaseForm)
    cxTextName: TcxTextEdit;
    cxLabel1: TcxLabel;
    cxGroupBox2: TcxGroupBox;
    cxLookupTown: TcxLookupComboBox;
    qStreet: TZQuery;
    dsStreet: TDataSource;
    qTown: TZQuery;
    dsTown: TDataSource;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLookupStreet: TcxLookupComboBox;
    cxDom: TcxCurrencyEdit;
    cxLabel4: TcxLabel;
    cxKorp: TcxCurrencyEdit;
    cxLabel5: TcxLabel;
    cxInd: TcxTextEdit;
    cxLabel6: TcxLabel;
    cxLookupType: TcxLookupComboBox;
    cxLabel7: TcxLabel;
    qTypes: TZQuery;
    dsTypes: TDataSource;
    cxButton2: TcxButton;
    cxButton3: TcxButton;
    cxCheckClose: TcxCheckBox;
    procedure cxLookupComboBox1PropertiesChange(Sender: TObject);
    procedure actEraserExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxDomKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure cxLookupTypePropertiesChange(Sender: TObject);
    procedure cxTextNamePropertiesChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Function MakeColors(errMessage:boolean):integer;    //���������� 0 - ������ ���, >0 - ������; true - �������� ����� �� �������
  end;

var
  fmObjectsNew: TfmObjectsNew;

implementation

{$R *.dfm}

Uses uRes;

procedure TfmObjectsNew.actCancelExecute(Sender: TObject);
begin
  inherited;

  If MessageBox(handle, PChar('����� ��� ���������� ������?'), PChar('�����'), MB_YESNO+MB_ICONQUESTION)=idyes then Close;

end;

procedure TfmObjectsNew.actEraserExecute(Sender: TObject);
begin
  inherited;
  //������� ���������

  cxLookUpTown.EditValue:=null;   //�����

  cxLookUpStreet.EditValue:=null; //�����
  cxLookUpStreet.Enabled:=false;

  cxDom.EditValue:=null;
  cxKorp.EditValue:=false;
  cxInd.EditValue:=false;

  cxLookUpType.EditValue:=false;  //��� �������

end;

Function TfmObjectsNew.MakeColors(errMessage:boolean):integer;
Var
  err:integer;
  s:string;
Begin
  err:=0;
  s:='';

  cxLookUpTown.Style.Color:=clWhite;
  cxLookupType.Style.Color:=clWhite;
  cxTextName.Style.Color:=clWhite;

  //����� ������������ �� ����� ���� ������ 3 ��������
  if Length(cxTextName.Text)<3 then Begin
    cxTextName.Style.Color:=uRes.rose;
    s:=s+'������������ ������ ���� �� ����� 3-� ��������. ';
    inc(err);
  End;

  //�� ������ ���������� �����
  if VarIsNull(cxLookUpTown.EditValue) then Begin
    cxLookUpTown.Style.Color:=uRes.rose;
    s:=s+'�� ������ ���������� �����. ';
    inc(err);
  End;

  //�� ������ ��� �������
  if VarIsNull(cxLookupType.EditValue) then Begin
    cxLookupType.Style.Color:=uRes.rose;
    s:=s+'�� ������ ��� �������. ';
    inc(err);
  End;

    if (err>0) and (errMessage) then ShowMessage(s);

  Result:=err;
End;

procedure TfmObjectsNew.actSaveExecute(Sender: TObject);
Const
  SQL:string='select main.object_create(:pname, :pidtown, :pidstreet, :pdom, :pdomindex, :pdomkorp, :pobjtype);';
begin
  inherited;

  //���� ��� ���� ��������� ���������
  if MakeColors(true)=0 then
  //������ ������������ ���������� ������
  If MessageBox(handle, PChar('������� ������ ['+cxTextName.Text+'] � ����?'), PChar('�������� �������'), MB_YESNO+MB_ICONQUESTION)=idyes then Begin
    Res.ExecSQL(SQL,'pname;pidtown;pidstreet;pdom;pdomindex;pdomkorp;pobjtype',
                    [cxTextName.Text,cxLookUpTown.EditValue,cxLookupStreet.EditValue,cxDom.EditValue,cxInd.EditValue,cxKorp.EditValue,cxLookupType.EditValue]);

    //��������� ���� ���� ����� ������, ���� ��� - ������� ���������
    if cxCheckClose.Checked then Close
      Else Begin
        actEraser.Execute;
        MakeColors(false);
      End;

  End;
end;

procedure TfmObjectsNew.cxDomKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  //��������� ���� ������ ����
  if not (Key in ['0'..'9', #8])then Key:=#0;
  //������ ����� ������� ����
  if key = '0' then if cxDom.SelStart=0 then Key :=#0;
end;

procedure TfmObjectsNew.cxLookupComboBox1PropertiesChange(Sender: TObject);
begin
  inherited;

  //��� ����� ������ ��������� ������� �����
  qStreet.Close;
  qStreet.ParamByName('PIDTOWN').Value:=cxLookUpTown.EditValue;
  qStreet.Open;
  cxLookUpStreet.Enabled:=true;

  MakeColors(false);

end;

procedure TfmObjectsNew.cxLookupTypePropertiesChange(Sender: TObject);
begin
  inherited;
  MakeColors(false);
end;

procedure TfmObjectsNew.cxTextNamePropertiesChange(Sender: TObject);
begin
  inherited;
  MakeColors(false);
end;

procedure TfmObjectsNew.FormCreate(Sender: TObject);
begin
  inherited;

  //������������� ��������
  qTown.Close;
  qStreet.Close;
  qTypes.Close;

  qTown.Open;
  qStreet.Open;
  qTypes.Open;

  //�������������� ��������� ���������
  actEraser.Execute;
end;

procedure TfmObjectsNew.FormShow(Sender: TObject);
begin
  inherited;

  //������ ������ New
  cxButCreate.Visible:=false;

  //�����������
  MakeColors(false);
end;

end.
