unit ufrmImportaXMLNFeEntrada;

interface

uses
  Spk.FireDac,Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, UFRMPAI, Grids, DBGrids, StdCtrls, Dbi, Buttons, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Forms,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, DB, ExtCtrls, XMLDoc, xmldom, XMLIntf,
  Menus, ComCtrls, Gauges,FileCtrl, jpeg, DBIUtils, SPK.utils, Mask,msxml, msxmldom,
  Contnrs, System.Math, System.UITypes, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, SPKNFe.LeituraXML,
  cxCheckBox, dxDateRanges, cxDataControllerConditionalFormattingRulesManagerDialog,
  Vcl.CategoryButtons, Vcl.WinXCtrls, System.Actions, Vcl.ActnList, dxSkinsCore,
  dxSkinsDefaultPainters, SPKNFE.LeituraXML.Types, SPKEstoque.Classes,
  dxScrollbarAnnotations;

Type
  TpPessoa = (pEmitente, pDestinatario, pTranspotador);
  TbTributacaoInterna = (bPRO, bCLA, bEST);

  TFrmImportaXMLNFeNotaFiscalEntrada = class(TFrmPai)
    pmGridXMLs: TPopupMenu;
    mnExcluirXml: TMenuItem;
    QueryDeletaRegistros: TSpkFDQuery;
    pmGridItens: TPopupMenu;
    mniVincularItem: TMenuItem;
    mnIrParaNota: TMenuItem;
    mnIrParaCadFornecedor: TMenuItem;
    IrParaoCadastrodeItem1: TMenuItem;
    mniVincularNaturezadeOperao: TMenuItem;
    mniVincularFornecedor: TMenuItem;
    DataSourceSelectDupXML: TDataSource;
    dsCabXML: TDataSource;
    dsItemXML: TDataSource;
    CadastrarFornecedor1: TMenuItem;
    mniAlterarAlmoxarifado: TMenuItem;
    N1: TMenuItem;
    IrParaoPedidodeCompra1: TMenuItem;
    N2: TMenuItem;
    MnuItemVincularDesvincularPedido: TMenuItem;
    UpdSqlRateios: TFDUpdateSQL;
    QueryLookUp: TSpkFDQuery;
    mniConfigClasseFiscal: TMenuItem;
    mniAlterarClasseFiscalDoItem: TMenuItem;
    qryCabXML: TSpkFDQuery;
    gbCabecalhoXML: TGroupBox;
    cxGridCabXML: TcxGrid;
    cxGridCabXMLDBTableView1: TcxGridDBTableView;
    cxGridCabXMLLevel1: TcxGridLevel;
    PgcItemParcelasXML: TPageControl;
    TsItens: TTabSheet;
    tsParcelas: TTabSheet;
    tsLogValidacao: TTabSheet;
    MemoLogValidacao: TMemo;
    qryCabXMLchave: TStringField;
    qryCabXMLserie: TStringField;
    qryCabXMLnumero: TStringField;
    qryCabXMLcnpjemitente: TStringField;
    qryCabXMLcodparceirofornecedor: TIntegerField;
    qryCabXMLvalproduto: TFloatField;
    qryCabXMLvalnf: TFloatField;
    qryCabXMLdtaemissao: TSQLTimeStampField;
    qryCabXMLdtaimportacao: TSQLTimeStampField;
    cxGridItensXML: TcxGrid;
    cxGridItensXMLDBTableView1: TcxGridDBTableView;
    cxGridItensXMLLevel1: TcxGridLevel;
    qryItensXML: TSpkFDQuery;
    qryCabXMLseqnota: TIntegerField;
    qryCabXMLCodNaturezaOperacao: TIntegerField;
    qryCabXMLnomfornecedor: TStringField;
    cxGridCabXMLDBTableView1chave: TcxGridDBColumn;
    cxGridCabXMLDBTableView1serie: TcxGridDBColumn;
    cxGridCabXMLDBTableView1numero: TcxGridDBColumn;
    cxGridCabXMLDBTableView1codparceirofornecedor: TcxGridDBColumn;
    cxGridCabXMLDBTableView1valproduto: TcxGridDBColumn;
    cxGridCabXMLDBTableView1valnf: TcxGridDBColumn;
    cxGridCabXMLDBTableView1dtaemissao: TcxGridDBColumn;
    cxGridCabXMLDBTableView1dtaimportacao: TcxGridDBColumn;
    cxGridCabXMLDBTableView1CodNaturezaOperacao: TcxGridDBColumn;
    cxGridCabXMLDBTableView1nomfornecedor: TcxGridDBColumn;
    qryCabXMLdesnaturezaoperacao: TStringField;
    cxGridCabXMLDBTableView1desnaturezaoperacao: TcxGridDBColumn;
    qryItensXMLchave: TStringField;
    qryItensXMLsequencia: TIntegerField;
    qryItensXMLcodproduto: TStringField;
    qryItensXMLdesproduto: TStringField;
    qryItensXMLncm: TStringField;
    qryItensXMLcfop: TStringField;
    qryItensXMLun: TStringField;
    qryItensXMLqtd: TFloatField;
    qryItensXMLvalunitario: TFloatField;
    qryItensXMLvaltotal: TFloatField;
    qryItensXMLvalfrete: TFloatField;
    qryItensXMLvalseguro: TFloatField;
    qryItensXMLvaloutros: TFloatField;
    qryItensXMLvaldesconto: TFloatField;
    qryItensXMLvalbaseicmsst: TFloatField;
    qryItensXMLvalicmsst: TFloatField;
    qryItensXMLvalbaseipi: TFloatField;
    qryItensXMLmvast: TFloatField;
    cxGridItensXMLDBTableView1codproduto: TcxGridDBColumn;
    cxGridItensXMLDBTableView1desproduto: TcxGridDBColumn;
    cxGridItensXMLDBTableView1ncm: TcxGridDBColumn;
    cxGridItensXMLDBTableView1cfop: TcxGridDBColumn;
    cxGridItensXMLDBTableView1qtd: TcxGridDBColumn;
    cxGridItensXMLDBTableView1valunitario: TcxGridDBColumn;
    cxGridItensXMLDBTableView1valtotal: TcxGridDBColumn;
    cxGridItensXMLDBTableView1valfrete: TcxGridDBColumn;
    cxGridItensXMLDBTableView1valseguro: TcxGridDBColumn;
    cxGridItensXMLDBTableView1valoutros: TcxGridDBColumn;
    cxGridItensXMLDBTableView1valdesconto: TcxGridDBColumn;
    cxGridItensXMLDBTableView1valbaseicmsst: TcxGridDBColumn;
    cxGridItensXMLDBTableView1valicmsst: TcxGridDBColumn;
    cxGridItensXMLDBTableView1valbaseipi: TcxGridDBColumn;
    cxGridItensXMLDBTableView1mvast: TcxGridDBColumn;
    qryItensXMLvalipi: TFloatField;
    cxGridItensXMLDBTableView1valipi: TcxGridDBColumn;
    qryItensXMLCODITEMSPK: TIntegerField;
    qryItensXMLCODUNIDADESPK: TIntegerField;
    qryItensXMLCODATENDIMENTO: TIntegerField;
    qryItensXMLSEQITEM: TIntegerField;
    qryItensXMLdesitem: TStringField;
    cxGridItensXMLDBTableView1CODITEMSPK: TcxGridDBColumn;
    cxGridItensXMLDBTableView1desitem: TcxGridDBColumn;
    cxGridItensXMLDBTableView1desunidade: TcxGridDBColumn;
    qryItensXMLdesunidade: TStringField;
    qryItensXMLDESALMOXARIFADO: TStringField;
    qryItensXMLCODALMOXARIF: TIntegerField;
    cxGridItensXMLDBTableView1DESALMOXARIFADO: TcxGridDBColumn;
    cxGridParcelasXML: TcxGrid;
    cxGridParcelasXMLDBTableView1: TcxGridDBTableView;
    cxGridParcelasXMLLevel1: TcxGridLevel;
    dsParcelasXML: TDataSource;
    qryParcelasXML: TSpkFDQuery;
    qryParcelasXMLchave: TStringField;
    qryParcelasXMLnumero: TStringField;
    qryParcelasXMLdtavencimento: TSQLTimeStampField;
    qryParcelasXMLvalor: TFloatField;
    cxGridParcelasXMLDBTableView1numero: TcxGridDBColumn;
    cxGridParcelasXMLDBTableView1dtavencimento: TcxGridDBColumn;
    cxGridParcelasXMLDBTableView1valor: TcxGridDBColumn;
    UpdateSQLCabXML: TFDUpdateSQL;
    UpdateSQLItensXML: TFDUpdateSQL;
    qryItensXMLEAN: TStringField;
    qryItensXMLnumprecompra: TStringField;
    cxGridItensXMLDBTableView1numprecompra: TcxGridDBColumn;
    cxGridCabXMLDBTableView1seqnota: TcxGridDBColumn;
    splPrincipal: TSplitter;
    cxGridItensXMLDBTableView1Un: TcxGridDBColumn;
    qryItensXMLDesUnidadeItemSpk: TStringField;
    qryItensXMLqtditemconvertido: TFloatField;
    cxGridItensXMLDBTableView1QtdItemConvertido: TcxGridDBColumn;
    cxGridItensXMLDBTableView1DesUnidadeItemSpk: TcxGridDBColumn;
    mniVisualizarDANFE: TMenuItem;
    pgcCabecalho: TPageControl;
    tsImportacaoXml: TTabSheet;
    tsPesquisaImportacoes: TTabSheet;
    gbDadosImportacao: TGroupBox;
    Label6: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    lblProgresso: TLabel;
    edsChaveNFeDownload: TDBIMaskEdit;
    edsDiretorio: TDBIEditString;
    btnSelecionaDiretorio: TDBIBitBtn;
    btnImportarXML: TButton;
    btnTratarXml: TButton;
    chkConfirmaNotaAposInclusao: TCheckBox;
    eddDtaEntradaNotaFiscal: TDBIEditDate;
    btnDownloadXML: TButton;
    ProgessImportacao: TProgressBar;
    gbFiltroBusca: TGroupBox;
    lblFornecedor: TLabel;
    lblIdNFe: TLabel;
    lblPeriodoEmissao: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    Label13: TLabel;
    lblStatus: TLabel;
    eddDtaIniEmNFe: TDBIEditDate;
    eddDtaFinEmNFe: TDBIEditDate;
    edtMaskChaveNFe: TDBIMaskEdit;
    eddDtaImportacaoIni: TDBIEditDate;
    eddDtaImportacaoFim: TDBIEditDate;
    edsNumNFe: TDBIEditString;
    btnPesquisaAvancada: TButton;
    btnLimparFiltrosPesquisa: TButton;
    dlkFornecedor: TDBILookupDialog;
    cbbSituacaoArquivos: TDBIComboBox;
    qryItensXMLcodreferencia: TStringField;
    qryItensXMLcodreferenciacompra: TStringField;
    cxGridItensXMLDBTableView1CodReferencia: TcxGridDBColumn;
    cxGridItensXMLDBTableView1CodReferenciaCompra: TcxGridDBColumn;
    qryItensXMLCodUnidadeItemSPK: TIntegerField;
    qryItensXMLQtdFatorConvUnidade: TFloatField;
    qryItensXMLConversaoUnidadeOK: TBooleanField;
    cxGridItensXMLDBTableView1ConversaoUnidadeOK: TcxGridDBColumn;
    qryItensXMLItemVinculado: TBooleanField;
    qryItensXMLAlmoxarifadoVinculado: TBooleanField;
    qryItensXMLPedidoVinculado: TBooleanField;
    cxGridItensXMLDBTableView1ItemVinculado: TcxGridDBColumn;
    cxGridItensXMLDBTableView1AlmoxarifadoVinculado: TcxGridDBColumn;
    cxGridItensXMLDBTableView1PedidoVinculado: TcxGridDBColumn;
    clGridItensXMLDBTableView1NcmSPK: TcxGridDBColumn;
    qryItensXMLncmspk: TStringField;
    qryCabXMLXML: TMemoField;
    mmFerramentas: TMainMenu;
    ExportarArquivos1: TMenuItem;
    Ferramentas1: TMenuItem;
    pnlBotoes: TPanel;
    grpFluxo: TGroupBox;
    lblVenc: TLabel;
    lblValParcela: TLabel;
    lblCarencia: TLabel;
    lblQtdeParc: TLabel;
    lblIntervalo: TLabel;
    lblValrRest: TLabel;
    btnCapturaValParcela: TSpeedButton;
    ednValOriginal: TDBIEditNumber;
    eddDtaVencimento: TDBIEditDate;
    ednQtdParcelas: TDBIEditNumber;
    ednQtdIntervalo: TDBIEditNumber;
    cbParcelasDiaFixo: TDBICheckBox;
    btnIncluiParcela: TButton;
    btnExcluiParcela: TButton;
    btnExcluirTodasParcelas: TButton;
    btnLimpaParcela: TButton;
    ednValRestante: TDBIEditNumber;
    ednCarencia: TDBIEditNumber;
    btnReimportar: TSpeedButton;
    qryParcelasXMLTotParcelas: TAggregateField;
    qryCabXMLcodtipooperacao: TIntegerField;
    qryCabXMLdestipooperacao: TStringField;
    cxGridCabXMLDBTableView1CodTipooperacao: TcxGridDBColumn;
    cxGridCabXMLDBTableView1DesTipoOperacao: TcxGridDBColumn;
    mniVincularTipoOperacao: TMenuItem;
    qryItensXMLeantrib: TStringField;
    cxtvGridItensXMLDBTableView1SeqItemPreCompra: TcxGridDBColumn;
    pnlRodapeItens: TPanel;
    btnGrades: TButton;
    btnLotes: TButton;
    mniAlterarGrades: TMenuItem;
    mniAlterarLotes: TMenuItem;
    qryItensXMLindtipocontrole: TStringField;
    qryItensXMLqtdgrades: TFloatField;
    qryItensXMLqtdlotes: TFloatField;
    qryItensXMLGradesOk: TBooleanField;
    qryItensXMLLotesOk: TBooleanField;
    clGridItensXMLDBTableView1GradesOk: TcxGridDBColumn;
    clGridItensXMLDBTableView1LotesOk: TcxGridDBColumn;
    qryItensXMLpericmsst: TFloatField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnImportarXMLClick(Sender: TObject);
    procedure edsDiretorioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSelecionaDiretorioClick(Sender: TObject);
    procedure mnIrParaNotaClick(Sender: TObject);
    procedure mnIrParaCadFornecedorClick(Sender: TObject);
    procedure IrParaoCadastrodeItem1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure mniVincularNaturezadeOperaoClick(Sender: TObject);
    procedure mniVincularFornecedorClick(Sender: TObject);
    procedure CadastrarFornecedor1Click(Sender: TObject);
    procedure pmGridXMLsPopup(Sender: TObject);
    procedure mniAlterarAlmoxarifadoClick(Sender: TObject);
    procedure pmGridItensPopup(Sender: TObject);
    procedure MnuItemVincularDesvincularPedidoClick(Sender: TObject);
    procedure IrParaoPedidodeCompra1Click(Sender: TObject);
    procedure btnLimparFiltrosPesquisaClick(Sender: TObject);
    procedure btnPesquisaAvancadaClick(Sender: TObject);
    procedure mniConfigClasseFiscalClick(Sender: TObject);
    procedure mniAlterarClasseFiscalDoItemClick(Sender: TObject);
    procedure cxGridCabXMLDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure qryCabXMLAfterScroll(DataSet: TDataSet);
    procedure qryCabXMLAfterClose(DataSet: TDataSet);
    procedure cxGridItensXMLDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure mnExcluirXmlClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnTratarXmlClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnDownloadXMLClick(Sender: TObject);
    procedure mniVisualizarDANFEClick(Sender: TObject);
    procedure chkConfirmaNotaAposInclusaoClick(Sender: TObject);
    procedure cxGridCabXMLDBTableView1CellDblClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure edsChaveNFeDownloadKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure qryItensXMLCalcFields(DataSet: TDataSet);
    procedure ExportarArquivos1Click(Sender: TObject);
    procedure btnReimportarClick(Sender: TObject);
    procedure btnExcluiParcelaClick(Sender: TObject);
    procedure btnExcluirTodasParcelasClick(Sender: TObject);
    procedure btnIncluiParcelaClick(Sender: TObject);
    procedure ednCarenciaChange(Sender: TObject);
    procedure btnLimpaParcelaClick(Sender: TObject);
    procedure mniVincularTipoOperacaoClick(Sender: TObject);
    procedure btnCapturaValParcelaClick(Sender: TObject);
    procedure ednQtdParcelasChange(Sender: TObject);
    procedure mniVincularItemClick(Sender: TObject);
    procedure mniAlterarGradesClick(Sender: TObject);
    procedure mniAlterarLotesClick(Sender: TObject);
    procedure btnGradesClick(Sender: TObject);
    procedure btnLotesClick(Sender: TObject);
  private
    fLeituraXML: TSPKNFeLeituraXML;
    fValTotalParcelas: Currency;
    FListaSelecaoGrade: TListaSelecaoGrade;
    FListaSelecaoLotes: TListSPKLFI;
    function GetListaArquivosXMLNoDiretorio: TStringList;
    function VinculaPedidoCompra: Boolean;
    function DesvinculaPedidoCompra: Boolean;
    procedure TrataAtualizacaoPreco(aSeqNota: Integer; aCodNOP: Integer);
    procedure SetMaxProgresso(aValue: Integer);
    procedure IncPbProgresso;
    procedure SetMemoLogValidacao(aMsg: string);
    procedure LimpoDadosFiltro;
    procedure PesquisaXMLNFeImportacao(aDtaHrImportacao: TDateTime = 0);
    procedure PesquisaItensXMLCorrente;
    procedure PesquisaParcelasXMLCorrente;
    procedure PintaCanvas(Sender: TcxCanvas; aCorFundo, aCorFonte: TColor);
    procedure OpenQryCabXML;
    procedure PostQryCabXML;
    procedure ApplyUpdatesQryCabXML;
    procedure VisualizarDANFE;
    procedure CalculaParcelaRestante;
    procedure LimpaCamposParcelas;
    function ValidaFluxoParcelas: Boolean;
    function PermiteEdicao(): Boolean;
    function TecnoSpeedCarregado: Boolean;
    function ListaSelecaoLoteToListaVariacao: TListaVariacoesProdXml;
    function ListaSelecaoGradeToListaVariacao: TListaVariacoesProdXml;
    procedure VariacaoToListaSelecaoGrade;
    procedure VariacaoToListaSelecaoLote;
    procedure VincularItem;
    procedure AlterarGradesItem;
    procedure AlterarLotesItem;
  public
    ItemMenu: TMenuItem;
    procedure ImportaXMLDiretorio(aDiretorio: String);
  end;

var
  FrmImportaXMLNFeNotaFiscalEntrada: TFrmImportaXMLNFeNotaFiscalEntrada;

implementation

uses
  Empresa.InterfaceEmpresa,SPKFalha.Consts,SPKFalha, SPKBancoDados.DMConexaoSPK,
  SPKParametros.InterfaceParametros,SPK.Consts.ProgramasModulosFuncoes, USUARIO.InterfaceUsuario,
  MenuPrincipal, SPKBIBLIOTECA, SPKBibli, ufrmCadastroCidade,
  UfrmItensXML, uDataModulePrincipal, ufrmCadastroPessoa, uFrmNotaFiscalEntrada, uFrmCadastroItem,
  ConvertFunctionFBOracle, SPK.Classes.Consts, SPK.Classes, ufrmSelecionaAlmoxarifadoXmlEntrada,
  EntradaPCompra, uFrmLancarEntradaMercadoriaPreCompra, uFrmPreCompra, uDmImagens,
  uDataModuleIntegracaoFiscalContabilRH, SPKFalha.LogErro, uOperacoesNotaEntrada, uFrmItemsAtualizaPreco,
  uFrmIncluiDadosClasseFiscal, SPKTributacao.InterfaceSpkTributacao, uFrmAlteraClasseFiscalItem,
  SPKEstoque.InterfaceEstoque, uTraduzDevExpress, System.StrUtils, SPKParceiro.InterfaceParceiro,
  Endereco.InterfaceEndereco, NotaFiscalEntrada.InterfaceNotaFiscalEntrada, uDMCompTecnoSpeed,
  uFrmExportarArquivosNFe, FormControl, uFrmGradeItem, ufrmEntradaLoteItem;

{$R *.dfm}

procedure TFrmImportaXMLNFeNotaFiscalEntrada.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  TFuncoesCXGrid.SaveGridControl(cxGridCabXMLDBTableView1,900,1);
  TFuncoesCXGrid.SaveGridControl(cxGridItensXMLDBTableView1,900,2);
  TFuncoesCXGrid.SaveGridControl(cxGridParcelasXMLDBTableView1,900,3);
  ItemMenu.Checked := False;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.FormCreate(Sender: TObject);
begin
  inherited;
  SetResorcePortugues;
  pgcCabecalho.ActivePage := tsImportacaoXml;
  PgcItemParcelasXML.ActivePage := tsItens;
  TFuncoesCXGrid.LoadGridControl(cxGridCabXMLDBTableView1,900,1);
  TFuncoesCXGrid.LoadGridControl(cxGridItensXMLDBTableView1,900,2);
  TFuncoesCXGrid.LoadGridControl(cxGridParcelasXMLDBTableView1,900,3);
  if Trim(DadosEmpresa.DadosSPKEMPCFGNFE.dir_download_xml) <> '' then
    edsDiretorio.SetValue(DadosEmpresa.DadosSPKEMPCFGNFE.dir_download_xml);
  fLeituraXML := TSPKNFeLeituraXML.Create(True);
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(fLeituraXML);
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.PostQryCabXML;
var
  _EventAfterScroll: TDataSetNotifyEvent;
begin
  _EventAfterScroll := qryCabXML.AfterScroll;
  try
    qryCabXML.AfterScroll := Nil;
    qryCabXML.Post;
  finally
    qryCabXML.AfterScroll := _EventAfterScroll;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.AlterarGradesItem;
const
  cMsgTipoControle = 'O item %s não é controlado por grade';
  cMsgItem = 'É necessário primeiramente vincular o item';
var
  _DadosItem: TDadosItem;
  _ListaVariacao: TListaVariacoesProdXml;
begin
  inherited;
  if not qryItensXML.IsEmpty then
  begin
    if qryCabXMLseqnota.AsInteger > 0 then
      MessageDlg('A nota já foi importada', mtWarning, [mbOK], 0)
    else
    begin
      if qryItensXMLIndTipoControle.AsString <> 'G' then
        MessageDlg(Format(cMsgTipoControle, [qryItensXMLdesitem.AsString]), mtWarning, [mbOk], 0)
      else if not qryItensXMLItemVinculado.AsBoolean then
        MessageDlg(cMsgItem, mtWarning, [mbOk], 0)
      else
      begin
        _DadosItem := TInterfaceEstoque.Estoque.GetDadosItem(qryItensXMLCodItemSpk.AsInteger);
        Self.VariacaoToListaSelecaoGrade;

        if TModalGradeItem.GetQtdGradesSelecionadas(_DadosItem,
                                                    FListaSelecaoGrade,
                                                    qryItensXMLqtd.AsFloat) then
        begin
          _ListaVariacao := Self.ListaSelecaoGradeToListaVariacao;

          DMConexaoSPk.DBGenerico.StartTransaction;
          try
            fLeituraXML.SubstituiListaVariacao(_ListaVariacao);
            DMConexaoSPk.CommitFDConnection(DMConexaoSPk.DBGenerico);
            Self.PesquisaItensXMLCorrente;
          except
            on e:exception do
            begin
              DMConexaoSPk.RollBackFDConnection(DMConexaoSPk.DBGenerico);
              RaiseSpk(e, e.Message);
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.AlterarLotesItem;
const
  cMsgTipoControle = 'O item %s não é controlado por lote';
  cMsgItem = 'É necessário primeiramente vincular o item';
var
  _DadosItem: TDadosItem;
  _ListaVariacao: TListaVariacoesProdXml;
begin
  inherited;
  if not qryItensXML.IsEmpty then
  begin
    if qryCabXMLseqnota.AsInteger > 0 then
      MessageDlg('A nota já foi importada', mtWarning, [mbOK], 0)
    else
    begin
      if qryItensXMLIndTipoControle.AsString <> 'L' then
        MessageDlg(Format(cMsgTipoControle, [qryItensXMLdesitem.AsString]), mtWarning, [mbOk], 0)
      else if not qryItensXMLItemVinculado.AsBoolean then
        MessageDlg(cMsgItem, mtWarning, [mbOk], 0)
      else
      begin
        _DadosItem := TInterfaceEstoque.Estoque.GetDadosItem(qryItensXMLCodItemSpk.AsInteger);
        Self.VariacaoToListaSelecaoLote;

        if TModalEntradaLotesItem.GetListaLotes(_DadosItem,
                                                FListaSelecaoLotes,
                                                qryItensXMLqtd.AsFloat) then
        begin
          _ListaVariacao := Self.ListaSelecaoLoteToListaVariacao;

          DMConexaoSPk.DBGenerico.StartTransaction;
          try
            fLeituraXML.SubstituiListaVariacao(_ListaVariacao);
            DMConexaoSPk.CommitFDConnection(DMConexaoSPk.DBGenerico);
            Self.PesquisaItensXMLCorrente;
          except
            on e:exception do
            begin
              DMConexaoSPk.RollBackFDConnection(DMConexaoSPk.DBGenerico);
              RaiseSpk(e, e.Message);
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.ApplyUpdatesQryCabXML;
var
  _EventAfterScroll: TDataSetNotifyEvent;
begin
  _EventAfterScroll := qryCabXML.AfterScroll;
  try
    qryCabXML.AfterScroll := Nil;
    DMConexaoSPK.AplicaAtualizacoesModoBDE(qryCabXML);
  finally
    qryCabXML.AfterScroll := _EventAfterScroll;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.btnCapturaValParcelaClick(
  Sender: TObject);
begin
  inherited;
  ednValOriginal.SetValue(ednValRestante.GetValue);
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.btnDownloadXMLClick(
  Sender: TObject);
var
  _DMCompTecSp: TDMCompTecnoSpeed;
  _XML: string;
  _DtaHrImportacao: TDateTime;
begin
  if (Self.TecnoSpeedCarregado) then
  begin
    if (Trim(edsChaveNFeDownload.GetValue) = '') then
      MessageDlg('Informe a chave.', mtWarning, [mbOK],0)
    else if (length(edsChaveNFeDownload.GetValue) <> 44) then
      MessageDlg('A chave informada deve conter exatamente 44 posições.', mtWarning, [mbok],0)
    else
    begin
      Self.Enabled := False;
      try
        MemoLogValidacao.Clear;
        PgcItemParcelasXML.ActivePage := tsLogValidacao;
        _DMCompTecSp := TDMCompTecnoSpeed.Create(Self);
        try
          _DMCompTecSp.ConfigCompNFe(DadosEmpresa);
          _XML := _DMCompTecSp.ManifestarCienciaEDownloadXMLNFe(edsChaveNFeDownload.GetValue);

          if _XML <> '' then
          begin
            _DtaHrImportacao := DMConexaoSPK.ObtemDataHoraAtual;
            DMConexaoSPK.DBGenerico.StartTransaction;
            try
              fLeituraXML.IncluirXMLNFeImportado(
                   fLeituraXML.ConvertXMLToTDadosSPKXMLNFe(_XML),_DtaHrImportacao);
              DMConexaoSPK.CommitFDConnection(DMConexaoSPK.DBGenerico);
            except
              on E: Exception do
              begin
                DMConexaoSPK.RollBackDentroException(DMConexaoSPK.DBGenerico);
                E.Message := TSPKFalha.GetMsgExceptionSPK(E);
                Self.SetMemoLogValidacao(E.Message);
              end;
            end;

            Self.LimpoDadosFiltro;
            Self.PesquisaXMLNFeImportacao(_DtaHrImportacao);
          end;
        finally
          FreeAndNil(_DMCompTecSp);
        end;
      finally
        Self.Enabled := True;
        dlkFornecedor.Show;
        dlkFornecedor.SetFocus;
      end;
    end;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.btnExcluiParcelaClick(
  Sender: TObject);
begin
  inherited;
  if (Self.TecnoSpeedCarregado) then
  begin
    if (Self.PermiteEdicao) then
    begin
      Self.fValTotalParcelas := Self.fValTotalParcelas - qryParcelasXMLvalor.AsCurrency;
      Self.fLeituraXML.DeleteXMLNfeImportado_cobr(qryCabXMLchave.AsString, qryParcelasXMLnumero.AsString);

      qryParcelasXML.Refresh;
      Self.CalculaParcelaRestante;
    end;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.btnExcluirTodasParcelasClick(
  Sender: TObject);
begin
  inherited;
  if (Self.TecnoSpeedCarregado) then
  begin
    if (Self.PermiteEdicao) then
    begin
      Self.fValTotalParcelas := 0;
      Self.fLeituraXML.DeleteXMLNfeImportado_cobr(qryCabXMLchave.AsString, '');

      qryParcelasXML.Refresh;
      Self.CalculaParcelaRestante;
    end;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.btnGradesClick(Sender: TObject);
begin
  inherited;
  Self.AlterarGradesItem;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.btnImportarXMLClick(Sender: TObject);
begin
  self.ImportaXMLDiretorio(edsDiretorio.GetValue);
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.btnIncluiParcelaClick(
  Sender: TObject);
var
  _Contador,
  _NumParcela: Integer;
  _Ano,
  _Mes,
  _Dia,
  _DiaFixo,
  _UltimoDiaMes: Word ;
  _DtaVencim: TDateTime;
  _ValResidual: Currency;

  function GetDtaVencimento: TDateTime;
  begin
    try
      if cbParcelasDiaFixo.Checked then
      begin
        DecodeDate(_DtaVencim, _Ano, _Mes, _Dia);

        if _Mes = 12 then
        begin
          _Mes := 1;
          _Ano := _Ano + 1;
        end
        else
          _Mes := _Mes + 1;

        _UltimoDiaMes := MonthDays[IsLeapYear(_Ano), _Mes];

        if _DiaFixo > _UltimoDiaMes then
          _Dia := _UltimoDiaMes
        else
          _Dia := _DiaFixo;

        Result := StrToDate(FloatToStr(_Dia) + '/' + FloatToStr(_Mes) + '/' + FloatToStr(_Ano));
      end
      else
        Result := _DtaVencim + Trunc(ednQtdIntervalo.GetValue);
    except
      on E: Exception do
        RaiseSPK(E,E.Message);
    end;
  end;

  function GetNumParcela: Integer;
  var
    _Bm: TBookMark;
  begin
    Result := 0;
    try
      _Bm := qryParcelasXML.GetBookMark;
      qryParcelasXML.DisableControls;
      try
        qryParcelasXML.First;
        while not qryParcelasXML.EOF do
        begin
          if StrToInt(qryParcelasXML.FieldByName('numero').AsString) > Result then
            Result := StrToInt(qryParcelasXML.FieldByName('numero').AsString);
          qryParcelasXML.Next;
        end;
      finally
        qryParcelasXML.GotoBookMark(_Bm);
        qryParcelasXML.EnableControls;
      end;
      Inc(Result);
    except
      on E: Exception do
        RaiseSPK(E,E.Message);
    end;
  end;
begin
  if (Self.TecnoSpeedCarregado) then
  begin
    if (Self.ValidaFluxoParcelas) then
    begin
      inherited;
      _Contador := 1;
      fValTotalParcelas := 0;
      _ValResidual := 0;
      _DtaVencim := eddDtaVencimento.GetValue;
      DecodeDate(_DtaVencim, _Ano, _Mes, _Dia);
      _DiaFixo := _Dia;

      while _Contador <= Trunc(ednQtdParcelas.GetValue) do
      begin
        _NumParcela := GetNumParcela;

       if _ValResidual + ednValOriginal.GetValue > qryCabXMLvalnf.AsCurrency then
       begin
          _ValResidual := qryCabXMLvalnf.AsCurrency - _ValResidual;
          fLeituraXML.GetDadosXMLNFeCobranca(qryCabXMLchave.AsString, IntToStr(_NumParcela), _DtaVencim, RoundTo(_ValResidual, -2));
       end
       else
       begin
          _ValResidual := _ValResidual + ednValOriginal.GetValue;
          fLeituraXML.GetDadosXMLNFeCobranca(qryCabXMLchave.AsString, IntToStr(_NumParcela), _DtaVencim, RoundTo(ednValOriginal.GetValue, -2));
       end;

        Inc(_Contador);
        _DtaVencim := GetDtaVencimento;
        qryParcelasXML.Refresh;
      end;

      fValTotalParcelas := VarToFloat(qryparcelasXML.Aggregates[0].Value);
      self.CalculaParcelaRestante;
      self.LimpaCamposParcelas;
    end;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.btnLimpaParcelaClick(
  Sender: TObject);
begin
  inherited;
  self.LimpaCamposParcelas;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.btnLimparFiltrosPesquisaClick(Sender: TObject);
begin
  Self.LimpoDadosFiltro;
  dlkFornecedor.Show;
  dlkFornecedor.SetFocus;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.btnLotesClick(Sender: TObject);
begin
  inherited;
  Self.AlterarLotesItem;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.btnPesquisaAvancadaClick(Sender: TObject);
begin
  if TInterfaceUsuario.Usuario.VerificaAcessoPrograma(ItemMenu.Tag, fPesquisar, True) then
  begin
    Self.PesquisaXMLNFeImportacao;
    if qryCabXML.IsEmpty then
      MessageDlg('Nenhum registro selecionado', mtInformation, [mbOK],0)
    else
    begin
      cxGridCabXML.Show;
      cxGridCabXML.SetFocus;
      cxGridCabXMLDBTableView1.DataController.SyncSelectionFocusedRecord;
    end;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.btnReimportarClick(
  Sender: TObject);
var
  _Qry : TSPKFDQuery;
begin
  inherited;
  if (Self.TecnoSpeedCarregado) then
  begin
    if (Self.PermiteEdicao) then
    begin
      if MessageDlg('Para importar os dados de cobrança do XML é necessário limpar os registros atuais, deseja continuar?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        Self.btnExcluirTodasParcelasClick(nil);

        try
          _Qry := DMConexaoSPK.GetFDQueryOpen('select xml.xml from xmlnfeimportado xml where xml.chave = ' + QuotedStr(qryCabXMLchave.AsString));
          Self.fLeituraXML.GetDadosXMLNFeImportadoCobranca(Self.fLeituraXML.ConvertXMLToTDadosSPKXMLNFe(_Qry.FieldByName('XML').AsString));
        finally
          FreeAndNil(_Qry);
        end;
      end;
    end;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.mniVincularFornecedorClick(Sender: TObject);
var
  _Cod, _Des, _CabCons, _Campo1, _Campo2, _TabCons, _Filtro, _CNPJFornecedor: String;
begin
  if (not qryCabXML.IsEmpty) then
  begin
    if PermiteEdicao then
     begin
      _Cod := '';
      _Des := '';
      _CabCons := 'Pesquisa Fornecedor';
      _Filtro := ' a.indfornecedor = ''S'' and a.indpessoaativa = ''S''';
      _TabCons := 'SPKPARC';
      _Campo1 := ' codparceiro';
      _Campo2 := ' nomparceiro';
      if TBuscaGeral.Create.BuscaGeralParceiro(_CabCons,_Filtro,_TabCons,_Campo1,_Campo2, _Cod, _Des)then
      begin
        _CNPJFornecedor := TInterfaceParceiro.SpkParceiro.GetDadosSPKPARC(StrToInt(_Cod)).NUMCNPJCPF;
        if (Trim(qryCabXMLcnpjemitente.AsString) <> _CNPJFornecedor) then
        begin
          MessageDlg('CNPJ do fornecedor selecionado: ' + TClasseFormatos.FormataStrCnpjCpf(_CNPJFornecedor) +
                     ' diferente do emitente da NF-e: ' +
                     TClasseFormatos.FormataStrCnpjCpf(qryCabXMLcnpjemitente.AsString), mtWarning, [mbok], 0);
        end
        else
        begin
          qryCabXML.Edit;
          qryCabXMLcodparceirofornecedor.AsInteger := StrToInt(_Cod);
          qryCabXMLnomfornecedor.AsString := _Des;
          Self.PostQryCabXML;
          Self.ApplyUpdatesQryCabXML;
        end;
      end;
    end;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.mniVincularItemClick(
  Sender: TObject);
begin
  inherited;
  Self.VincularItem;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.mniVincularNaturezadeOperaoClick(Sender: TObject);
var
  Cod, Des, CabCons, Campo1, Campo2, TabCons, Filtro : String;
  _DadosFornecedor: TDadosFornecedor;
  _QryBuscaCodTipoOperacao : TSPKFDQuery;
begin
  if (not qryCabXML.IsEmpty) then
  begin
    if PermiteEdicao then
    begin
      if qryCabXMLcodparceirofornecedor.AsInteger > 0 then
      begin
        Cod := '';
        Des := '';
        CabCons := 'Pesquisa Natureza de Operação';
        _DadosFornecedor := TInterfaceParceiro.SpkParceiro.GetDadosFornecedor(qryCabXMLcodparceirofornecedor.AsInteger);

        if (_DadosFornecedor.DadosCidade.DADOSESTADO.DADOSPAIS.CODIGOPAIS.ToString <> DadosEmpresa.codigoPais) and
           (_DadosFornecedor.DadosCidade.DADOSESTADO.DADOSPAIS.CODIGOPAIS > 0)then
          Filtro := ' a.indorigemdestino  = ''X'''
        else if _DadosFornecedor.DadosCidade.DADOSESTADO.CODIGOESTADO.ToString <> DadosEmpresa.codigo_estado then
          Filtro := ' a.indorigemdestino  = ''F'''
        else
          Filtro := ' a.indorigemdestino  = ''D''';
        Filtro := Filtro + ' and a.indentradasaida = ''E'' and a.numcfop is not null';

        TabCons := 'SPKON a ';
        Campo1 := 'a.codnaturezaOperacao';
        Campo2 := 'case                                                                            ' + sLineBreak +
                  '   when Trim(a.codreduzido) <> '''' then                                        ' + sLineBreak +
                  '       a.numcfop || '' - '' || a.codreduzido || '' - '' || a.desnaturezaoperacao' + sLineBreak +
                  '   else                                                                         ' + sLineBreak +
                  '       a.numcfop || '' - '' || a.desnaturezaoperacao                            ' + sLineBreak +
                  'end                                                                             ';

        if TBuscaGeral.Create.BuscaGeral(CabCons,Filtro,TabCons,Campo1,Campo2, Cod, Des)then
        begin
          qryCabXML.Edit;
          qryCabXMLCodNaturezaOperacao.AsInteger := StrToInt(Cod);
          qryCabXMLdesnaturezaoperacao.AsString := Des;

          try
            _QryBuscaCodTipoOperacao := DMConexaoSPK.GetFDQuery('select spkon.codtipooperacao, spkto.destipooperacao ' + slinebreak +
                                                                'from spkon ' + slinebreak +
                                                                '     inner join spkto on spkto.codtipooperacao = spkon.codtipooperacao ' + slinebreak +
                                                                'where spkon.codnaturezaoperacao = ' + IntToStr(qryCabXMLCodNaturezaOperacao.AsInteger));
            _QryBuscaCodTipoOperacao.Open();

            if not _QryBuscaCodTipoOperacao.isEmpty then
            begin
              qryCabXML.Edit;
              qryCabXMLCodTipoOperacao.AsInteger := _QryBuscaCodTipoOperacao.FieldByName('codtipooperacao').AsInteger;
              qryCabXMLdestipooperacao.AsString := _QryBuscaCodTipoOperacao.FieldByName('destipooperacao').AsString;
            end;
          finally
            FreeAndNil(_QryBuscaCodTipoOperacao);
          end;

          Self.PostQryCabXML;
          Self.ApplyUpdatesQryCabXML;
        end
        else
          MessageDlg('Necessário verificar a cidade de Origem do Fornecedor e/ou as configurações da Natureza de Operação.', mtWarning, [mbOk], 0);
      end
      else
        MessageDlg('Para vincular natureza operação, deve ter vinculado o fornecedor.',mtWarning,[mbOk],0);
    end;
  end
  else
    MessageDlg('Não existe dados para alterar.',mtWarning,[mbOk],0);
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.mniVincularTipoOperacaoClick(
  Sender: TObject);
var
  cod, des: string;
begin
  inherited;
  if (not qryCabXML.IsEmpty) then
  begin
    if qryCabXMLcodparceirofornecedor.AsInteger > 0 then
    begin
      Cod := '';
      Des := '';

      if TBuscaGeral.Create.BuscaGeralTipoOperacao('a.indtipo = '+ sPipe + 'O' + sPipe  + ' and a.INDDESPESARECEITA IN(' + '''D'',' + '''H'')', cod ,Des)then
      begin
        qryCabXML.Edit;
        qryCabXMLCodTipoOperacao.AsInteger := StrToInt(Cod);
        qryCabXMLdesTipoOperacao.AsString := Des;
        Self.PostQryCabXML;
        Self.ApplyUpdatesQryCabXML;
      end;
    end
    else
      MessageDlg('Para vincular tipo de operação, deve ter vinculado o fornecedor.',mtWarning,[mbOk],0);
  end
  else
    MessageDlg('Não existe dados para alterar.',mtWarning,[mbOk],0);
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.mniVisualizarDANFEClick(
  Sender: TObject);
begin
  Self.VisualizarDANFE;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.pmGridItensPopup(Sender: TObject);
begin
  if not qryItensXML.IsEmpty then
  begin
    if qryItensXMLCODITEMSPK.AsInteger > 0 then
     mniVincularItem.Caption := 'Alterar item vinculado'
    else
     mniVincularItem.Caption := 'Vincular item';

    mniConfigClasseFiscal.Enabled := mniVincularItem.Enabled;
    mniAlterarClasseFiscalDoItem.Enabled := mniVincularItem.Enabled;

    if qryItensXMLCODATENDIMENTO.AsInteger > 0  then
     MnuItemVincularDesvincularPedido.Caption := 'Desvincular item do Pedido de Compra'
    else
     MnuItemVincularDesvincularPedido.Caption := 'Vincular item a um Pedido de Compra';
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.pmGridXMLsPopup(Sender: TObject);
begin
  CadastrarFornecedor1.Enabled := (not (qryCabXMLcodparceirofornecedor.AsInteger > 0));
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.CadastrarFornecedor1Click(Sender: TObject);
var
  _DadosSPKPARC: TDadosSpkParc;
  _DadosXMLNFe: TDadosSPKXMLNFe;
begin
  if (Self.TecnoSpeedCarregado) then
  begin
    if not qryCabXML.IsEmpty then
    begin
      _DadosSPKPARC := TInterfaceParceiro.SpkParceiro.GetDadosSPKPARCPorCPFCNPJ(qryCabXMLcnpjemitente.AsString);
      if _DadosSPKPARC.CODPARCEIRO <= 0 then
      begin
        if Trim(qryCabXMLXML.AsString) <> '' then
        begin
          _DadosXMLNFe := fLeituraXML.ConvertXMLToTDadosSPKXMLNFe(qryCabXMLXML.AsString);
          if TFormControl.AbreTelaSolicitada(21) then
          begin
            FrmCadastroPessoa.DBIOperator.DoClear;
            FrmCadastroPessoa.edsNOMPARCEIRO.SetFocus;
            FrmCadastroPessoa.cbIndPEPessoaAtiva.Checked := False;
            FrmCadastroPessoa.cbIndPENatureza.Checked := False;
            FrmCadastroPessoa.cbIndPEClassificacao.Checked := False;
            FrmCadastroPessoa.cbIndSacador.Checked := True;
            FrmCadastroPessoa.cbIndFornecedor.Checked := True;
            FrmCadastroPessoa.edsNOMPARCEIRO.SetValue(_DadosXMLNFe.emit.Nome);
            if Length(_DadosXMLNFe.emit.CNPJ) > 11 then
            begin
              FrmCadastroPessoa.rbJuridica.Checked := True;
              FrmCadastroPessoa.edsNumIERG.SetValue(_DadosXMLNFe.emit.IE);
              FrmCadastroPessoa.edsNomFantasia.SetValue(_DadosXMLNFe.emit.Fantasia);
            end
            else
              FrmCadastroPessoa.rbFisica.Checked := True;
            FrmCadastroPessoa.meNumCGCCPF.SetValue(_DadosXMLNFe.emit.CNPJ);
            FrmCadastroPessoa.edsNum.SetValue(_DadosXMLNFe.emit.Numero);
            FrmCadastroPessoa.edsNumCep.SetValue(_DadosXMLNFe.emit.Cep);
            FrmCadastroPessoa.ednCodCidade.SetFocus;
            FrmCadastroPessoa.ednCodCidade.SetValue(TInterfaceEndereco.Endereco.GetDadosCidadePeloCodMunicipioIBGE(_DadosXMLNFe.emit.CodMun).CODCIDADE);
            FrmCadastroPessoa.ednCodBairro.SetFocus;
            FrmCadastroPessoa.ednCodBairro.SetValue(TInterfaceEndereco.Endereco.GetCadastraDadosBairro(_DadosXMLNFe.emit.Bairro).CodBairro);
            FrmCadastroPessoa.ednCodLogradouro.SetFocus;
            FrmCadastroPessoa.ednCodLogradouro.SetValue(TInterfaceEndereco.Endereco.GetCadastraDadosLogradouro(_DadosXMLNFe.emit.Logradouro).CODLOGRADOURO);
            FrmCadastroPessoa.edsDesComplemento.SetValue(_DadosXMLNFe.emit.Complemento);
            FrmCadastroPessoa.edsNumTelefone1.SetFocus;
            FrmCadastroPessoa.edsNumTelefone1.SetValue(_DadosXMLNFe.emit.Telefone);
            FrmCadastroPessoa.edsNOMPARCEIRO.SetFocus;
          end;
        end
        else
          MessageDlg('Registro sem xml salvo no BD.',mtWarning,[mbOk],0);
      end
      else
        MessageDlg(Format('Já existe parceiro cadastrado com CNPJ (%s). CodParceiro: %s.',[qryCabXMLcnpjemitente.AsString,IntToStr(_DadosSPKPARC.CODPARCEIRO)]),
                          mtWarning,
                          [mbOk],
                          0);
    end
    else
      MessageDlg('Sem dados para inclusão fornecedor.',mtWarning,[mbOk],0);
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.CalculaParcelaRestante;
begin
  try
    if (fValTotalParcelas < qryCabXMLvalnf.AsCurrency) then
      ednValRestante.SetValue(qryCabXMLvalnf.AsCurrency - fValTotalParcelas)
    else
      ednValRestante.SetValue(0);

    ednQtdParcelas.SetValue(1);
    ednValOriginal.SetValue(ednValRestante.GetValue);
  except
    on E: Exception do
      RaiseSPK(E,E.Message);
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.ednCarenciaChange(Sender: TObject);
begin
  try
    eddDtaVencimento.SetValue(DMConexaoSPK.ObtemDataAtual + ednCarencia.GetValue);
  except
    on E: Exception do
      RaiseSPK(E,E.Message);
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.ednQtdParcelasChange(
  Sender: TObject);
var
  _ValParcela: currency;
begin
  try
    _ValParcela := 0;

    if (ednQtdParcelas.GetValue > 0) then
      _ValParcela := (ednValRestante.GetValue / ednQtdParcelas.GetValue);

    ednValOriginal.SetValue(RoundTo(_ValParcela,-2));

    if (ednQtdParcelas.GetValue > 1) then
    begin
      ednQtdIntervalo.SetMode(ModeInsert);
      ednQtdIntervalo.TabStop := True;
    end
    else
    begin
      ednQtdIntervalo.Initialize;
      ednQtdIntervalo.SetMode(ModeReadOnly);
      ednQtdIntervalo.TabStop := True;
    end;
  except
    on E: Exception do
      RaiseSPK(E,E.Message);
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.edsChaveNFeDownloadKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) and btnDownloadXML.Enabled then
    btnDownloadXML.Click;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.edsDiretorioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F2 then
    btnSelecionaDiretorio.Click;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.ExportarArquivos1Click(
  Sender: TObject);
var
  _FrmExportarArquivosNFe: TFrmExportarArquivosNFe;
begin
  _FrmExportarArquivosNFe := TFrmExportarArquivosNFe.Create(nil);
  try
    _FrmExportarArquivosNFe.ShowModal;
  finally
    FreeAndNil(_FrmExportarArquivosNFe);
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.qryCabXMLAfterClose(
  DataSet: TDataSet);
begin
  qryItensXML.Close;
  qryParcelasXML.Close;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.qryCabXMLAfterScroll(
  DataSet: TDataSet);
begin
  Self.PesquisaItensXMLCorrente;
  Self.PesquisaParcelasXMLCorrente;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.qryItensXMLCalcFields(
  DataSet: TDataSet);
begin
  qryItensXMLConversaoUnidadeOK.Value :=
    ((qryItensXMLCODUNIDADESPK.AsInteger = qryItensXMLCodUnidadeItemSPK.AsInteger) or
     (not qryItensXMLQtdFatorConvUnidade.IsNull));

  qryItensXMLItemVinculado.Value := (qryItensXMLCodItemSPK.AsInteger > 0);
  qryItensXMLAlmoxarifadoVinculado.Value := (qryItensXMLCODALMOXARIF.AsInteger > 0);
  qryItensXMLPedidoVinculado.Value := (qryItensXMLCODATENDIMENTO.AsInteger > 0);

  qryItensXMLGradesOk.Value := true;

  if qryItensXMLindtipocontrole.AsString = 'G' then
    qryItensXMLGradesOk.Value := qryItensXMLqtdgrades.AsFloat = qryItensXMLQtdItemConvertido.AsFloat;

  qryItensXMLLotesOk.Value := true;

  if qryItensXMLindtipocontrole.AsString = 'L' then
    qryItensXMLLotesOk.Value := qryItensXMLqtdLotes.AsFloat  = qryItensXMLQtdItemConvertido.AsFloat;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.chkConfirmaNotaAposInclusaoClick(
  Sender: TObject);
begin
  //Tag 38 - Nota Fiscal de Entrada
  if chkConfirmaNotaAposInclusao.Checked and
     (not TInterfaceUsuario.Usuario.VerificaAcessoPrograma(38, fConfirmar, False)) then
  begin
    MessageDlg('Usuário sem permissão para confirmar nota fiscal de entrada', mtWarning, [mbOK],0);
    chkConfirmaNotaAposInclusao.Checked := False;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.cxGridCabXMLDBTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  Self.VisualizarDANFE;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.cxGridCabXMLDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.Item.Index = cxGridCabXMLDBTableView1codparceirofornecedor.Index then
  begin
    if VarIsNull(AViewInfo.Value) then
      Self.PintaCanvas(ACanvas,clRed,clWhite);
  end
  else if AViewInfo.Item.Index = cxGridCabXMLDBTableView1CodNaturezaOperacao.Index then
  begin
    if VarIsNull(AViewInfo.Value) then
      Self.PintaCanvas(ACanvas,clRed,clWhite);
  end
  else if AViewInfo.Item.Index = cxGridCabXMLDBTableView1seqnota.Index then
  begin
    if not VarIsNull(AViewInfo.Value) then
      Self.PintaCanvas(ACanvas,clMoneyGreen,clWindowText);
  end
  else if AViewInfo.Item.Index = cxGridCabXMLDBTableView1codtipooperacao.Index then
  begin
    if VarIsNull(AViewInfo.Value) then
      Self.PintaCanvas(ACanvas,clRed,clWhite);
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.cxGridItensXMLDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  _ConversaoUnidadeOK: Boolean;
begin
  if AViewInfo.Item.Index = cxGridItensXMLDBTableView1CODITEMSPK.Index then
  begin
    if VarIsNull(AViewInfo.Value) then
      Self.PintaCanvas(ACanvas,clRed,clWhite);
  end
  else if AViewInfo.Item.Index = cxGridItensXMLDBTableView1desunidade.Index then
  begin
    if VarIsNull(AViewInfo.Value) or (VarToStr(Trim(AViewInfo.Value)) = '') then
      Self.PintaCanvas(ACanvas,clRed,clWhite)
    else
    begin
      _ConversaoUnidadeOK := VarAsType(cxGridItensXMLDBTableView1.
                                         ViewData.
                                           Records[AViewInfo.GridRecord.Index].
                                             Values[cxGridItensXMLDBTableView1ConversaoUnidadeOK.Index], varBoolean);
      if not _ConversaoUnidadeOK then
        Self.PintaCanvas(ACanvas,clRed,clWhite);
    end;
  end
  else if AViewInfo.Item.Index = cxGridItensXMLDBTableView1DESALMOXARIFADO.Index then
  begin
    if VarIsNull(AViewInfo.Value) or (VarToStr(Trim(AViewInfo.Value)) = '') then
      Self.PintaCanvas(ACanvas,clRed,clWhite);
  end
  else if AViewInfo.Item.Index = cxGridItensXMLDBTableView1numprecompra.Index then
  begin
    if VarIsNull(AViewInfo.Value) then
      Self.PintaCanvas(ACanvas,clRed,clWhite);
  end
  else if AViewInfo.Item.Index = clGridItensXMLDBTableView1NcmSPK.Index then
  begin
    if ((AViewInfo.Value)) <> (VarAsType(cxGridItensXMLDBTableView1.
                                           ViewData.
                                             Records[AViewInfo.GridRecord.Index].
                                               Values[cxGridItensXMLDBTableView1Ncm.Index], varString)) then
      Self.PintaCanvas(ACanvas,clYellow,clBlack);
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.btnSelecionaDiretorioClick(Sender: TObject);
var Diretorio: string;
begin
  Diretorio := '';
  if TPastasEspeciais.SelecionaDiretorio('Selecione o diretório', '', Diretorio) then
    edsDiretorio.SetValue(Diretorio);
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.btnTratarXmlClick(Sender: TObject);
var
  I: integer;
  _RowIndex: integer;
  _RowInfo: TcxRowInfo;
  _IncluiuNF: Boolean;
  _SeqNota: Integer;
  _DtaAtual, _DtaEntrada: TDateTime;
  _EventAfterScroll: TDataSetNotifyEvent;
  _MsgRetornoConfirmacao,
  _MsgRetornoValidPedido: String;
  _DadosNF: TDadosNotaFiscalEntrada;
begin
  Self.Enabled := False;
  _EventAfterScroll := qryCabXML.AfterScroll;
  qryCabXML.AfterScroll := nil;
  try
    _IncluiuNF := False;
    if not qryCabXML.IsEmpty then
    begin
      if (cxGridCabXMLDBTableView1.DataController.GetSelectedCount = 0) then
        MessageDlg('Nenhum XML selecionado.', mtWarning, [mbOK],0)
      else
      begin
        MemoLogValidacao.Clear;
        _DtaAtual := DMConexaoSPK.ObtemDataAtual;
        if (eddDtaEntradaNotaFiscal.GetValue > 0) then
        begin
          if (eddDtaEntradaNotaFiscal.GetValue > (_DtaAtual - 31)) and
             (eddDtaEntradaNotaFiscal.GetValue < (_DtaAtual + 31)) then
            _DtaEntrada := eddDtaEntradaNotaFiscal.GetValue
          else
            raise ExceptionSpkAdvertencia.Create('Data entrada nota fiscal não pode ser maior que 31 dias e não menor que 31 dias.');
        end
        else
          _DtaEntrada := _DtaAtual;
        for I := 0 to Pred(cxGridCabXMLDBTableView1.DataController.GetSelectedCount) do
        begin
          try
            DMConexaoSPK.DBGenerico.StartTransaction;
            _RowIndex := cxGridCabXMLDBTableView1.DataController.GetSelectedRowIndex(i);
            _RowInfo := cxGridCabXMLDBTableView1.DataController.GetRowInfo(_RowIndex);
            qryCabXML.RecNo := _RowInfo.RecordIndex + 1;

            if TInterfaceNotaFiscalEntrada.NotaFiscalEntrada.IncluirNFePelaImportacaoXMLNFe(qryCabXMLchave.AsString,_DtaEntrada,_SeqNota) then
            begin
              DMConexaoSPK.CommitFDConnection(DMConexaoSPK.DBGenerico);
              _IncluiuNF := True;

              if chkConfirmaNotaAposInclusao.Checked then
              begin
                _DadosNF := TInterfaceNotaFiscalEntrada.NotaFiscalEntrada.GetDadosNotaFiscal(_SeqNota);

                if not TInterfaceNotaFiscalEntrada.NotaFiscalEntrada.ValidaConsistenciaNFE_PComp(_DadosNF, _MsgRetornoValidPedido) then
                  MemoLogValidacao.Lines.Add('{A nota Nº ' + _DadosNF.NUMNOTA + ' não pôde ser confirmada:' + sLineBreak +  _MsgRetornoValidPedido + '}' + sLineBreak)
                else
                begin
                  DMConexaoSPK.DBGenerico.StartTransaction;
                  try
                    if TInterfaceNotaFiscalEntrada.NotaFiscalEntrada.Confirmar(_DadosNF, _MsgRetornoConfirmacao) then
                    begin
                      DMConexaoSPK.CommitFDConnection(DMConexaoSPK.DBGenerico);
                      Self.TrataAtualizacaoPreco(_SeqNota,qryCabXMLCodNaturezaOperacao.AsInteger);
                    end
                    else
                    begin
                      DMConexaoSPK.RollBackFDConnection(DMConexaoSPK.DBGenerico);
                      MemoLogValidacao.Lines.Add(_MsgRetornoConfirmacao);
                    end;
                  except
                    on E: Exception do
                    begin
                      DMConexaoSPK.RollBackDentroException(DMConexaoSPK.DBGenerico);
                      RaiseSPK(E,'Falha ao confirmar nota fiscal.'+sLineBreak+E.Message);
                    end;
                  end;
                end;

              end;
            end
            else
              DMConexaoSPK.RollBackFDConnection(DMConexaoSPK.DBGenerico)
          except
            on E: Exception do
            begin
              DMConexaoSPK.RollBackDentroException(DMConexaoSPK.DBGenerico);
              MemoLogValidacao.Lines.Add(TSPKFalha.GetMsgExceptionSPK(E));
            end;
          end;
        end;
        if (Trim(MemoLogValidacao.Text) <> '') then
          tsLogValidacao.Show;

        if _IncluiuNF then
        begin
          Self.OpenQryCabXML;
          MessageDlg('Nota incluída com sucesso.', mtInformation, [mbOK],0);
        end
        else
          MessageDlg('Nota não foi incluída.', mtInformation, [mbOK],0);
      end;
    end
    else
      MessageDlg('Nenhum XML selecionado.', mtWarning, [mbOK],0);
  finally
    Self.Enabled := True;
    qryCabXML.AfterScroll := _EventAfterScroll;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.MnuItemVincularDesvincularPedidoClick(Sender: TObject);
begin
  if not qryItensXML.IsEmpty then
  begin
    if PermiteEdicao then
    begin
      if qryItensXMLSEQITEM.AsInteger > 0  then
      begin
        if Self.DesvinculaPedidoCompra then
          MessageDlg('Vinculo removido com sucesso.', mtInformation, [mbOK],0)
        else
          MessageDlg('Vinculo não removido.', mtWarning, [mbOK],0);
      end
      else
      begin
        if qryItensXMLCODITEMSPK.AsInteger <= 0  then
          MessageDlg('Não há item SPK vinculado a este item da NF-e', mtWarning, [mbOK],0)
        else
        begin
          if VinculaPedidoCompra then
            MessageDlg('Vinculo realizado com sucesso.' , mtInformation, [mbOK],0)
          else
            MessageDlg('Vinculo não realizado.' , mtWarning, [mbOK],0);
        end;
      end;
    end;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.OpenQryCabXML;
var
  _EventAfterScroll: TDataSetNotifyEvent;
begin
  _EventAfterScroll := qryCabXML.AfterScroll;
  try
    qryCabXML.AfterScroll := Nil;
    qryCabXML.Close;
    DMConexaoSPK.OpenRemMapRul(qryCabXML);
    Self.PesquisaItensXMLCorrente;
    Self.PesquisaParcelasXMLCorrente;
  finally
    qryCabXML.AfterScroll := _EventAfterScroll;
  end;
end;

function TFrmImportaXMLNFeNotaFiscalEntrada.PermiteEdicao: Boolean;
begin
  Result := True;
  if qryCabXMLseqnota.AsInteger > 0 then
  begin
    MessageDlg('XML vinculado a uma nota fiscal, não é possível realizar a operação.', mtWarning, [mbOk], 0);
    Result := False;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.PesquisaItensXMLCorrente;
begin
  qryItensXML.Close;
  if not qryCabXML.IsEmpty then
  begin
    qryItensXML.ParamByName('chave').AsString := qryCabXMLchave.AsString;
    qryItensXML.Open;
    cxGridItensXMLDBTableView1.DataController.Refresh;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.PesquisaParcelasXMLCorrente;
begin
  qryParcelasXML.Close;
  if not qryCabXML.IsEmpty then
  begin
    qryParcelasXML.ParamByName('chave').AsString := qryCabXMLchave.AsString;
    qryParcelasXML.Open;
    self.LimpaCamposParcelas;
    fValTotalParcelas := VarToFloat(qryparcelasXML.Aggregates[0].Value);
    self.CalculaParcelaRestante;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.PesquisaXMLNFeImportacao(
  aDtaHrImportacao: TDateTime = 0);
begin
  qryCabXML.SQL.Clear;
  qryCabXML.SQL.Add('select   a.chave,'+sLineBreak+
                    '         a.serie,'+sLineBreak+
                    '         a.numero,'+sLineBreak+
                    '         a.dtaemissao,'+sLineBreak+
                    '         a.cnpjemitente,'+sLineBreak+
                    '         a.codparceirofornecedor,'+sLineBreak+
                    '         b.nomparceiro as nomfornecedor,'+sLineBreak+
                    '         cast(a.valproduto as double precision) as valproduto,'+sLineBreak+
                    '         cast(a.valnf as double precision) as valnf,'+sLineBreak+
                    '         a.dtaimportacao,'+sLineBreak+
                    '         (select max(z.seqnota)'+sLineBreak+
                    '          from spkenf z'+sLineBreak+
                    '          where z.idnfe = a.chave) as seqnota,'+sLineBreak+
                    '         a.CodNaturezaOperacao,'+sLineBreak+
                    '         c.desnaturezaoperacao,'+sLineBreak+
                    '         a.XML,'+sLineBreak+
                    '         a.codtipooperacao,  ' + slinebreak +
                    '         d.destipooperacao, ' + slinebreak +
                    '         c.inddevolucao ' + slinebreak +
                    'from     xmlnfeimportado a'+sLineBreak+
                    '         left join spkparc b on a.codparceirofornecedor = b.codparceiro'+sLineBreak+
                    '         left join spkon c on a.codnaturezaoperacao = c.codnaturezaoperacao'+sLineBreak+
                    '         left join spkto d on a.codtipooperacao = d.codtipooperacao' + slinebreak +
                    'where    a.codempresa = '+IntToStr(DadosEmpresa.CodEmpresa));
  if aDtaHrImportacao > 0 then
    qryCabXML.SQL.Add('     and a.dtaimportacao = '+DMConexaoSPK.FormatDateTimeSQLBDConnected(aDtaHrImportacao))
  else
  begin
    if (dlkFornecedor.GetValueCode > 0) then
      qryCabXML.SQL.Add('     and a.codparceirofornecedor = ' + IntToStr(dlkFornecedor.GetValueCode));
    if (Trim(edtMaskChaveNFe.GetValue) <> '') then
      qryCabXML.SQL.Add('     and a.Chave = ' + QuotedStr(edtMaskChaveNFe.GetValue));
    if eddDtaIniEmNFe.GetValue > 0 then
      qryCabXML.SQL.Add('     and a.dtaemissao >= ' + DMConexaoSPK.FormatDateSQLBDConnected(eddDtaIniEmNFe.GetValue));
    if eddDtaFinEmNFe.GetValue > 0 then
      qryCabXML.SQL.Add('     and a.dtaemissao <= ' + DMConexaoSPK.FormatDateSQLBDConnected(eddDtaFinEmNFe.GetValue));
    if (Trim(edsNumNFe.GetValue) <> '') then
      qryCabXML.SQL.Add('     and a.numero = ' + QuotedStr(edsNumNFe.GetValue));
    if (eddDtaImportacaoIni.GetValue > 0) or
       (eddDtaImportacaoFim.GetValue > 0) then
      qryCabXML.SQL.Add('     and a.dtaimportacao between '+
                        DMConexaoSPK.FormatDateTimeSQLBDConnected(
                            StrToDateTime(ifThen(
                                                  eddDtaImportacaoIni.GetValue > 0,
                                                  FormatDateTime('DD/MM/YYYY',eddDtaImportacaoIni.GetValue)+' 00:00:00',
                                                  FormatDateTime('DD/MM/YYYY',eddDtaImportacaoFim.GetValue)+' 00:00:00'
                                                )
                                                                 )
                                                ) +
                        'and ' +
                        DMConexaoSPK.FormatDateTimeSQLBDConnected(
                            StrToDateTime(ifThen(
                                                 eddDtaImportacaoFim.GetValue > 0,
                                                 FormatDateTime('DD/MM/YYYY',eddDtaImportacaoFim.GetValue)+' 23:59:59',
                                                 FormatDateTime('DD/MM/YYYY',eddDtaImportacaoIni.GetValue)+' 23:59:59'
                                                )
                                         )
                                                                 )
                       );

    case cbbSituacaoArquivos.ItemIndex of
      1: qryCabXML.SQL.Add('     and (select count(*) from spkenf z where z.idnfe = a.chave) > 0'); //Com nota vinculada
      2: qryCabXML.SQL.Add('     and (select count(*) from spkenf z where z.idnfe = a.chave) = 0'); //Sem nota vinculada
    end;
    qryCabXML.SQL.Add('order by a.dtaemissao');
  end;
  Self.OpenQryCabXML;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.PintaCanvas(Sender: TcxCanvas;
  aCorFundo, aCorFonte: TColor);
begin
  Sender.Brush.Color := aCorFundo;
  Sender.Font.Color := aCorFonte;
end;

function TFrmImportaXMLNFeNotaFiscalEntrada.ValidaFluxoParcelas: Boolean;
const
  cMsgDtaVenc = 'Informe a Data do 1º Vencimento.';
  cMsgQtdParc = 'Informe a quantidade de parcelas.';
  cMsgInterv =  'Para fluxo com mais de uma parcela, deve-se informar o intervalo' +
                ' entre as Parcelas ou selecionar a Opção Dia Fixo.';
  cMsgValParc = 'Informe o valor da parcela.';
  cMsgFluxo = 'O Fluxo informado (Qtde Parcelas x Vlr Parcela)' +
              ' é maior que o valor restante a parcelar.';
begin
  result := false;
  try
    if qryCabXML.isempty then
      MessageDlg('Necessário realizar a importaçãos dos XML.', mtWarning, [mbOk], 0)
    else if PermiteEdicao then
    begin
      if qryCabXMLCodTipoOperacao.AsInteger = 0 then
        MessageDlg('Informe o tipo de operação na grid acima.', mtInformation, [mbok], 0)
      else if eddDtaVencimento.GetValue < qryCabXMLdtaemissao.AsDateTime then
        MessageDlg('Não é permitido parcela com vencimento retroativo.', mtInformation, [mbok], 0)
      else if (eddDtaVencimento.GetValue = 0) then
      begin
        MessageDlg(cMsgDtaVenc, mtWarning, [mbok], 0);
        eddDtaVencimento.SetFocus;
      end
      else if (ednQtdParcelas.GetValue = 0) then
      begin
        MessageDlg(cMsgQtdParc, mtWarning, [mbok], 0);
        ednQtdParcelas.SetFocus;
      end
      else if ((ednQtdParcelas.GetValue > 1) and
               (not cbParcelasDiaFixo.Checked) and
               (ednQtdIntervalo.GetValue = 0)) then
      begin
        MessageDlg(cMsgInterv, mtWarning, [mbok], 0);
        ednQtdIntervalo.SetFocus;
      end
      else if (ednValOriginal.GetValue = 0) then
      begin
        MessageDlg(cMsgValParc, mtWarning, [mbok], 0);
        ednValOriginal.SetFocus;
      end
      else if ((RoundTo(ednQtdParcelas.GetValue * ednValOriginal.GetValue, -2) >
                    RoundTo(ednValRestante.GetValue + (ednValRestante.GetValue + ednQtdParcelas.GetValue / 100), -2))) then
      begin
        MessageDlg(cMsgFluxo, mtWarning, [mbok], 0);
        ednValOriginal.SetFocus;
      end
      else
        result := true;
    end;
  except
    on E: Exception do
      RaiseSPK(E,E.Message);
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.VariacaoToListaSelecaoGrade;
var
  _ListaVariacao: TListaVariacoesProdXml;
  _Variacao: TDadosXMLNFeImportado_prod_variacao;
  _DadosGrade: TDadosGradeItem;
begin
  FListaSelecaoGrade.Clear;

  _ListaVariacao := fLeituraXML.GetListaVariacao(qryItensXMLChave.AsString,
                                                 qryItensXMLSequencia.AsInteger);

  for _Variacao in _ListaVariacao do
  begin
    _DadosGrade.Clear;

    _DadosGrade := TInterfaceEstoque.Estoque.GetDadosGradeItem(_Variacao.SeqGrade);
    FListaSelecaoGrade.Add(_DadosGrade, _Variacao.Quantidade);
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.VariacaoToListaSelecaoLote;
var
  _ListaVariacao: TListaVariacoesProdXml;
  _Variacao: TDadosXMLNFeImportado_prod_variacao;
  _DadosLote: TDadosSPKLFI;
begin
  FListaSelecaoLotes.Clear;

  _ListaVariacao := fLeituraXML.GetListaVariacao(qryItensXMLChave.AsString,
                                                 qryItensXMLSequencia.AsInteger);

  for _Variacao in _ListaVariacao do
  begin
    _DadosLote.Clear;

    _DadosLote.NumLote := _Variacao.NumLote;
    _DadosLote.DtaFimValidade := _Variacao.DtaFimValidade;
    _DadosLote.DtaFabricacao :=  _Variacao.DtaFabricacao;
    _DadosLote.QtdItemLote := _Variacao.Quantidade;

    FListaSelecaoLotes.Add(_DadosLote);
  end;
end;

function TFrmImportaXMLNFeNotaFiscalEntrada.VinculaPedidoCompra: Boolean;
var
  _DadosItemPedido: TDadosItemPedidoCompra;
  _DadosItem: TDadosItem;
  _QtdItemPendente,
  _QtdItemPendenteVinculado,
  _QtdItemConvertido: Double;
  _BM: TBookMark;

  procedure _VinculaItem(aDadosItemPedidoCompra: TDadosItemPedidoCompra);
  var
    _ListaVariacao: TListaVariacoesProdXml;
    _Variacao: TDadosXMLNFeImportado_prod_variacao;
  begin
    _ListaVariacao.Clear;
    _Variacao.Clear;
    _Variacao.chave := qryItensXMLChave.AsString;
    _Variacao.Sequencia := qryItensXMLSequencia.AsInteger;
    _Variacao.SeqGrade := aDadosItemPedidoCompra.SeqGrade;
    _Variacao.Quantidade := _QtdItemPendenteVinculado;

    qryItensXML.Edit;
    qryItensXMLCODATENDIMENTO.AsInteger := aDadosItemPedidoCompra.CodAtendimento;
    qryItensXMLSEQITEM.AsInteger := aDadosItemPedidoCompra.SeqItemPedido;
    qryItensXMLnumprecompra.AsString := aDadosItemPedidoCompra.NumPedido;
    qryItensXML.Post;
    DMConexaoSPK.AplicaAtualizacoesModoBDE(qryItensXML);

    _ListaVariacao.Add(_Variacao);
    fLeituraXML.SubstituiListaVariacao(_ListaVariacao);
  end;
begin
  try
    Result := False;
    if not qryItensXML.IsEmpty then
    begin
      if TBuscaGeral.Create.BuscaItemPCompraPendente(qryItensXMLCODITEMSPK.AsInteger,
                                                     0,
                                                     _DadosItemPedido) then
      begin
        _DadosItem := TInterfaceEstoque.Estoque.GetDadosItem(qryItensXMLCODITEMSPK.AsInteger);
        _QtdItemPendente := RoundTo(_DadosItemPedido.QtdItemPendente, -_DadosItem.QtdCasasDecimais);
        _QtdItemConvertido := RoundTo(qryItensXMLqtditemconvertido.AsFloat, -_DadosItem.QtdCasasDecimais);
        _BM := qryItensXML.GetBookMark;

        if _QtdItemPendente < _QtdItemConvertido then
        begin
          MessageDlg('Quantidade pendente do item no pedido selecionado é menor ' +
                     'que a quantidade convertida do item , favor verificar.' +sLineBreak+
                     'Qtd. Pendente: '+TClasseFormatos.FormataFloatToString(_QtdItemPendente,_DadosItem.QtdCasasDecimais)+sLineBreak+
                     'Qtd. Convertida: '+TClasseFormatos.FormataFloatToString(_QtdItemConvertido,_DadosItem.QtdCasasDecimais), mtWarning, [mbOK],0);
        end
        else if qryItensXML.Locate('CODATENDIMENTO;SEQITEM;', VarArrayOf([IntToStr(_DadosItemPedido.CodAtendimento),
                                                                          IntToStr(_DadosItemPedido.SeqItemPedido)]), []) then
        begin
          _QtdItemPendenteVinculado := 0;
          try
            qryItensXML.First;
            while not qryItensXML.EOF do
            begin
              if (qryItensXML.FieldByName('SEQITEM').AsInteger > 0) and
                 (qryItensXML.FieldByName('CODATENDIMENTO').AsInteger = _DadosItemPedido.CodAtendimento) and
                 (qryItensXML.FieldByName('SEQITEM').AsInteger = _DadosItemPedido.SeqItemPedido) then
                _QtdItemPendenteVinculado := _QtdItemPendenteVinculado + RoundTo(qryItensXMLqtditemconvertido.AsFloat, -_DadosItem.QtdCasasDecimais);
              qryItensXML.Next;
            end;
          finally
            qryItensXML.GotoBookMark(_BM);
            qryItensXML.FreeBookMark(_BM);
          end;

          if (_QtdItemConvertido + _QtdItemPendenteVinculado) > _QtdItemPendente then
            MessageDlg('Não foi possível víncular o item, pois ultrapassa a quantidade pendente do mesmo no pedido de compra, ' + sLineBreak +
                       'favor verifique os demais itens vinculados ao cód. item SPK: ' + IntToStr(qryItensXMLCODITEMSPK.AsInteger) + sLineBreak +
                       'Qtd. pendente no pedido: ' +TClasseFormatos.FormataFloatToString(_QtdItemPendente,_DadosItem.QtdCasasDecimais)+ sLineBreak +
                       'Qtd. convertida a ser vinculada: '+TClasseFormatos.FormataFloatToString((_QtdItemConvertido + _QtdItemPendenteVinculado),_DadosItem.QtdCasasDecimais), mtWarning, [mbOK],0)
          else
          begin
            _VinculaItem(_DadosItemPedido);
            Result := True;
          end;
        end
        else
        begin
          _VinculaItem(_DadosItemPedido);
          Result := True;
        end;
      end;
    end;
  except
     on E: Exception do
       RaiseSPK(E,'''TFrmImportaXMLNFeNotaFiscalEntrada.VinculaPedidoCompra'' responsável por vincular item ao um pedido de compra.'+sLineBreak+E.Message);
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.VincularItem;
var
  _DadosItemVincular: TDadosItemXMLNFeVincular;
  _CodAtendimentoPedidoCompra: Integer;
begin
  _CodAtendimentoPedidoCompra := 0;
  if (not qryItensXML.IsEmpty) and
     (not qryCabXML.IsEmpty) then
  begin
    if qryCabXMLCodNaturezaOperacao.AsInteger <= 0 then
      MessageDlg('Informe a natureza de operação no cabeçalho.',mtWarning,[mbok],0)
    else if qryCabXMLcodparceirofornecedor.AsInteger <= 0 then
      MessageDlg('Informe o fornecedor no cabeçalho.',mtWarning,[mbok],0)
    else
    begin
      Application.CreateForm(TFrmItensXML, FrmItensXML);
      try
        FrmItensXML.CodEmpresa := DadosEmpresa.CodEmpresa;
        _DadosItemVincular.DadosFornecedor := TInterfaceParceiro.SpkParceiro.GetDadosFornecedor(qryCabXMLcodparceirofornecedor.AsInteger);
        _DadosItemVincular.DadosNop := TInterfaceSPKTributacao.SPKTributacao.getDadosNOP(qryCabXMLCodNaturezaOperacao.AsInteger);
        _DadosItemVincular.CodProdutoXML := qryItensXMLcodproduto.AsString;
        _DadosItemVincular.CodEanXML := qryItensXMLEAN.AsString;
        _DadosItemVincular.CodEanTribXML := qryItensXMLeantrib.AsString;
        _DadosItemVincular.DesProdutoXML := qryItensXMLdesproduto.AsString;
        _DadosItemVincular.NCMXML := qryItensXMLncm.AsString;
        _DadosItemVincular.UnidadeXML := qryItensXMLun.AsString;
        _DadosItemVincular.QtdItemXML := qryItensXMLqtd.AsFloat;
        _DadosItemVincular.CodUnidadeSpk := qryItensXMLCODUNIDADESPK.AsInteger;
        _DadosItemVincular.DadosItemSPK := TInterfaceEstoque.Estoque.GetDadosItem(qryItensXMLCODITEMSPK.AsInteger);
        FrmItensXML.DadosItemVincular := _DadosItemVincular;
        if FrmItensXML.ShowModal = mrOk then
        begin
          _CodAtendimentoPedidoCompra := qryItensXMLCODATENDIMENTO.AsInteger;

          if _CodAtendimentoPedidoCompra > 0 then
            Self.DesvinculaPedidoCompra;

          qryItensXML.Edit;
          qryItensXMLIndTipoControle.AsString := FrmItensXML.DadosItemVincular.DadosItemSPK.IndTipoControle;
          qryItensXMLCODITEMSPK.AsInteger := Trunc(FrmItensXML.ednCodItemSpk.GetValue);
          qryItensXMLdesitem.AsString := FrmItensXML.edsDesItemSPK.GetValue;
          qryItensXMLncmspk.AsString := FrmItensXML.edsNCMSPK.GetValue;
          qryItensXMLCodUnidadeItemSPK.AsInteger := FrmItensXML.CBUnItem.GetValueCode;
          qryItensXMLDesUnidadeItemSpk.AsString := FrmItensXML.CBUnItem.GetValueDescription;
          qryItensXMLCODUNIDADESPK.AsInteger := FrmItensXML.CBUnidadeEquivalente.GetValueCode;
          qryItensXMLdesunidade.AsString := FrmItensXML.CBUnidadeEquivalente.GetValueDescription;
          qryItensXMLcodreferencia.AsString := FrmItensXML.DadosItemVincular.DadosItemSPK.CODREFERENCIA;
          qryItensXMLcodreferenciacompra.AsString := Iif(Trim(FrmItensXML.DadosItemVincular.CodEanXML) <> '',
                                                         FrmItensXML.DadosItemVincular.CodEanXML,
                                                         FrmItensXML.DadosItemVincular.CodProdutoXML);

          if FrmItensXML.ednPesoQtd.GetValue > 0 then
            qryItensXMLqtditemconvertido.AsFloat := qryItensXMLqtd.AsFloat * FrmItensXML.ednPesoQtd.GetValue;

          qryItensXML.Post;
          if _CodAtendimentoPedidoCompra > 0 then
            Self.VinculaPedidoCompra;

          DMConexaoSPK.AplicaAtualizacoesModoBDE(qryItensXML);
          qryItensXML.Next;
        end;
      finally
        FreeAndNil(FrmItensXML);
      end;
    end;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.VisualizarDANFE;
begin
  if (Self.TecnoSpeedCarregado) then
  begin
    if (not qryCabXML.IsEmpty) then
    begin
      if Trim(qryCabXMLXML.AsString) <> '' then
        fLeituraXML.VisualizarDanfeOutroEmitente(qryCabXMLXML.AsString)
      else
        MessageDlg('Campo XML vazio.', mtInformation, [mbOk], 0);
    end;
  end;
end;

function TFrmImportaXMLNFeNotaFiscalEntrada.DesvinculaPedidoCompra: Boolean;
begin
  try
    Result := False;
    if not qryItensXML.IsEmpty then
    begin
      qryItensXML.Edit;
      qryItensXMLCODATENDIMENTO.Clear;
      qryItensXMLSEQITEM.Clear;
      qryItensXMLnumprecompra.Clear;
      qryItensXML.Post;
      DMConexaoSPK.AplicaAtualizacoesModoBDE(qryItensXML);
      Result := True;
    end;
  except
    on E: Exception do
      RaiseSPK(E,'''TFrmImportaXMLNFeNotaFiscalEntrada.DesvinculaPedidoCompra'' responsável por desvincular atendimento de compra do item.'+sLineBreak+E.Message);
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.mnExcluirXmlClick(Sender: TObject);
begin
  if (Self.TecnoSpeedCarregado) then
  begin
    if (not qryCabXML.IsEmpty) and
       (TInterfaceUsuario.Usuario.VerificaAcessoPrograma(ItemMenu.Tag,fExcluir,True)) then
    begin
      if PermiteEdicao then
      begin
        DMConexaoSPK.DBGenerico.StartTransaction;
        try
          fLeituraXML.DeleteXMLNFeImportado(qryCabXMLchave.AsString);
          DMConexaoSPK.CommitFDConnection(DMConexaoSPK.DBGenerico);
          Self.OpenQryCabXML;
        except
          on E: Exception do
          begin
            DMConexaoSPK.RollBackDentroException(DMConexaoSPK.DBGenerico);
            RaiseSPK(E,E.Message);
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.mniAlterarAlmoxarifadoClick(Sender: TObject);
begin
  if not qryItensXML.IsEmpty then
  begin
    if PermiteEdicao then
    begin
      Application.CreateForm(TfrmSelecionaAlmoxarifadoXmlEntrada, frmSelecionaAlmoxarifadoXmlEntrada);
      try
        frmSelecionaAlmoxarifadoXmlEntrada.lblDesITem.Caption := qryItensXMLdesproduto.AsString;
        frmSelecionaAlmoxarifadoXmlEntrada.lblAlmoxaAtual.Caption := qryItensXMLDESALMOXARIFADO.AsString;
        frmSelecionaAlmoxarifadoXmlEntrada.ShowModal;
        if frmSelecionaAlmoxarifadoXmlEntrada.ModalResult = mrOk then
        begin
          qryItensXML.Edit;
          qryItensXMLCODALMOXARIF.AsInteger := Trunc(frmSelecionaAlmoxarifadoXmlEntrada.ednCodAlmoxarifado.GetValue);
          qryItensXMLDESALMOXARIFADO.AsString := frmSelecionaAlmoxarifadoXmlEntrada.edsDesAlmoxarifado.GetValue;
          qryItensXML.Post;
          DMConexaoSPK.AplicaAtualizacoesModoBDE(qryItensXML);
        end;
      finally
        FreeAndNil(frmSelecionaAlmoxarifadoXmlEntrada);
      end;
    end;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.mniAlterarClasseFiscalDoItemClick(Sender: TObject);
var
  _DadosItem: TDadosItem;
begin
  if not qryItensXML.IsEmpty then
  begin
    if (qryItensXMLCODITEMSPK.AsInteger <= 0) then
      MessageDlg('É necessário vincular o item primeiramente', mtWarning, [mbOK],0)
    else
    begin
      _DadosItem := TInterfaceEstoque.Estoque.GetDadosItem(qryItensXMLCODITEMSPK.AsInteger);
      if (_DadosItem.IndTipoItem = 'S') then
        MessageDlg('Operação não permitida para item do tipo Serviço', mtWarning, [mbOK],0)
      else
      begin
        FrmAlteraClasseICMS := TFrmAlteraClasseICMS.Create(Self);
        try
          FrmAlteraClasseICMS.DadosItem := _DadosItem;
          if FrmAlteraClasseICMS.ShowModal = mrOK then
          begin

          end;
        finally
          FreeAndNil(FrmAlteraClasseICMS);
        end;
      end;
    end;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.mniAlterarGradesClick(
  Sender: TObject);
begin
  inherited;
  Self.AlterarGradesItem;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.mniAlterarLotesClick(
  Sender: TObject);
begin
  inherited;
  Self.AlterarLotesItem;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.mniConfigClasseFiscalClick(Sender: TObject);
var
  _FiltroDadosClasseFiscal: TFiltroConfigClasseFiscal;
  _DadosConfigClasseFiscal: TDadosConfigClasseFiscal;
  _DadosItem: TDadosItem;
  _DadosFornecedor: TDadosFornecedor;
  _OperacaoCL: TOpConfigClasseFiscal;
begin
  if not qryItensXML.IsEmpty then
  begin
    if PermiteEdicao then
    begin
      if (qryItensXMLCODITEMSPK.AsInteger <= 0) then
        MessageDlg('Deve vincular o item primeiro.', mtWarning, [mbOK],0)
      else
      begin
        _DadosItem := TInterfaceEstoque.Estoque.GetDadosItem(qryItensXMLCODITEMSPK.AsInteger);
        if (_DadosItem.CODCLASSEFISCAL <= 0) then
          MessageDlg('Item não possui classe fiscal vinculada', mtWarning, [mbOK],0)
        else
        begin
          _DadosFornecedor := TInterfaceParceiro.SpkParceiro.GetDadosFornecedor(qryCabXMLcodparceirofornecedor.AsInteger);
          if _DadosFornecedor.DadosSPKParc.CODPARCEIRO <= 0 then
            MessageDlg('Deve informar o fornecedor.',mtWarning,[mbOk],0)
          else
          begin
            _FiltroDadosClasseFiscal.CODCLASSEFISCAL := _DadosItem.CODCLASSEFISCAL;
            _FiltroDadosClasseFiscal.CODESTADO := DadosEmpresa.CODESTADO;
            _FiltroDadosClasseFiscal.COD_ESTADO_ORIGEM := _DadosFornecedor.DadosCidade.CODESTADO;
            _FiltroDadosClasseFiscal.CODNATUREZAOPERACAO := qryCabXMLCodNaturezaOperacao.AsInteger;
            _FiltroDadosClasseFiscal.TIPOPESSOA := _DadosFornecedor.DadosSPKParc.CODREGIMETRIBT;
            _FiltroDadosClasseFiscal.CODREGIMEEMPRESA := DadosEmpresa.codregimeempresa;
            _DadosConfigClasseFiscal := TInterfaceSPKTributacao.SPKTributacao.GetDadosConfigClasseFiscal(_FiltroDadosClasseFiscal);
            _OperacaoCL := opAlteracaoCfgClaFis;
            if _DadosConfigClasseFiscal.CODCLASSEFISCAL = 0 then
            begin
              _OperacaoCL := opInclusaoCfgClaFis;
              _DadosConfigClasseFiscal.CODCLASSEFISCAL := _FiltroDadosClasseFiscal.CODCLASSEFISCAL;
              _DadosConfigClasseFiscal.CODESTADO := _FiltroDadosClasseFiscal.CODESTADO;
              _DadosConfigClasseFiscal.CODNATUREZAOPERACAO := _FiltroDadosClasseFiscal.CODNATUREZAOPERACAO;
              _DadosConfigClasseFiscal.TIPOPESSOA := _FiltroDadosClasseFiscal.TIPOPESSOA;
              _DadosConfigClasseFiscal.CODREGIMEEMPRESA := _FiltroDadosClasseFiscal.CODREGIMEEMPRESA;
            end;
            FrmIncluiDadosClasseFiscal := TFrmIncluiDadosClasseFiscal.Create(Self);
            try
              FrmIncluiDadosClasseFiscal.DadosConfigClasseFiscal := _DadosConfigClasseFiscal;
              FrmIncluiDadosClasseFiscal.Operacao := _OperacaoCL;
              if FrmIncluiDadosClasseFiscal.ShowModal = mrOK then
              begin

              end;
            finally
              FreeAndNil(FrmIncluiDadosClasseFiscal);
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.mnIrParaNotaClick(Sender: TObject);
var
  _SeqNota: Integer;
begin
  if (not qryCabXML.IsEmpty) and (qryCabXMLseqnota.AsInteger > 0) then
  begin
    _SeqNota := qryCabXMLseqnota.AsInteger;
    if TFormControl.AbreTelaSolicitada(38) then
    begin
      FrmNotaFiscalEntrada.codempresalogado := DadosEmpresa.CodEmpresa;
      FrmNotaFiscalEntrada.DBIOperator.DoClear;
      FrmNotaFiscalEntrada.cbIndPEStatus.Checked := False;
      FrmNotaFiscalEntrada.PesquisaPosInsert := True;
      FrmNotaFiscalEntrada.SeqNota := _SeqNota;
      FrmNotaFiscalEntrada.DBIOperator.DoSelect;
    end;
  end
  else
    MessageDlg('Não há nota fiscal de entrada vinculada a este Item.', mtWarning, [mbOK], 0);
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.mnIrParaCadFornecedorClick(Sender: TObject);
var
  _CodFornecedor : Integer;
begin
  if TInterfaceUsuario.Usuario.VerificaAcessoPrograma(21, fAcessar, True) then
  begin
    if not qryCabXML.IsEmpty then
      _CodFornecedor := qryCabXMLcodparceirofornecedor.AsInteger
    else
      _CodFornecedor := 0;
    if TFormControl.AbreTelaSolicitada(21) then
    begin
      FrmCadastroPessoa.DBIOperator.DoClear;
      FrmCadastroPessoa.cbIndPEPessoaAtiva.Checked := False;
      FrmCadastroPessoa.cbIndPENatureza.Checked := False;
      FrmCadastroPessoa.cbIndPEClassificacao.Checked := False;
      if _CodFornecedor > 0 then
      begin
        FrmCadastroPessoa.ednCODPARCEIRO.SetValue(_CodFornecedor);
        FrmCadastroPessoa.DBIOperator.DoSelect;
      end;
    end;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.ImportaXMLDiretorio(aDiretorio: String);
  var
    _ListaXMLs: TStringList;
    I: Integer;
    _DtaHrImportacao: TDateTime;
  procedure MoveArquivoImportado;
  var
    _DiretorioAtual, _DiretorioDestino, _ArquivoCorrente: String;
  begin
    _DiretorioAtual := ExtractFileDir(_ListaXMLs[I]);
    _DiretorioDestino := _DiretorioAtual + PathDelim + 'Xmls NFe Importados';
    _ArquivoCorrente := ExtractFileName(_ListaXMLs[I]);
    if not SysUtils.DirectoryExists(_DiretorioDestino) then
      SysUtils.CreateDir(_DiretorioDestino);
    SysUtils.RenameFile(_DiretorioAtual + PathDelim + _ArquivoCorrente,
                        _DiretorioDestino + PathDelim + _ArquivoCorrente);
  end;
begin
  if (Self.TecnoSpeedCarregado) then
  begin
    Self.Enabled := False;
    try
      edsDiretorio.SetValue(aDiretorio);
      if edsDiretorio.GetValue = '' then
      begin
        MessageDlg('Informe o Diretório XML.',mtWarning,[mbok],0);
        edsDiretorio.SetFocus;
      end
      else
      begin
        MemoLogValidacao.Clear;
        try
          if Pos('-NFe.xml',aDiretorio) > 0 then
          begin
            _ListaXMLs := TStringList.Create;
            _ListaXMLs.Add(aDiretorio);
          end
          else
            _ListaXMLs := Self.GetListaArquivosXMLNoDiretorio;

          try
            Self.SetMaxProgresso(_ListaXMLs.Count - 1);
            if _ListaXMLs.Count > 0 then
            begin
              PgcItemParcelasXML.ActivePage := tsLogValidacao;
              _DtaHrImportacao := DMConexaoSPK.ObtemDataHoraAtual;
              for I := 0 to (_ListaXMLs.Count - 1) do
              begin
                try
                  DMConexaoSPK.DBGenerico.StartTransaction;
                  Self.IncPbProgresso;
                  fLeituraXML.IncluirXMLNFeImportado(
                       fLeituraXML.ConvertXMLToTDadosSPKXMLNFeArquivo(_ListaXMLs.Strings[I]),_DtaHrImportacao);
                  DMConexaoSPK.CommitFDConnection(DMConexaoSPK.DBGenerico);
                  MoveArquivoImportado;
                except
                  on E: Exception do
                  begin
                    DMConexaoSPK.RollBackDentroException(DMConexaoSPK.DBGenerico);
                    E.Message := TSPKFalha.GetMsgExceptionSPK(E);
                    Self.SetMemoLogValidacao(E.Message);
                  end;
                end;
              end;
              Self.SetMaxProgresso(0);
              Self.LimpoDadosFiltro;
              Self.PesquisaXMLNFeImportacao(_DtaHrImportacao);
            end
            else
              MessageDlg('Não existe arquivo XML no diretório informado.', mtWarning, [mbOK],0);
          finally
            FreeAndNil(_ListaXmls);
          end;
          if (Trim(MemoLogValidacao.Text) <> '') then
            PgcItemParcelasXML.ActivePage := tsLogValidacao
          else
            PgcItemParcelasXML.ActivePage := TsItens;

          if qryParcelasXML.isempty then
            ednValRestante.SetValue(qryCabXMLvalnf.AsCurrency);
        except
          on E: Exception do
            RaiseSPK(E,'Falha realizar tentativa de importação dos arquivos.' + sLineBreak + E.Message);
        end;
      end;
    finally
      Self.Enabled := True;
      dlkFornecedor.Show;
      dlkFornecedor.SetFocus;
    end;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.IncPbProgresso;
var
  I: Integer;
begin
  try
    I := ProgessImportacao.Position + 1;
    if I < ProgessImportacao.Max then
      ProgessImportacao.Position := I;
  except

  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.IrParaoCadastrodeItem1Click(Sender: TObject);
begin
  if TFormControl.AbreTelaSolicitada(9) then
  begin
    FrmCadastroItem.DBIOperator.DoClear;
    if (not qryItensXML.IsEmpty) and
       (qryItensXMLCODITEMSPK.AsInteger > 0) then
    begin
      FrmCadastroItem.ednCodItem.SetValue(qryItensXMLCODITEMSPK.AsInteger);
      FrmCadastroItem.DBIOperator.DoSelect;
    end;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.IrParaoPedidodeCompra1Click(Sender: TObject);
begin
  if (not qryItensXML.IsEmpty) and
     (qryItensXMLCODATENDIMENTO.AsInteger > 0) then
  begin
    if TFormControl.AbreTelaSolicitada(185) then
    begin
      FrmPreCompra.DBIOperator.DoClear;
      FrmPreCompra.CodAtendimento := qryItensXMLCODATENDIMENTO.AsInteger;
      FrmPreCompra.PesquisaPosInsert := True;
      FrmPreCompra.DBIOperator.DoSelect;
    end;
  end
  else
    MessageDlg('Não há pedido de compra vinculado a este xml.', mtInformation, [mbok], 0);
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.LimpaCamposParcelas;
begin
  ednCarencia.Initialize;
  eddDtaVencimento.Initialize;
  ednQtdParcelas.Initialize;
  ednQtdIntervalo.Initialize;
  ednValOriginal.Initialize;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.LimpoDadosFiltro;
begin
  eddDtaImportacaoIni.Initialize;
  eddDtaImportacaoFim.Initialize;
  dlkFornecedor.Initialize;
  edtMaskChaveNFe.Initialize;
  edsNumNFe.Initialize;
  eddDtaIniEmNFe.Initialize;
  eddDtaFinEmNFe.Initialize;
  cbbSituacaoArquivos.ItemIndex := -1;
  qryCabXML.Close;
end;

function TFrmImportaXMLNFeNotaFiscalEntrada.ListaSelecaoGradeToListaVariacao: TListaVariacoesProdXml;
var
  _Selecao: TDadosSelecaoGrade;
  _Variacao: TDadosXMLNFeImportado_prod_variacao;
begin
  result.Clear;

  for _Selecao in FListaSelecaoGrade do
  begin
    _Variacao.Clear;
    _Variacao.chave := qryItensXmlChave.AsString;
    _Variacao.Sequencia := qryItensXmlSequencia.AsInteger;
    _Variacao.Quantidade := _Selecao.Quantidade;
    _Variacao.SeqGrade := _Selecao.DadosGrade.SeqGrade;

    result.Add(_Variacao);
  end;
end;

function TFrmImportaXMLNFeNotaFiscalEntrada.ListaSelecaoLoteToListaVariacao: TListaVariacoesProdXml;
var
  _Selecao: TDadosSpkLfi;
  _Variacao: TDadosXMLNFeImportado_prod_variacao;
begin
  result.Clear;

  for _Selecao in FListaSelecaoLotes do
  begin
    _Variacao.Clear;
    _Variacao.chave := qryItensXmlChave.AsString;
    _Variacao.Sequencia := qryItensXmlSequencia.AsInteger;
    _Variacao.Quantidade := _Selecao.QtdItemLote;
    _Variacao.NumLote := _Selecao.NumLote;
    _Variacao.DtaFimValidade := _Selecao.DtaFimValidade;
    _Variacao.DtaFabricacao := _Selecao.DtaFabricacao;

    result.Add(_Variacao);
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if pgcCabecalho.ActivePage = tsImportacaoXml then
  begin
    if (Key = VK_F6) and (btnImportarXML.Enabled = True) then
      btnImportarXML.Click
    else if (Key = VK_F7) and (btnTratarXML.Enabled = True) then
      btnTratarXML.Click
  end
  else if pgcCabecalho.ActivePage = tsPesquisaImportacoes then
  begin
    if (Key = VK_F5) and btnPesquisaAvancada.Enabled then
      btnPesquisaAvancada.Click
    else if (Key = VK_F6) and btnLimparFiltrosPesquisa.Enabled then
      btnLimparFiltrosPesquisa.Click;
  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.FormShow(Sender: TObject);
begin
  inherited;
  edsChaveNFeDownload.SetFocus;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.SetMaxProgresso(aValue: Integer);
begin
  try
    ProgessImportacao.Min := 0;
    ProgessImportacao.Max := aValue;
    ProgessImportacao.Position := 0;
  except

  end;
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.SetMemoLogValidacao(aMsg: string);
begin
  try
    MemoLogValidacao.Lines.Add('**************************************************************************'+sLineBreak+
                               FormatDateTime('hh:mm:ss',Now())+' : '+sLineBreak+
                               aMsg+sLineBreak+
                               '**************************************************************************');
  except

  end;
end;

function TFrmImportaXMLNFeNotaFiscalEntrada.TecnoSpeedCarregado: Boolean;
begin
  // Se fLeituraXML = nil, então foi disparado uma exception no seu construtor no momento de carregar o componente da TecnoSpeed. Dessa forma fica uma mensagem mais coesa ao
  // usuário em vez de um ACCESS VIOLATION aonde usar esse objeto.
  Result := Assigned(Self.fLeituraXML);
  if (not Result) then
    MessageDlg('Não foi possível carregar o componente da TecnoSpeed, verifique as configurações e tente novamente.', mtWarning, [mbOk], 0, mbOk);
end;

procedure TFrmImportaXMLNFeNotaFiscalEntrada.TrataAtualizacaoPreco(aSeqNota: Integer;
  aCodNOP: Integer);
var
  _DadosNOP: TDadosNOP;
begin
  try
    _DadosNOP := TInterfaceSPKTributacao.SPKTributacao.getDadosNOP(aCodNOP);
    if _DadosNOP.INDCALCULAPRECOVENDA = 'S' then
    begin
      Application.CreateForm(TFrmAtualizaPrecoVenda, FrmAtualizaPrecoVenda);
      try
        FrmAtualizaPrecoVenda.Entradas.Close;
        FrmAtualizaPrecoVenda.Entradas.ParamByName('nSeqNota').Value := aSeqNota;
        FrmAtualizaPrecoVenda.Entradas.ParamByName('sTipo').AsString := 'NF';
        FrmAtualizaPrecoVenda.Entradas.Open;
        FrmAtualizaPrecoVenda.PermiteAlterarPrecoCalculado := TInterfaceUsuario.Usuario.VerificaAcessoPrograma(ItemMenu.Tag,fAlterarPrecoCalculado,False);
        FrmAtualizaPrecoVenda.ShowModal;
      finally
        FrmAtualizaPrecoVenda.Free;
      end;
    end;
  except
    on E: Exception do
      RaiseSPK(E,'''TFrmImportaXMLNFeNotaFiscalEntrada.TrataAtualizacaoPreco'' responsável por tratar atualização de preço.'+sLineBreak+E.Message);
  end;
end;

function TFrmImportaXMLNFeNotaFiscalEntrada.GetListaArquivosXMLNoDiretorio: TStringList;
var
  _F: TSearchRec;
  _Ret: Integer;
begin
  Result := TStringList.Create;
  if Copy(edsDiretorio.Text, length(edsDiretorio.Text), 1) <> '\' then
    edsDiretorio.Text := edsDiretorio.Text + '\';
  if not SysUtils.DirectoryExists(edsDiretorio.Text) then
    RaiseSPK(nil,'Diretório: "'+edsDiretorio.Text+'" não existe.')
  else
  begin
    _Ret := FindFirst(edsDiretorio.Text+'*.xml', faAnyFile, _F);
    try
      while _Ret = 0 do
      begin
        Result.Add(edsDiretorio.Text+_F.Name);
        _Ret := FindNext(_F);
      end;
    finally
      FindClose(_F);
    end;
  end;
end;

end.