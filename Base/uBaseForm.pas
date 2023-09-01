unit uBaseForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
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
  dxSkinXmas2008Blue, dxSkinsdxBarPainter, cxClasses, dxBar, System.Actions,
  Vcl.ActnList, Vcl.StdCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, cxButtons, cxGroupBox,
  cxSplitter;

type
  TfmBaseForm = class(TForm)
    qBase: TZQuery;
    dsBase: TDataSource;
    ActionList1: TActionList;
    actExit: TAction;
    actCreate: TAction;
    Edit1: TEdit;
    cxGroupBox1: TcxGroupBox;
    cxExit: TcxButton;
    cxButSave: TcxButton;
    actSave: TAction;
    cxSplitter1: TcxSplitter;
    cxButCreate: TcxButton;
    cxButCancel: TcxButton;
    actCancel: TAction;
    actEdit: TAction;
    cxButEdit: TcxButton;
    actRefresh: TAction;
    cxButRefresh: TcxButton;
    cxSplitter2: TcxSplitter;
    actDel: TAction;
    cxButDel: TcxButton;
    actEraser: TAction;
    cxButton1: TcxButton;
    cxSplitter3: TcxSplitter;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actExitExecute(Sender: TObject);
    procedure actCreateExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure cxButCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FormStatus: String; //состояние формы view create edit
    Procedure Init;

    Procedure SetStatusCreate;
    Procedure SetStatusEdit;
    Procedure SetStatusView;
  end;

var
  fmBaseForm: TfmBaseForm;

implementation

{$R *.dfm}

Uses uRes;

Procedure TfmBaseForm.SetStatusCreate;
Begin
  FormStatus:='create';
  cxButSave.Enabled:=true;
  cxButCancel.Enabled:=true;
 // Self.Color:=RGB(200,200,255);
End;

Procedure TfmBaseForm.SetStatusEdit;
Begin
  FormStatus:='edit';
  cxButSave.Enabled:=true;
  cxButCancel.Enabled:=true;
 // Self.Color:=RGB(200,255,255);
End;

Procedure TfmBaseForm.SetStatusView;
Begin
  FormStatus:='view';
  cxButSave.Enabled:=False;
  cxButCancel.Enabled:=False;
 // Self.Color:=clBtnFace;
  //showmessage(GetFormStatus);
End;

procedure TfmBaseForm.actCreateExecute(Sender: TObject);
begin
  SetStatusCreate;
end;

procedure TfmBaseForm.actEditExecute(Sender: TObject);
begin
  SetStatusEdit;
end;

procedure TfmBaseForm.actExitExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfmBaseForm.actRefreshExecute(Sender: TObject);
begin
  qBase.Refresh;
end;

procedure TfmBaseForm.actSaveExecute(Sender: TObject);
Var
  i:integer;
begin
  i:=10;
end;

procedure TfmBaseForm.cxButCancelClick(Sender: TObject);
begin
  qBase.Cancel;
  SetStatusView;
end;

procedure TfmBaseForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FormStatus<>'view' then Begin
    MessageBox(0, 'Остались несохраненне данные.', 'Закончите редактирование.', MB_ICONWARNING or MB_OK);
    action :=caNone;
    exit;
  End
  else Action:=caFree;
end;

procedure TfmBaseForm.FormCreate(Sender: TObject);
begin
  Res.IniWindowLoad(Self,600,400);
  SetStatusView;

end;

procedure TfmBaseForm.FormDestroy(Sender: TObject);
begin
  Res.IniWindowSave(Self);
end;

Procedure TfmBaseForm.Init;
Begin
  //выключаем все кнопки
  cxButCreate.Visible:=false;
  cxButSave.Visible:=false;
  cxButSave.Enabled:=false;
  cxButCancel.Visible:=false;
  cxButCancel.Enabled:=false;
End;

procedure TfmBaseForm.FormShow(Sender: TObject);
begin
  Init;

  //на правах админа
  If uRes.SESSION.bst_Admin then Begin
    cxButCancel.Visible:=true;
    cxButSave.Visible:=true;
    cxButCreate.Visible:=true;
  End;

  //на правах пользователя
  If uRes.SESSION.bst_User then Begin
    cxButCancel.Visible:=true;
    cxButSave.Visible:=true;
    cxButCreate.Visible:=true;
  End;

  //на правах гостя
  If uRes.SESSION.bst_Guest then Begin
    //dxBarButNew.Visible:=ivNever;
  End;
end;

end.
