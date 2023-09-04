unit uObjects;

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
  ZAbstractDataset, ZDataset, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid, cxDBNavigator,
  Vcl.StdCtrls, cxContainer, Vcl.Menus, cxButtons, cxGroupBox, cxSplitter;

type
  TfmObjects = class(TfmBaseGrid)
    grBaseDBTableView1idobject: TcxGridDBColumn;
    grBaseDBTableView1name: TcxGridDBColumn;
    grBaseDBTableView1dom: TcxGridDBColumn;
    grBaseDBTableView1domindex: TcxGridDBColumn;
    grBaseDBTableView1fio: TcxGridDBColumn;
    grBaseDBTableView1phone: TcxGridDBColumn;
    Button1: TButton;
    grBaseDBTableView2: TcxGridDBTableView;
    grBaseDBTableView3: TcxGridDBTableView;
    dsAddInfo: TDataSource;
    qAddInfo: TZQuery;
    qAddInfoidowner: TIntegerField;
    qAddInfoidobject: TIntegerField;
    qAddInfofam: TWideMemoField;
    qAddInfoname: TWideMemoField;
    qAddInfosname: TWideMemoField;
    qAddInfophone: TWideMemoField;
    qAddInfoownertype: TIntegerField;
    grBaseDBTableView1domkorp: TcxGridDBColumn;
    grBaseDBTableView1name_1: TcxGridDBColumn;
    grBaseDBTableView1znach: TcxGridDBColumn;
    cxStyleDisabled: TcxStyle;
    procedure actCreateExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmObjects: TfmObjects;

implementation

{$R *.dfm}

uses uBaseForm, uRes, uObjectsNew;

procedure TfmObjects.actCreateExecute(Sender: TObject);
begin
//  inherited;

    //MessageBox(handle,PChar(' Create '+qBase.FieldByName('idObject').AsString),PChar('Создание объекта'),MB_OK+MB_ICONINFORMATION);

    fmObjectsNew:=TfmObjectsNew.Create(Application);
   // fmObjectsNew.Visible:=false;
    fmObjectsNew.ShowModal;

    qBase.Refresh;

end;

procedure TfmObjects.actDelExecute(Sender: TObject);
begin
  //  inherited;

  MessageBox(handle,PChar(' Delete '+qBase.FieldByName('idObject').AsString),PChar('Удаление объекта'),MB_OK+MB_ICONINFORMATION);

end;

procedure TfmObjects.actEditExecute(Sender: TObject);
begin
  //  inherited;

  MessageBox(handle,PChar(' Edit '+qBase.FieldByName('idObject').AsString),PChar('Редактирование объекта'),MB_OK+MB_ICONINFORMATION);

end;

procedure TfmObjects.FormShow(Sender: TObject);
begin
 // inherited;
  cxButSave.Visible:=false;
  cxButCancel.Visible:=false;
end;

end.
