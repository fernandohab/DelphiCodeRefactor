unit ufrmEntradaItemPc;

interface

uses
  Spk.FireDac, System.UITypes, SPKBancoDados.DMConexaoSPK, Winapi.Windows,
  Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, ufrmPai, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.StdCtrls,  Dbi, Vcl.Mask, Vcl.Buttons,  spkbibli, spkBiblioteca,
  Data.DB, Datasnap.DBClient, Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error,FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, vcl.Menus, Datasnap.Provider, Vcl.ComCtrls,
  Vcl.CategoryButtons, Vcl.WinXCtrls, Empresa.Types, System.Actions, Vcl.ActnList,
  SPK.Utils, EntradaPCompra;

type
  TUNIDADES = Record
    CodUnidade: Integer;
    QtdUnidade: Currency;
  end;

  TDadosItem = record
    UNIDADESItem: array  of TUNIDADES;
    IndTipoItem,
    IndTipoControle: String;
    PrecoVenda,
    PesoBruto,
    PesoLiquido,
    Volume,
    QtdSaldoEstoque,
    PerDescontoMaximo,
    ValDesconto,
    ValDescontoEmbutido: Currency;
    PerReducaoBaseIPI,
    PerAliquotaIPI : Currency;
    IndCalculaIPI : Boolean;
  end;

type
  TfrmEntradaItemPc = class(TFrmPai)
    cdsItemPedido: TClientDataSet;
    dsItemPedido: TDataSource;
    agrgtfldItemPedidototalitens: TAggregateField;
    agrgtfldItemPedidoqtdTotalItemLancado: TAggregateField;
    QueryGradeItem: TSpkFDQuery;
    QueryBuscaCodItem: TSpkFDQuery;
    QueryBuscaDadosItem: TSpkFDQuery;
    QueryItemPedido: TSpkFDQuery;
    intgrfldQueryBuscaNovaEntradacodatendimento: TIntegerField;
    strngfldQueryBuscaNovaEntradanumprecompra: TStringField;
    strngfldQueryBuscaNovaEntradahraemissao: TStringField;
    intgrfldQueryBuscaNovaEntradacodparceirofornecedor: TIntegerField;
    strngfldQueryBuscaNovaEntradanomparceiro: TStringField;
    intgrfldQueryBuscaNovaEntradacoditem: TIntegerField;
    strngfldQueryBuscaNovaEntradadesitem: TStringField;
    intgrfldQueryBuscaNovaEntradaseqitempedido: TIntegerField;
    intgrfldQueryBuscaNovaEntradaseqgrade: TIntegerField;
    fltfldQueryBuscaNovaEntradaqtditempendente: TFloatField;
    fltfldQueryBuscaNovaEntradaqtditemoriginal: TFloatField;
    fltfldQueryBuscaNovaEntradaqtdatendidoOriginal: TFloatField;
    fltfldQueryBuscaNovaEntradaqtdfaturadoOriginal: TFloatField;
    strngfldQueryBuscaNovaEntradadesgrade: TStringField;
    strngfldQueryBuscaNovaEntradaindtipoitem: TStringField;
    strngfldQueryBuscaNovaEntradaindtipocontrole: TStringField;
    intgrfldQueryBuscaNovaEntradacodsubgrupoitem: TIntegerField;
    strngfldQueryBuscaNovaEntradadessubgrupoitem: TStringField;
    intgrfldQueryBuscaNovaEntradacodmarca: TIntegerField;
    strngfldQueryBuscaNovaEntradadesmarca: TStringField;
    dtmfldQueryBuscaNovaEntradadtaemissao: TSQLTimeStampField;
    strngfldQueryBuscaNovaEntradaCODREFERENCIA: TStringField;
    strngfldQueryBuscaNovaEntradaCODNCM: TStringField;
    fltfldQueryBuscaNovaEntradaqtdinformada: TFloatField;
    intgrfldItemPedidocodatendimento: TIntegerField;
    strngfldItemPedidonumprecompra: TStringField;
    strngfldItemPedidohraemissao: TStringField;
    intgrfldItemPedidocodparceirofornecedor: TIntegerField;
    strngfldItemPedidonomparceiro: TStringField;
    intgrfldItemPedidocoditem: TIntegerField;
    strngfldItemPedidodesitem: TStringField;
    intgrfldItemPedidoseqitempedido: TIntegerField;
    intgrfldItemPedidoseqgrade: TIntegerField;
    fltfldItemPedidoqtditempendente: TFloatField;
    fltfldItemPedidoqtditemoriginal: TFloatField;
    fltfldItemPedidoqtdatendidoOriginal: TFloatField;
    fltfldItemPedidoqtdfaturadoOriginal: TFloatField;
    strngfldItemPedidodesgrade: TStringField;
    strngfldItemPedidoindtipoitem: TStringField;
    strngfldItemPedidoindtipocontrole: TStringField;
    intgrfldItemPedidocodsubgrupoitem: TIntegerField;
    strngfldItemPedidodessubgrupoitem: TStringField;
    intgrfldItemPedidocodmarca: TIntegerField;
    strngfldItemPedidodesmarca: TStringField;
    dtmfldItemPedidodtaemissao: TSQLTimeStampField;
    strngfldItemPedidoCODREFERENCIA: TStringField;
    strngfldItemPedidoCODNCM: TStringField;
    fltfldQueryItemPedidovalunitario: TFloatField;
    fltfldQueryItemPedidovaldescontoembutido: TFloatField;
    fltfldQueryItemPedidovaldesconto: TFloatField;
    fltfldQueryItemPedidovaltotal: TFloatField;
    fltfldQueryItemPedidovalcustounitario: TFloatField;
    fltfldQueryItemPedidovaldespesavenda: TFloatField;
    fltfldQueryItemPedidovalipi: TFloatField;
    fltfldQueryItemPedidovalfrete: TFloatField;
    fltfldQueryItemPedidovaldespesaacessoria: TFloatField;
    fltfldQueryItemPedidovalseguro: TFloatField;
    intgrfldQueryItemPedidocodunidadevenda: TIntegerField;
    fltfldItemPedidovalunitario: TFloatField;
    fltfldItemPedidovaldescontoembutido: TFloatField;
    fltfldItemPedidovaldesconto: TFloatField;
    fltfldItemPedidovaltotal: TFloatField;
    fltfldItemPedidovalcustounitario: TFloatField;
    fltfldItemPedidovaldespesavenda: TFloatField;
    fltfldItemPedidovalipi: TFloatField;
    fltfldItemPedidovalfrete: TFloatField;
    fltfldItemPedidovaldespesaacessoria: TFloatField;
    fltfldItemPedidovalseguro: TFloatField;
    intgrfldItemPedidocodunidadevenda: TIntegerField;
    dspItemPedido: TDataSetProvider;
    fltfldItemPedidoquantidade: TFloatField;
    pgcPesquisaPedidos: TPageControl;
    tsUnicoPedido: TTabSheet;
    Label3: TLabel;
    Label6: TLabel;
    lbl5: TLabel;
    edsNumPedidoPesquisa: TDBIEditString;
    btnPesquisaNumeroPedido: TButton;
    btnInformaQtdPendente: TButton;
    ednCodFornecedorBuscaSimples: TDBIEditNumber;
    edsNomFornecedorPesquisaSimples: TDBIEditString;
    btnPesquisaFornecedorPesqSimples: TDBIBitBtn;
    tsMultiplosPedidos: TTabSheet;
    Label7: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    Label12: TLabel;
    Label8: TLabel;
    ednCodFornecedor: TDBIEditNumber;
    edsNomFornecedor: TDBIEditString;
    btnPesquisaFornecedor: TDBIBitBtn;
    btnPesquisaPedidos: TButton;
    ednCodItem: TDBIEditNumber;
    edsDesItem: TDBIEditString;
    btnPesquisaItem: TDBIBitBtn;
    edsFiltroPesquisa: TDBIMaskEdit;
    ComboTipoBuscaItem: TDBIComboBox;
    btnFiltro: TButton;
    chkManterFornecedor: TCheckBox;
    chkManterItem: TCheckBox;
    ednQtdItem: TDBIEditNumber;
    btnIncluiItem: TButton;
    btnExcluiItem: TButton;
    btnLimpaForm: TButton;
    ComboGradeItem: TDBIComboBox;
    pnlRodapeNovoAtendim: TPanel;
    lbl2: TLabel;
    btnOk: TButton;
    btnCancelar: TButton;
    dbedtContagem: TDBEdit;
    grpItensAtendidos: TGroupBox;
    dbgrdNovaEntrada: TDBGrid;
    intgrfldQueryItemPedidoseqitem: TIntegerField;
    intgrfldItemPedidoseqitem: TIntegerField;
    QueryAtendimItem: TSpkFDQuery;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    IntegerField2: TIntegerField;
    StringField3: TStringField;
    IntegerField3: TIntegerField;
    StringField4: TStringField;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    FloatField4: TFloatField;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    IntegerField6: TIntegerField;
    StringField8: TStringField;
    IntegerField7: TIntegerField;
    StringField9: TStringField;
    DateTimeField1: TSQLTimeStampField;
    StringField10: TStringField;
    StringField11: TStringField;
    FloatField5: TFloatField;
    FloatField6: TFloatField;
    FloatField7: TFloatField;
    FloatField8: TFloatField;
    FloatField9: TFloatField;
    FloatField10: TFloatField;
    FloatField11: TFloatField;
    FloatField12: TFloatField;
    FloatField13: TFloatField;
    FloatField14: TFloatField;
    FloatField15: TFloatField;
    IntegerField8: TIntegerField;
    IntegerField9: TIntegerField;
    dspAtendimItem: TDataSetProvider;
    btnReinicarGrid: TButton;
    QueryPesquisaItemSimples: TSpkFDQuery;
    intgrfld1: TIntegerField;
    strngfld1: TStringField;
    strngfld2: TStringField;
    intgrfld2: TIntegerField;
    strngfld3: TStringField;
    intgrfld3: TIntegerField;
    strngfld4: TStringField;
    intgrfld4: TIntegerField;
    intgrfld5: TIntegerField;
    fltfld1: TFloatField;
    fltfld2: TFloatField;
    fltfld3: TFloatField;
    fltfld4: TFloatField;
    strngfld5: TStringField;
    strngfld6: TStringField;
    strngfld7: TStringField;
    intgrfld6: TIntegerField;
    strngfld8: TStringField;
    intgrfld7: TIntegerField;
    strngfld9: TStringField;
    dtmfld1: TSQLTimeStampField;
    strngfld10: TStringField;
    strngfld11: TStringField;
    fltfld5: TFloatField;
    fltfld6: TFloatField;
    fltfld7: TFloatField;
    fltfld8: TFloatField;
    fltfld9: TFloatField;
    fltfld10: TFloatField;
    fltfld11: TFloatField;
    fltfld12: TFloatField;
    fltfld13: TFloatField;
    fltfld14: TFloatField;
    fltfld15: TFloatField;
    intgrfld8: TIntegerField;
    intgrfld9: TIntegerField;
    grpDadosPedido: TGroupBox;
    lbl1: TLabel;
    Dtata: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    ednCodPedido: TDBIEditNumber;
    edsNumPedido: TDBIEditString;
    edsDtaPedido: TDBIEditString;
    edsHraPedido: TDBIEditString;
    ednCodFornecedorPedido: TDBIEditNumber;
    edsNomFornecedorPedido: TDBIEditString;
    strngfldQueryItemPedidocodreferenciacompra: TStringField;
    strngfldQueryAtendimItemcodreferenciacompra: TStringField;
    strngfldItemPedidocodreferenciacompra: TStringField;
    strngfldQueryPesquisaItemSimplescodreferenciacompra: TStringField;
    strngfldQueryItemPedidocodrefcaditem: TStringField;
    strngfldItemPedidocodrefcaditem: TStringField;
    strngfldQueryAtendimItemcodrefcaditem: TStringField;
    strngfldQueryPesquisaItemSimplescodrefcaditem: TStringField;
    fltfldItemPedidoqtditemconvertido: TFloatField;
    fltfldQueryPesquisaItemSimplesqtdcancelada: TFloatField;
    QueryAtendimItemqtdcancelada: TFloatField;
    QueryItemPedidoqtdcancelada: TFloatField;
    fltfldItemPedidoqtdcancelada: TFloatField;
    procedure btnPesquisaFornecedorClick(Sender: TObject);
    procedure btnPesquisaItemClick(Sender: TObject);
    procedure ednCodItemExit(Sender: TObject);
    procedure edsDesItemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ednCodItemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ednCodFornecedorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edsNomFornecedorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ednCodFornecedorExit(Sender: TObject);
    procedure ednCodItemChange(Sender: TObject);
    procedure btnIncluiItemClick(Sender: TObject);
    procedure btnLimpaFormClick(Sender: TObject);
    procedure btnExcluiItemClick(Sender: TObject);
    procedure ComboTipoBuscaItemChange(Sender: TObject);
    procedure btnFiltroClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPesquisaNumeroPedidoClick(Sender: TObject);
    procedure cdsItemPedidoBeforePost(DataSet: TDataSet);
    procedure btnInformaQtdPendenteClick(Sender: TObject);
    procedure DBIOperatorBeforeDelete(var Continue: Boolean);
    procedure btnPesquisaFornecedorPesqSimplesClick(Sender: TObject);
    procedure ednCodFornecedorBuscaSimplesKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure edsNomFornecedorPesquisaSimplesKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure ednCodFornecedorBuscaSimplesExit(Sender: TObject);
    procedure btnPesquisaPedidosClick(Sender: TObject);
    procedure dsItemPedidoStateChange(Sender: TObject);
    procedure btnReinicarGridClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cdsItemPedidoBeforeInsert(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgrdNovaEntradaTitleClick(Column: TColumn);
    procedure dbgrdNovaEntradaKeyPress(Sender: TObject; var Key: Char);
    procedure cdsItemPedidoCalcFields(DataSet: TDataSet);
    procedure edsFiltroPesquisaExit(Sender: TObject);
    procedure edsFiltroPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    PermiteAppend: boolean;
    DadosItem: TDadosItem;
    SeqGrade: Integer;
    BuscaGrade: Integer;
    vDadosItemPedido: TdadosItemPedidoCompra;
    vEdnFoco: TDBIEditNumber;
    Percentualdesconto: Currency;
    fDadosEmpresa: TDadosEmpresa;
    FGerenciaEntradaPCompra: TGerenciaEntradaPCompra;
    procedure InicializaCampos;
    function ValidaInsercaoItem:boolean;
    function GetQtdPendente(nCodAtendimento,nSeqItempedido:integer):Extended;
    procedure BuscaDadosGrade(referencia_grade : string);
    function BuscaDadosItem: Boolean;
    procedure SetDadosEmpresa(const Value: TDadosEmpresa);
  public
    ItemMenu : TMenuItem;
    idAtendimento : integer;
    procedure PreparaForm(nSeqAtendPComp:integer);
    property DadosEmpresa: TDadosEmpresa read fDadosEmpresa write SetDadosEmpresa;
  end;

var
  frmEntradaItemPc: TfrmEntradaItemPc;

implementation

{$R *.dfm}

uses
  Empresa.InterfaceEmpresa, SPKFalha, SPKParametros.InterfaceParametros, uDmImagens,
  uDataModulePrincipal, uFrmNotaFiscalEntrada, SPK.Classes, RZTemaAplicacao;

function TfrmEntradaItemPc.ValidaInsercaoItem:boolean;
begin
  result := false;
  if ednCodItem.GetValue = 0 then
  begin
    TMessageDlg.MessageDlgRazem('Item não informado !', mtWarning, [mbOk], 0);
    ednCodItem.SetFocus;
  end
  else if ((vDadosItemPedido.IndTipoControle = 'G') and (ComboGradeItem.GetValueCode = -1)) then
  begin
    TMessageDlg.MessageDlgRazem('Informe a grade !',mtWarning, [mbOk], 0);
    ComboGradeItem.SetFocus;
  end
  else if ednCodPedido.GetValue = 0 then
  begin
    TMessageDlg.MessageDlgRazem('Pedido não informado !',mtWarning, [mbOk], 0);
    ednCodFornecedor.SetFocus;
  end
  else if ednQtdItem.GetValue = 0 then
  begin
    TMessageDlg.MessageDlgRazem('Informe a quantidade do item !',mtWarning, [mbOk], 0);
    ednQtdItem.SetFocus;
  end
  else if (ednQtdItem.GetValue > vDadosItemPedido.QtdItemPendente) then
  begin
    TMessageDlg.MessageDlgRazem('A quantidade informada ultrapassa a quantidade pendente no pedido "'+
               FloatToStr(vDadosItemPedido.QtdItemPendente)+'".',mtWarning, [mbOk], 0);
    ednQtdItem.SetFocus;
  end
  else
    result := true;
end;

procedure TfrmEntradaItemPc.btnOkClick(Sender: TObject);
var
  _IdRetorno : integer;
  _Msg : string;
  _DadosItem: TDadosItemPComp;
begin
  if idAtendimento > 0 then
  begin
    frmEntradaItemPc.ModalResult := mrOk;
    Exit;
  end;

  if cdsItemPedido.IsEmpty then
    TMessageDlg.MessageDlgRazem('Nenhum item informado.',mtWarning,[mbOk],0)
  else
  begin
    if not(VarToFloat(cdsItemPedido.FieldByName('qtdTotalItemLancado').Value) > 0) then
      TMessageDlg.MessageDlgRazem('Não é possível os atender itens pendentes, sem informar a quantidade entregue de ao menos um dos itens.',mtWarning,[mbOk],0)
    else
    begin
      if TMessageDlg.MessageDlgRazem('Deseja realmente informar a entrada dos itens atendidos?',mtConfirmation,[mbYes,mbNo],0) = idYes then
      begin
        cdsItemPedido.DisableControls;
        cdsItemPedido.filtered := false;
        cdsItemPedido.filter := 'quantidade > 0';
        cdsItemPedido.filtered := true;
        try
          _IdRetorno := 0;

          DMConexaoSPK.DBGenerico.StartTransaction;
          try
            FGerenciaEntradaPCompra.CriaInsereEntradaPComp('M', _IdRetorno);
            cdsItemPedido.First;
            while not cdsItemPedido.EOF do
            begin
              _DadosItem := FGerenciaEntradaPCompra.DatasetItemParaTDadosItemPComp(cdsItemPedido, _IdRetorno);
              FGerenciaEntradaPCompra.CriaInsereEntradaItemPComp(_DadosItem);
              FGerenciaEntradaPCompra.AtualizaQtdAtendidaPComp(cdsItemPedido.FieldByName('QTDITEMCONVERTIDO').AsFloat,
                                                                cdsItemPedido.FieldByName('CODATENDIMENTO').AsInteger,
                                                                cdsItemPedido.FieldByName('SEQITEMPEDIDO').AsInteger,'+');
              cdsItemPedido.Next;
            end;
            DMConexaoSPK.CommitFDConnection(DMConexaoSPK.DBGenerico);
          except
            on e:exception do
            begin
              DMConexaoSPK.RollBackFDConnection(DMConexaoSPK.DBGenerico);
              TSPKFalha.TrataExceptionSPK(e);
            end;
          end;

          _Msg := 'Atendimento criado com sucesso.' + sLineBreak +
                 'Deseja confirmar o atendimento?';

          if TMessageDlg.MessageDlgRazem(_Msg,mtConfirmation, [mbYes, mbNo], 0) = idYes then
            FGerenciaEntradaPCompra.UpdateStatusEntradaPComp(_IdRetorno, 'C');

          IdAtendimento := _IdRetorno;

          Self.ModalResult := mrOk;
        finally
          cdsItemPedido.filtered := false;
          cdsItemPedido.EnableControls;
          InicializaCampos;
        end;
      end;
    end;
  end;
end;

procedure TfrmEntradaItemPc.btnExcluiItemClick(Sender: TObject);
begin
  if TMessageDlg.MessageDlgRazem('Deseja realmente excluir o item selecionado ?',
                                 mtConfirmation,
                                 [mbYes, mbNo],
                                 0) = idYes then
  begin
    if idAtendimento > 0 then
    begin
      DMConexaoSPK.DBGenerico.StartTransaction;
      try
        FGerenciaEntradaPCompra.DeletaEntradaItemPComp(TDataset(cdsItemPedido), idAtendimento);
        FGerenciaEntradaPCompra.AtualizaQtdAtendidaPComp(cdsItemPedido.FieldByName('QTDITEMCONVERTIDO').AsFloat,
                                                         cdsItemPedido.FieldByName('CODATENDIMENTO').AsInteger,
                                                         cdsItemPedido.FieldByName('SEQITEMPEDIDO').AsInteger,
                                                         '-');
        DMConexaoSPK.CommitFDConnection(DMConexaoSPK.DBGenerico)
      except
        on e:Exception do
        begin
          DMConexaoSPK.RollBackFDConnection(DMConexaoSPK.DBGenerico);
          TSPKFalha.TrataExceptionSPK(e)
        end;
      end;
    end;
    cdsItemPedido.Delete;
  end;
end;

procedure TfrmEntradaItemPc.btnFiltroClick(Sender: TObject);
var
  cod, des: string;
begin
    des := '';
    SeqGrade := 0;

    if Trim(edsFiltroPesquisa.GetValue) = '' then
      Exit;
    try

      with QueryBuscaCodItem do
      begin
        Close;
        SQL.Clear;
        if (ComboTipoBuscaItem.ItemIndex = 2) or (ComboTipoBuscaItem.ItemIndex = 7) then
          SQL.Add('SELECT seqgrade, coditem FROM SPKGI')
        else
          SQL.Add('SELECT coditem FROM SPKPRO a ');
        case ComboTipoBuscaItem.ItemIndex of
           0: Sql.Add('inner join codigobarra b ON(b.coditem = a.coditem) WHERE upper(b.codbarra) = '+ sPipe + edsFiltroPesquisa.GetValue + sPIpe);
           1: SQL.Add('WHERE codreferencia = ' + sPipe + edsFiltroPesquisa.GetValue + sPIpe);
           2: SQL.Add('WHERE codreferencia = ' + sPipe + edsFiltroPesquisa.GetValue + sPIpe);
           3: SQL.Add('INNER JOIN SPKFORNECEDORPRODUTO B ON(B.CODITEM = A.CODITEM) where  b.codprodutofornecedor = ' + edsFiltroPesquisa.GetValue + ' and    b.codparceirofornecedor = ' + FloatToStr(0));
           4: SQL.Add('INNER JOIN SPKFORNECEDORPRODUTO B ON(B.CODITEM = A.CODITEM) where  b.codreferenciacompra = ' + sPipe + edsFiltroPesquisa.GetValue + sPipe +  ' and    b.codparceirofornecedor = ' + FloatToStr(0));
           5: SQL.Add('WHERE coditem = ' + sPipe + edsFiltroPesquisa.GetValue + sPIpe);
           6: SQL.Add('WHERE desitem = ' + sPipe + edsFiltroPesquisa.GetValue + sPIpe);
           7: SQL.Add('WHERE codigobarra = ' + sPipe + edsFiltroPesquisa.GetValue + sPIpe);
        end;
        Open;
        if RecordCount > 0 then
          ednCodItem.SetValue(FieldByName('coditem').AsInteger)
        else
        begin
          case ComboTipoBuscaItem.ItemIndex of
            0: TMessageDlg.MessageDlgRazem('Não foi possível localizar o item pelo código de barras.', mtWarning, [mbok], 0);
            1: TMessageDlg.MessageDlgRazem('Não foi possível localizar o item pela referência.', mtWarning, [mbok], 0);
            2: TMessageDlg.MessageDlgRazem('Não foi possível localizar o item pela referência da grade.', mtWarning, [mbok], 0);
            3: TMessageDlg.MessageDlgRazem('Não foi possível localizar o item pelo código do fornecedor.', mtWarning, [mbok], 0);
            4: TMessageDlg.MessageDlgRazem('Não foi possível localizar o item pela código referência do fornecedor.', mtWarning, [mbok], 0);
            5: TMessageDlg.MessageDlgRazem('Não foi possível localizar o item pelo código.', mtWarning, [mbok], 0);
            6: TMessageDlg.MessageDlgRazem('Não foi possível localizar o item pela descrição.', mtWarning, [mbok], 0);
            7: TMessageDlg.MessageDlgRazem('Não foi possível localizar o item pela código de barras da grade.', mtWarning, [mbok], 0);
          end;
          edsFiltroPesquisa.SetFocus;
          Exit;
        end;
      end;

    except
      TMessageDlg.MessageDlgRazem('A Máscara da Referência do Item esta com formato invalido. verifique na configuração do sistema, qualquer duvida consulte o Help ou solicite ajuda ao suporte.', mtWarning, [mbok], 0);
      exit;
    end;

    cod := ednCodItem.Text;
    try
      if TBuscaGeral.Create.BuscaGeral('Pesquisa Item' ,'indtipoitem = ' + spipe + 'P' + spipe ,'SPKPRO  ','coditem','desitem', cod ,Des)then
      begin
        ednCodItem.SetValue(StrToFloat(cod));
        edsDesItem.SetValue(des);
        Application.ProcessMessages;
        if not BuscaDadosItem then
        begin
          ednCodItem.SetFocus;
          Exit;
        end;
        BuscaDadosGrade(edsFiltroPesquisa.GetValue);
      end
      else
      begin
        MessageBeep(MB_ICONASTERISK);
        ednCodItem.SetFocus;
      end;
    except
      MessageBeep(MB_ICONASTERISK);
      ednCodItem.SetFocus;
    end;

    if ednCodItem.GetValue > 0 then
      btnPesquisaItem.Click;
end;

procedure TfrmEntradaItemPc.btnIncluiItemClick(Sender: TObject);
var
  _SeqGrade : variant;
  _QtdPendente : Extended;
  _DadosItem: TDadosItemPComp;
begin
  if ComboGradeItem.GetValueCode = -1 then
     _SeqGrade := null
  else
     _SeqGrade := ComboGradeItem.GetValueCode;

  if ValidaInsercaoItem then
  begin
    _QtdPendente := Self.GetQtdPendente(vDadosItemPedido.CodAtendimento,vDadosItemPedido.SeqItemPedido);

    if ednQtdItem.GetValue > _QtdPendente then
    begin
      ednQtdItem.SetFocus;
      TMessageDlg.MessageDlgRazem('A quantidade informada excede a quantidade pendente "' + floatToStr(_QtdPendente) + '".',mtWarning,[mbOk],0);
    end
    else
    begin
      PermiteAppend := true;
      cdsItemPedido.Append;
      cdsItemPedido.FieldByName('codatendimento').Value := ednCodPedido.GetValue;
      cdsItemPedido.FieldByName('seqitempedido').Value := vDadosItemPedido.SeqItemPedido;
      cdsItemPedido.FieldByName('coditem').Value := ednCodItem.GetValue;
      cdsItemPedido.FieldByName('desitem').Value := edsDesItem.GetValue;
      cdsItemPedido.FieldByName('quantidade').Value := ednQtdItem.GetValue;
      cdsItemPedido.FieldByName('numprecompra').Value := vDadosItemPedido.NumPedido;
      cdsItemPedido.FieldByName('seqgrade').Value := _SeqGrade;
      cdsItemPedido.FieldByName('desgrade').Value := ComboGradeItem.Text;
      cdsItemPedido.FieldByName('codparceirofornecedor').Value := ednCodFornecedorPedido.GetValue;
      cdsItemPedido.FieldByName('nomparceiro').Value := edsNomFornecedorPedido.GetValue;
      cdsItemPedido.FieldByName('qtditempendente').Value := _QtdPendente;
      cdsItemPedido.FieldByName('codreferenciacompra').Value := vDadosItemPedido.codreferenciacompra;
      cdsItemPedido.FieldByName('codrefcaditem').Value := vDadosItemPedido.CodReferencia;
      cdsItemPedido.Post;

      if idAtendimento > 0 then
      begin
        _DadosItem := FGerenciaEntradaPCompra.DatasetItemParaTDadosItemPComp(cdsItemPedido, idAtendimento);
        DMConexaoSPK.DBGenerico.StartTransaction;
        try
          FGerenciaEntradaPCompra.CriaInsereEntradaItemPComp(_DadosItem);
          FGerenciaEntradaPCompra.AtualizaQtdAtendidaPComp(cdsItemPedido.FieldByName('QTDITEMCONVERTIDO').AsFloat,
                                                           cdsItemPedido.FieldByName('CODATENDIMENTO').AsInteger,
                                                           cdsItemPedido.FieldByName('SEQITEMPEDIDO').AsInteger,'+');
          DMConexaoSPK.CommitFDConnection(DMConexaoSPK.DBGenerico);
        except
          on e:exception do
          begin
            DMConexaoSPK.RollBAckFDConnection(DMConexaoSPK.DBGenerico);
            TSPKFalha.TrataExceptionSPK(e);
          end;
        end;
      end;

      if not chkManterFornecedor.Checked then
      begin
        ednCodFornecedor.Initialize;
        edsNomFornecedor.Initialize;
      end;

      if not chkManterItem.Checked then
      begin
        ednCodItem.Initialize;
        edsDesItem.Initialize;
      end;

      Self.InicializaCampos;
      vEdnFoco.SetFocus;
    end;
  end;
end;

procedure TfrmEntradaItemPc.btnInformaQtdPendenteClick(Sender: TObject);
begin
  if not cdsItemPedido.IsEmpty then
  with cdsItemPedido do
  begin
    DisableControls;
    First;
    while not EOF do
    begin
      Edit;
      FieldByName('quantidade').Value := FieldByName('qtditempendente').Value;
      Post;
      Next;
    end;
    Enablecontrols;
  end;
end;


function TfrmEntradaItemPc.GetQtdPendente(nCodAtendimento,nSeqItempedido:integer):Extended;
begin
  cdsItemPedido.Filtered := false;
  cdsItemPedido.Filter := '((codatendimento = ' + intToStr(nCodAtendimento) + ') and (seqitempedido = ' + intToStr(nSeqItempedido) + '))';
  cdsItemPedido.Filtered := true;

  if cdsItemPedido.RecordCount = 0 then
    result := vDadosItemPedido.QtdItemPendente
  else
    result := (vDadosItemPedido.QtdItemPendente - cdsItemPedido.FieldByName('qtdTotalItemLancado').Value);
  cdsItemPedido.Filtered := false;
end;

procedure TfrmEntradaItemPc.btnLimpaFormClick(Sender: TObject);
begin
  ednCodFornecedor.Initialize;
  edsNomFornecedor.Initialize;
  ednCodItem.Initialize;
  edsDesItem.Initialize;
  edsNumPedidoPesquisa.Initialize;
  InicializaCampos;
end;

procedure TfrmEntradaItemPc.btnPesquisaFornecedorClick(Sender: TObject);
var
  cod, des: string;
begin
  cod := FloatToStr(ednCodFornecedor.GetValue);
  des := edsNomFornecedor.GetValue;
  vEdnFoco := ednCodFornecedor;
  if TBuscaGeral.Create.BuscaGeralParceiro('Pesquisa Fornecedor' , 'indfornecedor = ' + spipe + 'S'+ spipe + 'and indpessoaativa = ' + sPipe + 'S' + sPipe ,'SPKPARC   ','CODPARCEIRO','NOMPARCEIRO', cod ,Des)then
  begin
    edncodfornecedor.SetValue(StrToFloat(cod));
    edsNomFornecedor.SetValue(des);
  end;
end;

procedure TfrmEntradaItemPc.btnPesquisaFornecedorPesqSimplesClick(
  Sender: TObject);
var
  cod, des: string;
begin
  cod := FloatToStr(ednCodFornecedorBuscaSimples.GetValue);
  des := edsNomFornecedorPesquisaSimples.GetValue;
  if TBuscaGeral.Create.BuscaGeralParceiro('Pesquisa Fornecedor' , 'indfornecedor = ' + spipe + 'S'+ spipe + 'and indpessoaativa = ' + sPipe + 'S' + sPipe ,'SPKPARC   ','CODPARCEIRO','NOMPARCEIRO', cod ,Des)then
  begin
    ednCodFornecedorBuscaSimples.SetValue(StrToFloat(cod));
    edsNomFornecedorPesquisaSimples.SetValue(des);
  end;
end;

procedure TfrmEntradaItemPc.btnPesquisaItemClick(Sender: TObject);
var
  cod, des: string;
begin
  cod := FloatToStr(ednCodItem.GetValue);
  des := edsDesItem.GetValue;
  vEdnFoco := ednCodItem;

  _BuscaGeral := TBuscaGeral.Create;
  try
    if (_BuscaGeral.BuscaItem('Pesquisa Item',
                              '',
                              cod,
                              Des,
                              0,
                              0,
                              '',
                              False,
                              tpVenda,
                              fDadosEmpresa.CodEmpresa)) then
    begin
      ednCodItem.SetValue(StrToFloat(cod));
      edsDesItem.SetValue(des);
      if StrToFloat(cod) > 0  then
      begin
        if TBuscaGeral.Create.BuscaItemPCompraPendente(Trunc(ednCodItem.GetValue),
                                                       Trunc(ednCodFornecedor.GetValue),
                                                       vDadosItemPedido) then
        begin
          ednCodPedido.SetValue(vDadosItemPedido.CodAtendimento);
          edsNumPedido.SetValue(vDadosItemPedido.NumPedido);
          edsDtaPedido.SetValue(vDadosItemPedido.DtaEmissao);
          edsHraPedido.SetValue(vDadosItemPedido.HraEmissao);
          ednCodFornecedorPedido.SetValue(vDadosItemPedido.CodParceiroFornecedor);
          edsNomFornecedorPedido.SetValue(vDadosItemPedido.NomParceiro);
          ednQtdItem.SetValue(GetQtdPendente(vDadosItemPedido.CodAtendimento,vDadosItemPedido.SeqItemPedido));
        end
        else
        begin
          ednCodItem.Initialize;
          edsDesItem.Initialize;
          InicializaCampos;
          ednCodItem.SetFocus;
        end;
      end;
    end
    else
    begin
      ednCodItem.Initialize;
      edsDesItem.Initialize;
      InicializaCampos;
    end;
  finally
    FreeAndNil(_BuscaGeral);
  end;
  BuscaDadosGrade(edsFiltroPesquisa.GetValue);
end;

procedure TfrmEntradaItemPc.btnPesquisaNumeroPedidoClick(Sender: TObject);
var
  _Cod, _Des, _Tabela, _Filtro, _CampoDes, _Codatendim, _SeqItemPed: string;
  _QtdPendente: Extended;
begin
  _Cod := '0';
  _Des := edsNumPedidoPesquisa.GetValue;
  InicializaCampos;
  _Tabela :=  'spkpcomp pc INNER JOIN spkparc pa ON (pc.codparceirofornecedor = pa.codparceiro)';

  _Filtro := 'pc.codempresa = ' + IntToStr(fDadosEmpresa.CodEmpresa) +
             '  and (select Count(*) ' +
             '       from spkipcomp ip ' +
             '           inner join spkpro pro on(ip.coditem = pro.coditem)' +
             '       where ip.codatendimento = pc.codatendimento ' +
             '         and Round(ip.qtdareceber, pro.qtdcasasdecimais) > 0) > 0 ';

  if ednCodFornecedorBuscaSimples.GetValue > 0 then
    _Filtro := _Filtro + ' AND pc.codparceirofornecedor = ' + FloatToStr(ednCodFornecedorBuscaSimples.GetValue);

  _CampoDes := 'pc.numprecompra ||' + QuotedStr(' | ') +
               '|| EXTRACT(day FROM pc.dtaemissao)||' + QuotedStr('/') +
               '|| EXTRACT(month FROM pc.dtaemissao)||' + QuotedStr('/') +
               '||EXTRACT(year FROM pc.dtaemissao)||' + QuotedStr(' | ') +
               '||pa.codparceiro || ' + spipe + ' - ' + spipe + '||pa.nomparceiro ';

  if TBuscaGeral.Create.BuscaGeral('Pesquisa Pedido de Compra Pendente' , _Filtro, _Tabela, 'pc.codatendimento', _CampoDes, _Cod ,_Des)then
  begin
    edsNumPedidoPesquisa.SetValue(copy(_Des,0, Pos(' | ', _Des)));

    if cdsItemPedido.State in [dsInactive] then
    cdsItemPedido.CreateDataset;


    QueryPesquisaItemSimples.Close;
    QueryPesquisaItemSimples.ParamByName('nCodAtendimento').Value  := StrToInt(_Cod);
    QueryPesquisaItemSimples.Open;
    QueryPesquisaItemSimples.First;
    while not QueryPesquisaItemSimples.EOF do
    Begin
      _Codatendim := QueryPesquisaItemSimples.FieldByName('codatendimento').AsString;
      _SeqItemPed := QueryPesquisaItemSimples.FieldByName('seqitempedido').AsString;
      vDadosItemPedido.QtdItemPendente := QueryPesquisaItemSimples.FieldByName('qtditempendente').AsFloat;
      if not cdsItemPedido.Locate('codatendimento;seqitempedido', vararrayof([_Codatendim,_SeqItemPed]),[]) then
      begin
        _QtdPendente := GetQtdPendente(StrToInt(_Codatendim),StrToInt(_SeqItemPed));
        if _QtdPendente > 0 then
        begin
          PermiteAppend := true;
          cdsItemPedido.Append;
          cdsItemPedido.FieldByName('codatendimento').Value := QueryPesquisaItemSimples.FieldByName('codatendimento').AsInteger;
          cdsItemPedido.FieldByName('seqitempedido').Value := QueryPesquisaItemSimples.FieldByName('seqitempedido').AsInteger;
          cdsItemPedido.FieldByName('coditem').Value := QueryPesquisaItemSimples.FieldByName('coditem').AsInteger;
          cdsItemPedido.FieldByName('desitem').Value := QueryPesquisaItemSimples.FieldByName('desitem').AsString;
          cdsItemPedido.FieldByName('quantidade').Value := QueryPesquisaItemSimples.FieldByName('quantidade').AsFloat;
          cdsItemPedido.FieldByName('numprecompra').Value := QueryPesquisaItemSimples.FieldByName('numprecompra').AsString;
          cdsItemPedido.FieldByName('seqgrade').Value := QueryPesquisaItemSimples.FieldByName('seqgrade').AsInteger;
          cdsItemPedido.FieldByName('desgrade').Value := QueryPesquisaItemSimples.FieldByName('desgrade').AsString;
          cdsItemPedido.FieldByName('codparceirofornecedor').Value := QueryPesquisaItemSimples.FieldByName('codparceirofornecedor').AsInteger;
          cdsItemPedido.FieldByName('nomparceiro').Value := QueryPesquisaItemSimples.FieldByName('nomparceiro').AsString;
          cdsItemPedido.FieldByName('codreferenciacompra').Value := QueryPesquisaItemSimples.FieldByName('codreferenciacompra').AsString;
          cdsItemPedido.FieldByName('qtditempendente').Value := _QtdPendente;
          cdsItemPedido.FieldByName('codrefcaditem').Value := QueryPesquisaItemSimples.FieldByName('codrefcaditem').AsString;
          cdsItemPedido.FieldByName('qtdcancelada').Value := QueryPesquisaItemSimples.FieldByName('qtdcancelada').AsFloat;
          cdsItemPedido.Post;
        end;
      end;
      QueryPesquisaItemSimples.Next;
    End;

    ednCodPedido.SetValue(StrToFloat(_Cod));
    edsNumPedido.SetValue(edsNumPedidoPesquisa.GetValue);
    edsDtaPedido.SetValue(cdsItemPedido.FieldByName('dtaemissao').AsString);
    edsHraPedido.SetValue(cdsItemPedido.FieldByName('hraemissao').AsString);
    ednCodFornecedorPedido.SetValue(cdsItemPedido.FieldByName('codparceirofornecedor').AsFloat);
    edsNomFornecedorPedido.SetValue(cdsItemPedido.FieldByName('nomparceiro').AsString);
    edsNumPedidoPesquisa.Initialize;
  end
  else
    TMessageDlg.MessageDlgRazem('Não existe pedido pendente com este número.',mtWarning,[mbOk],0);
end;

procedure TfrmEntradaItemPc.btnPesquisaPedidosClick(Sender: TObject);
begin
  if ednCodFornecedor.GetValue > 0 then
  begin
    ednCodItem.Initialize;
    edsDesItem.Initialize;
    if TBuscaGeral.Create.BuscaItemPCompraPendente(0,
                                                   Trunc(ednCodFornecedor.GetValue),
                                                   vDadosItemPedido) then
    begin
      ednCodItem.SetValue(vDadosItemPedido.CodItem);
      edsDesItem.SetValue(vDadosItemPedido.DesItem);
      ednCodPedido.SetValue(vDadosItemPedido.CodAtendimento);
      edsNumPedido.SetValue(vDadosItemPedido.NumPedido);
      edsDtaPedido.SetValue(vDadosItemPedido.DtaEmissao);
      edsHraPedido.SetValue(vDadosItemPedido.HraEmissao);
      ednCodFornecedorPedido.SetValue(vDadosItemPedido.CodParceiroFornecedor);
      edsNomFornecedorPedido.SetValue(vDadosItemPedido.NomParceiro);
      ednQtdItem.SetValue(GetQtdPendente(vDadosItemPedido.CodAtendimento,vDadosItemPedido.SeqItemPedido));
    end else
    begin
      ednCodItem.Initialize;
      edsDesItem.Initialize;
      InicializaCampos;
      ednCodItem.SetFocus;
    end;
    BuscaDadosGrade(edsFiltroPesquisa.GetValue);
  end else
  begin
    ednCodFornecedor.SetFocus;
    TMessageDlg.MessageDlgRazem('Informe o fornecedor.',mtWarning,[mbOk],0);
  end;
end;

procedure TfrmEntradaItemPc.btnReinicarGridClick(Sender: TObject);
begin
  if TMessageDlg.MessageDlgRazem('Deseja realmente reiniciar o lançamento ?',mtConfirmation,[mbYes,mbNo],0) = idYes then
  begin
    cdsItemPedido.Close;
    cdsItemPedido.CreateDataSet;
  end;
end;

procedure TfrmEntradaItemPc.ednCodFornecedorBuscaSimplesExit(Sender: TObject);
begin
  edsNomFornecedorPesquisaSimples.Initialize;
  if ednCodFornecedorBuscaSimples.GetValue > 0 then
    btnPesquisaFornecedorPesqSimples.Click;
end;

procedure TfrmEntradaItemPc.ednCodFornecedorBuscaSimplesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F2 then
    edsNomFornecedorPesquisaSimples.SetFocus;
end;

procedure TfrmEntradaItemPc.ednCodFornecedorExit(Sender: TObject);
begin
  edsNomFornecedor.Initialize;
  InicializaCampos;
  if ednCodFornecedor.GetValue > 0 then
    btnPesquisaFornecedor.Click;
end;

procedure TfrmEntradaItemPc.ednCodFornecedorKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F2 then
    edsNomFornecedor.SetFocus;
end;

procedure TfrmEntradaItemPc.ednCodItemChange(Sender: TObject);
begin
  ComboGradeItem.DoClear;
  ComboGradeItem.Enabled := False;
end;

procedure TfrmEntradaItemPc.ednCodItemExit(Sender: TObject);
begin
  edsDesItem.Initialize;
  InicializaCampos;
  if ednCodItem.GetValue > 0 then
    btnPesquisaItem.Click;
end;

procedure TfrmEntradaItemPc.ednCodItemKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F2 then
    edsDesItem.SetFocus;
end;

procedure TfrmEntradaItemPc.edsDesItemKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F2 then
    btnPesquisaItem.Click;
end;

procedure TfrmEntradaItemPc.edsFiltroPesquisaExit(Sender: TObject);
begin
  if (edsFiltroPesquisa.GetValue <> '') and (btnfiltro.Enabled) then
    btnFiltro.Click;
end;

procedure TfrmEntradaItemPc.edsFiltroPesquisaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if ((Key = VK_F2) OR (Key = VK_RETURN)) and btnFiltro.Enabled then
    btnFiltro.Click;
end;

function TfrmEntradaItemPc.BuscaDadosItem: Boolean;
var
  contaunidade : integer;
  MontaUnidades : string;
  TamanhoMontaUnidade : Integer;
  MontaUnidadeAux : string;
begin
  with QueryBuscaDadosItem do
  begin
    Close;
    ParamByName('nCodItem').Value := ednCodItem.GetValue;
    Open;

    BuscaGrade := FieldByName('seqgrade').AsInteger;

    if FieldByName('QTDCASASDECIMAIS').AsInteger = 0 then
      ednQtdItem.Format := '0;0'
    else if FieldByName('QTDCASASDECIMAIS').AsInteger = 1 then
      ednQtdItem.Format := '#,##0.0;(#,##0.0)'
    else if FieldByName('QTDCASASDECIMAIS').AsInteger = 2 then
      ednQtdItem.Format := '#,##0.00;(#,##0.00)'
    else if FieldByName('QTDCASASDECIMAIS').AsInteger = 3 then
      ednQtdItem.Format := '#,##0.000;(#,##0.000)'
    else if FieldByName('QTDCASASDECIMAIS').AsInteger = 4 then
      ednQtdItem.Format := '#,##0.0000;(#,##0.0000)'
    else if FieldByName('QTDCASASDECIMAIS').AsInteger = 5 then
      ednQtdItem.Format := '#,##0.00000;(#,##0.00000)'
    else if FieldByName('QTDCASASDECIMAIS').AsInteger = 6 then
      ednQtdItem.Format := '#,##0.000000;(#,##0.000000)'
    else if FieldByName('QTDCASASDECIMAIS').AsInteger = 7 then
      ednQtdItem.Format := '#,##0.0000000;(#,##0.0000000)'
    else if FieldByName('QTDCASASDECIMAIS').AsInteger = 8 then
      ednQtdItem.Format := '#,##0.00000000;(#,##0.00000000)'
    else if FieldByName('QTDCASASDECIMAIS').AsInteger = 9 then
      ednQtdItem.Format := '#,##0.000000000;(#,##0.000000000)';

    with DadosItem do
    begin
      DMPrincipal.QueryBuscaUnidadesItem.Close;
      DMPrincipal.QueryBuscaUnidadesItem.ParamByName('coditem').Value := ednCodItem.GetValue;
      DMPrincipal.QueryBuscaUnidadesItem.Open;
      DMPrincipal.QueryBuscaUnidadesItem.First;
      SetLength(UNIDADESItem, DMPrincipal.QueryBuscaUnidadesItem.RecordCount + 1);
      contaunidade := 1;
      UNIDADESItem[0].CodUnidade := FieldByName('codunidade').AsInteger;
      UNIDADESItem[0].QtdUnidade := 1;
      MontaUnidades := FieldByName('codunidade').AsString + ',';

      while not DMPrincipal.QueryBuscaUnidadesItem.eof do
      begin
        UNIDADESItem[contaunidade].CodUnidade := DMPrincipal.QueryBuscaUnidadesItem.FieldByName('codunidade').AsInteger;
        UNIDADESItem[contaunidade].QtdUnidade := DMPrincipal.QueryBuscaUnidadesItem.FieldByName('PRODUNIDADEMEDPESOQTD').AsFloat;
        MontaUnidades := MontaUnidades + DMPrincipal.QueryBuscaUnidadesItem.FieldByName('codunidade').AsString + ',';
        inc(contaunidade);
        DMPrincipal.QueryBuscaUnidadesItem.Next;
      end;
      TamanhoMontaUnidade := Length(MontaUnidades);
      MontaUnidadeAux := copy(MontaUnidades,1, TamanhoMontaUnidade - 1 );

      IndTipoItem := FieldByName('indtipoitem').AsString;
      IndTipoControle := FieldByName('indtipocontrole').AsString;
      PesoBruto := FieldByName('qtdpesobruto').AsFloat;
      PesoLiquido := FieldByName('qtdpesoliquido').AsFloat;
      Volume := FieldByName('qtdvolume').AsFloat;
      PerDescontoMaximo := FieldByName('perdescontomaximo').AsFloat;
      Percentualdesconto := BuscaDescontoItemCliente(trunc(0),trunc(ednCodItem.GetValue));
    end;
  end;
  Result := True;
end;


procedure TfrmEntradaItemPc.cdsItemPedidoBeforeInsert(DataSet: TDataSet);
begin
  if not PermiteAppend then
    Abort;
end;

procedure TfrmEntradaItemPc.cdsItemPedidoBeforePost(DataSet: TDataSet);
var
Msg : string;
begin
  if DataSet.FieldByName('quantidade').AsFloat > DataSet.FieldByName('qtditempendente').AsFloat then
  begin
    Msg := 'A quantidade informada (' + DataSet.FieldByName('quantidade').AsString + ')' + sLineBreak +
           'ultrapassa a quantidade pendente (' + DataSet.FieldByName('qtditempendente').AsString + ').';
    DataSet.FieldByName('quantidade').Value := 0;
    TMessageDlg.MessageDlgRazem(msg,mtWarning,[mbOk],0);
    Abort;
  end;
  PermiteAppend := false;
end;

procedure TfrmEntradaItemPc.cdsItemPedidoCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('qtditemconvertido').AsFloat := DataSet.FieldByName('quantidade').AsFloat;
end;

procedure TfrmEntradaItemPc.edsNomFornecedorKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_F2 then
    btnPesquisaFornecedor.Click;
end;

procedure TfrmEntradaItemPc.edsNomFornecedorPesquisaSimplesKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_F2 then
    btnPesquisaFornecedorPesqSimples.Click;
end;

procedure TfrmEntradaItemPc.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DMPrincipal.montagradeitem(dbgrdNovaEntrada,704,3);
end;

procedure TfrmEntradaItemPc.FormCreate(Sender: TObject);
begin
  inherited;
  PermiteAppend := false;
  DMPrincipal.BuscaOrdemGrid(dbgrdNovaEntrada,704,3);
end;

procedure TfrmEntradaItemPc.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FGerenciaEntradaPCompra);
end;

procedure TfrmEntradaItemPc.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (( key = vk_f4 ) and (btnOk.Enabled)) then
    btnOk.Click;

  if key = vk_escape then
    btnCancelar.Click;
end;

procedure TfrmEntradaItemPc.InicializaCampos;
begin
  ednCodPedido.Initialize;
  edsNumPedido.Initialize;
  edsDtaPedido.Initialize;
  edsHraPedido.Initialize;
  ednCodFornecedorPedido.Initialize;
  edsNomFornecedorPedido.Initialize;
  ednQtdItem.Initialize;
end;

procedure TfrmEntradaItemPc.PreparaForm(nSeqAtendPComp: integer);
var
indicegrid : integer;
begin
  indicegrid := TFuncoesDiversas.GetDBGridColumnIndex(dbgrdNovaEntrada,'quantidade');

  if nSeqAtendPComp = 0 then
  begin
    frmEntradaItemPc.Caption := 'Novo atendimento de pedido de compra.';
    tsUnicoPedido.tabVisible := true;
    pgcPesquisaPedidos.ActivePage := tsUnicoPedido;
    cdsItemPedido.ProviderName := 'dspItemPedido';
    cdsItemPedido.FetchParams;
    cdsItemPedido.Close;
    cdsItemPedido.CreateDataset;
    dbgrdNovaEntrada.Columns[indicegrid].ReadOnly := False;
    dbgrdNovaEntrada.Columns[indicegrid].Color := TStcRzTemaAplicacao.LocalVar.CoresPadrao.clWhite;
    btnReinicarGrid.Enabled := True;
  end
  else
  begin
    frmEntradaItemPc.Caption := 'Editando atendimento de pedido de compra de número "'+ IntToStr(nSeqAtendPComp) +'".';
    tsUnicoPedido.tabVisible := false;
    cdsItemPedido.ProviderName := 'dspAtendimItem';
    cdsItemPedido.FetchParams;
    cdsItemPedido.Close;
    cdsItemPedido.Params.ParamByName('nID').Value := nSeqAtendPComp;
    cdsItemPedido.Open;
    idAtendimento := nSeqAtendPComp;
    dbgrdNovaEntrada.Columns[indicegrid].ReadOnly := true;
    dbgrdNovaEntrada.Columns[indicegrid].Color := TStcRzTemaAplicacao.LocalVar.CoresSistema.cl3DLight;
    btnReinicarGrid.Enabled := False;
  end;
end;

procedure TfrmEntradaItemPc.SetDadosEmpresa(const Value: TDadosEmpresa);
begin
  fDadosEmpresa := Value;
end;

procedure TfrmEntradaItemPc.BuscaDadosGrade(referencia_grade : string);
begin
  ComboGradeItem.Enabled := False;
  IF vDadosItemPedido.IndTipoItem <>'D' THEN
    ednQtdItem.SetFocus;
  if ednQtdItem.GetValue = 0 then
    ednQtdItem.SetValue(StrToFloat(TInterfaceParametros.SPKParametros.GetValParametro(99)));
  if vDadosItemPedido.IndTipoControle = 'G' then
  begin
    if (referencia_grade <> '') and (ComboTipoBuscaItem.ItemIndex = 2) then
    begin
      with QueryGradeItem.sql do
      begin
        Clear;
        Add('SELECT	seqgrade, ');
        Add('	        desgrade          ');
        Add('FROM	SPKGI     ');
        Add('WHERE	codreferencia = :nCodreferencia ');
        Add('ORDER BY desgrade    ');
      end;
      QueryGradeItem.Close;
      QueryGradeItem.ParamByName('nCodreferencia').AsString := referencia_grade;
    end
    else if (referencia_grade <> '') and (ComboTipoBuscaItem.ItemIndex = 7) then
    begin
      with QueryGradeItem.sql do
      begin
        Clear;
        Add('SELECT	seqgrade, ');
        Add('	        desgrade          ');
        Add('FROM	SPKGI     ');
        Add('WHERE	codigobarra = :codigobarra ');
        Add('ORDER BY desgrade    ');
      end;
      QueryGradeItem.Close;
      QueryGradeItem.ParamByName('codigobarra').AsString := referencia_grade;
    end
    else
    begin
      with QueryGradeItem.sql do
      begin
        Clear;
        Add('SELECT	seqgrade, ');
        Add('	desgrade          ');
        Add('FROM	SPKGI     ');
        Add('WHERE	coditem = :nCodItem ');
        Add('ORDER BY desgrade    ');
      end;
      QueryGradeItem.Close;
      QueryGradeItem.ParamByName('nCodItem').Value := ednCodItem.GetValue;
    end;

    ComboGradeItem.Populate;

    if QueryGradeItem.RecordCount = 1 then
      ComboGradeItem.SetValueCode(QueryGradeItem.fieldByName('seqgrade').AsInteger)
    else
    begin
      ComboGradeItem.Enabled := True;
      ComboGradeItem.SetFocus;
    end;
  end;
end;


procedure TfrmEntradaItemPc.ComboTipoBuscaItemChange(Sender: TObject);
begin
  edsFiltroPesquisa.Text := '';

  if ComboTipoBuscaItem.ItemIndex = 0 then
    edsFiltroPesquisa.EditMask := ''
  else
    edsFiltroPesquisa.EditMask := TInterfaceParametros.SPKParametros.GetValParametro(50);
end;

procedure TfrmEntradaItemPc.dbgrdNovaEntradaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    with (Sender as TDBGrid) do
    begin
      if not Columns[SelectedIndex].ReadOnly then
      begin
        if TDBGrid(Sender).DataSource.DataSet.State in[dsEdit] then
          TDBGrid(Sender).DataSource.DataSet.Post;

        if HiWord(GetKeyState(VK_SHIFT)) <> 0 then
          DataSource.DataSet.Prior
        else
          DataSource.DataSet.Next;
      end;
    end;
    Key := #0;
  end
  else if Key = #9 then
  begin
    Key := #0;
    with (Sender as TDBGrid) do
    begin
      if TDBGrid(Sender).DataSource.DataSet.State in[dsEdit] then
          TDBGrid(Sender).DataSource.DataSet.Post;

      if HiWord(GetKeyState(VK_SHIFT)) <> 0 then
      begin
        while ((not DataSource.DataSet.BOF) or (SelectedIndex > 0)) and
              Columns[SelectedIndex].ReadOnly do
        begin
          if SelectedIndex = 0 then
          begin
            DataSource.DataSet.Prior;
            SelectedIndex := (Columns.Count -1);
          end
          else
            SelectedIndex := SelectedIndex - 1;
        end
      end
      else
      begin
        while ((not DataSource.DataSet.EOF) or (SelectedIndex < (Columns.Count -1))) and
              Columns[SelectedIndex].ReadOnly do
        begin
          if (SelectedIndex = (Columns.Count -1)) then
          begin
            DataSource.DataSet.Next;
            SelectedIndex := 0;
          end
          else
            SelectedIndex := SelectedIndex + 1;
        end;
      end;
    end;
  end;
end;

procedure TfrmEntradaItemPc.dbgrdNovaEntradaTitleClick(Column: TColumn);
begin
  TFuncoesDBGrid.OrdenaGrid(dsItemPedido, Column, dbgrdNovaEntrada);
end;

procedure TfrmEntradaItemPc.DBIOperatorBeforeDelete(var Continue: Boolean);
begin
  Continue := true;
end;

procedure TfrmEntradaItemPc.dsItemPedidoStateChange(Sender: TObject);
begin
  btnExcluiItem.Enabled := not dsItemPedido.Dataset.IsEmpty;
end;

end.