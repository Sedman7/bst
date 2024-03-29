unit uOwners;

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
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  dxSkinsdxBarPainter, System.Actions, Vcl.ActnList, dxBar, cxDBNavigator,
  cxContainer, Vcl.Menus, Vcl.StdCtrls, cxSplitter, cxButtons, cxGroupBox;

type
  TfmOwners = class(TfmBaseGrid)
    grBaseDBTableView1idowner: TcxGridDBColumn;
    grBaseDBTableView1idobject: TcxGridDBColumn;
    grBaseDBTableView1fam: TcxGridDBColumn;
    grBaseDBTableView1name: TcxGridDBColumn;
    grBaseDBTableView1sname: TcxGridDBColumn;
    grBaseDBTableView1phone: TcxGridDBColumn;
    grBaseDBTableView1ownertype: TcxGridDBColumn;
    procedure actCreateExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmOwners: TfmOwners;

implementation

{$R *.dfm}

uses uBaseForm, uRes, uOwnersNew;

procedure TfmOwners.actCreateExecute(Sender: TObject);
begin
//  inherited;
//  qBase.Append;

    fmOwnersNew := TfmOwnersNew.Create(Application);
    fmOwnersNew.Init;
   // fmObjectsNew.Visible:=false;
    fmOwnersNew.ShowModal;

    qBase.Refresh;
end;

procedure TfmOwners.actEditExecute(Sender: TObject);
begin
  inherited;

  //ShowMessage(qBase.Fields.FieldByName('idowner').AsString);

  fmOwnersNew := TfmOwnersNew.Create(Application);
  //fmOwnersNew.Init(qBase.ParamByName('idowner').AsInteger);
  fmOwnersNew.Init;
  fmOwnersNew.loadOwner(qBase.Fields.FieldByName('idowner').AsInteger);
   // fmObjectsNew.Visible:=false;
  fmOwnersNew.ShowModal;

    qBase.Refresh;
    SetStatusView;
end;

procedure TfmOwners.FormShow(Sender: TObject);
begin
  inherited;
  cxButCreate.Visible := True;
end;

end.
