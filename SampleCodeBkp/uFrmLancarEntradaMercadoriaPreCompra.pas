unit uFrmLancarEntradaMercadoriaPreCompra;

interface

uses
  Spk.FireDac,Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, uFrmPaiDbi, Dialogs,
  StdCtrls, Dbi, Buttons, Db, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Mask,
  ExtCtrls, Grids, DBGrids, menus, uFRBibl,  variants, 
  System.UITypes, Vcl.CategoryButtons, Vcl.WinXCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  System.Actions, Vcl.ActnList, EntradaPCompra;

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

  TFrmLancarEntradaMercadoriaPreCompra = class(TFrmPaiDBI)
    Panel1: TPanel;
    DBGrid2: TDBGrid;
    pnlRodape: TPanel;
    pnlTopo: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    ednIdAtendimento: TDBIEditNumber;
    eddDtaEmissao: TDBIEditDate;
    edsUsuario: TDBIEditString;
    cbbStatus: TComboBox;
    Label1: TLabel;
    cbbTipoInclusao: TComboBox;
    QuerySelectId: TIntegerField;
    QuerySelectData: TSQLTimeStampField;
    QuerySelectUsuario: TStringField;
    QuerySelectIndStatus: TStringField;
    QuerySelectINDTIPOINCLUSAO: TStringField;
    QuerySelectdesstatus: TStringField;
    btnConfirmar: TButton;
    btnFaturar: TButton;
    btnIrNota: TButton;
    dbgrdDetalhe: TDBGrid;
    btnNovo: TButton;
    QueryBuscaItensAtendidos: TSpkFDQuery;
    QueryBuscaItensAtendidosCodItem: TIntegerField;
    QueryBuscaItensAtendidosDesItem: TStringField;
    QueryBuscaItensAtendidosNumPreCompra: TStringField;
    QueryBuscaItensAtendidosQuantidade: TFloatField;
    QueryBuscaItensAtendidosDesGrade: TStringField;
    QueryBuscaItensAtendidosCodParceiroFornecedor: TIntegerField;
    QueryBuscaItensAtendidosNomParceiro: TStringField;
    dsBuscaItensAtendidos: TDataSource;
    btnEditar: TButton;
    QueryBuscaItensAtendidosQtdAtendida: TFloatField;
    QueryBuscaItensAtendidosQtdFaturada: TFloatField;
    QuerySelectdestipoinclusao: TStringField;
    QueryBuscaItensAtendidosCodAtendimento: TIntegerField;
    QueryBuscaItensAtendidosSeqItemPedido: TIntegerField;
    QuerySelectseqnota: TIntegerField;
    QuerySelectnumnota: TStringField;
    QueryBuscaItensAtendidosCodReferenciaItem: TStringField;
    QueryBuscaItensAtendidosCodReferenciaCompra: TStringField;
    pmGrid: TPopupMenu;
    mniIrPedido: TMenuItem;
    QueryBuscaItensAtendidosQtdItemConvertido: TFloatField;
    QueryBuscaItensAtendidosQtdItemPedido: TFloatField;
    UpdateSQLQuerySelect: TFDUpdateSQL;
    QueryBuscaItensAtendidosCodEmpresa: TIntegerField;
    QueryBuscaItensAtendidosNomFantasia: TStringField;
    fltfldQueryBuscaItensAtendidosqtdcancelada: TFloatField;
    QueryBuscaItensAtendidosNumCotacao: TStringField;
    procedure DBIOperatorAfterInsert;
    procedure DBIOperatorBeforeSelect(var Continue: Boolean);
    procedure DBIOperatorStartTransaction(Operation: TDBIOperation);
    procedure DBIOperatorTransactionError(Operation: TDBIOperation);
    procedure DBIOperatorTransactionSucessfull(Operation: TDBIOperation);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure DBIOperatorNewRecord;
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure DBIOperatorBeforeDelete(var Continue: Boolean);
    procedure DBIOperatorPrepareDelete;
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnIrNotaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnFaturarClick(Sender: TObject);
    procedure DBIOperatorNavigate;
    procedure mniIrPedidoClick(Sender: TObject);
    procedure pmGridPopup(Sender: TObject);
    procedure dbgrdDetalheTitleClick(Column: TColumn);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ednIdAtendimentoExit(Sender: TObject);
    procedure QueryBuscaItensAtendidosAfterOpen(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FGerenciaEntradaPCompra: TGerenciaEntradaPCompra;
    procedure TrataStatusBotoes;
  public
    ItemMenu: TMenuItem;
    IdAtendimento: Integer;
    PesquisaPosInsert: boolean;
  end;

var
  FrmLancarEntradaMercadoriaPreCompra: TFrmLancarEntradaMercadoriaPreCompra;

implementation

uses
  Empresa.InterfaceEmpresa, SPKBancoDados.DMConexaoSPK, SPK.Consts.ProgramasModulosFuncoes, USUARIO.InterfaceUsuario,
  SPKBIbli, uDataModulePrincipal, SPKBIBLIOTECA, SPK.Utils, ESBDates, uFrmDadosEntradaLote, MenuPrincipal,
  uFrmFRVisualizaTemplateMenu, uFrmNotaFiscalEntrada, uFrmEntradaItemPc,   uFrmPreCompra, SPK.Classes, FormControl,
  SPKFalha;

{$R *.DFM}

procedure TFrmLancarEntradaMercadoriaPreCompra.DBIOperatorAfterInsert;
begin
  PesquisaPosInsert := True;
end;

procedure TFrmLancarEntradaMercadoriaPreCompra.DBIOperatorBeforeDelete(
  var Continue: Boolean);
begin
  Continue := false;
  if ((QuerySelect.FieldByName('INDTIPOINCLUSAO').AsString = 'A') and
      (not QueryBuscaItensAtendidos.IsEmpty)) then
    TMessageDlg.MessageDlgRazem('Só é permitida a exclusão de atendimentos gerados manualmente ou atendimentos gerados automaticamente sem itens atendidos.',mtWarning,[mbOk],0)
  else if QuerySelect.FieldByName('indstatus').AsString <> 'A' then
    TMessageDlg.MessageDlgRazem('Só é permitida a exclusão de atendimentos com status aberto.',mtWarning,[mbOk],0)
  else
    Continue := true;
end;

procedure TFrmLancarEntradaMercadoriaPreCompra.DBIOperatorBeforeSelect(
  var Continue: Boolean);
  function GetCorpoSQLQuerySelect: String;
  begin
    Result:= 'SELECT ep.id,' + sLineBreak +
             '       ep.data,' + sLineBreak +
             '       ep.usuario,' + sLineBreak +
             '       ep.indstatus,' + sLineBreak +
             '       ep.INDTIPOINCLUSAO,' + sLineBreak +
             '       CASE ep.indstatus' + sLineBreak +
             '         WHEN ''A'' THEN CAST(''ABERTO'' as varchar(15))' + sLineBreak +
             '         WHEN ''C'' THEN CAST(''CONFIRMADO'' as varchar(15))' + sLineBreak +
             '         WHEN ''F'' THEN CAST(''FATURADO'' as varchar(15))' + sLineBreak +
             '       END as desstatus,' + sLineBreak +
             '       CASE INDTIPOINCLUSAO' + sLineBreak +
             '         WHEN ''A'' THEN CAST(''Automático'' as varchar(10))' + sLineBreak +
             '         WHEN ''M'' THEN CAST(''Manual'' as varchar(10))' + sLineBreak +
             '       END as destipoinclusao,' + sLineBreak +
             '       en.seqnota,' + sLineBreak +
             '       en.numnota' + sLineBreak +
             'FROM  spk_cab_entrada_item_p_comp ep' + sLineBreak +
             '    LEFT JOIN spkenf en ON (ep.id = en.id_atendimento_pre_compra)' + sLineBreak +
             'WHERE ep.id IS NOT NULL';
  end;
begin
  UpdateSQLQuerySelect.FetchRowSQL.Clear;
  UpdateSQLQuerySelect.FetchRowSQL.Add(GetCorpoSQLQuerySelect);
  UpdateSQLQuerySelect.FetchRowSQL.Add('  and ep.id = :new_id');
  with QuerySelect do
  begin
    Sql.Clear;
    SQL.Add(GetCorpoSQLQuerySelect);
    if Self.PesquisaPosInsert then
    begin
      Sql.Add(' AND ep.id = ' + IntToStr(Self.IdAtendimento));
      Self.PesquisaPosInsert := False;
    end
    else if Trunc(ednIdAtendimento.getvalue) > 0 then
      Sql.Add(' AND ep.id = ' + FloatToStr(ednIdAtendimento.getvalue))
    else
    begin
      if eddDtaEmissao.GetValue > 0 then
        Sql.Add(' AND ep.data = ' + QuotedStr(FormatDateTime('DD/MM/YYYY',eddDtaEmissao.GetValue)));
      if edsUsuario.GetValue <> '' then
        Sql.Add(' AND ep.usuario = ' + QuotedStr(edsUsuario.GetValue));
      if cbbStatus.Text <> '' then
        Sql.Add(' AND ep.indstatus = ' + QuotedStr(copy(cbbStatus.Text,1,1)));
      if cbbTipoInclusao.Text <> '' then
        Sql.Add(' AND ep.INDTIPOINCLUSAO = ' + QuotedStr(copy(cbbTipoInclusao.Text,1,1)));
      Sql.Add('ORDER BY ep.id');
    end;
  end;
end;


procedure TFrmLancarEntradaMercadoriaPreCompra.DBIOperatorNavigate;
begin
  QueryBuscaItensAtendidos.Close;
  QueryBuscaItensAtendidos.ParamByName('nCodAtendimento').Value := QuerySelect.FieldByName('id').AsInteger;
  QueryBuscaItensAtendidos.Open;
  cbbStatus.ItemIndex := cbbStatus.Items.IndexOf(QuerySelect.FieldByName('desstatus').AsString);
  cbbStatus.Enabled := false;
  cbbTipoInclusao.ItemIndex := cbbTipoInclusao.Items.IndexOf(QuerySelect.FieldByName('destipoinclusao').AsString);
  cbbTipoInclusao.Enabled := false;
  TrataStatusBotoes;
end;

procedure TFrmLancarEntradaMercadoriaPreCompra.DBIOperatorNewRecord;
begin
  cbbStatus.ItemIndex := 0;
  cbbStatus.Enabled := true;
  cbbTipoInclusao.ItemIndex := 0;
  cbbTipoInclusao.Enabled := true;
  QueryBuscaItensAtendidos.Close;
  if Self.PesquisaPosInsert then
    DBIOperator.DoSelect
  else
  begin
    Self.IdAtendimento := 0;
    Self.TrataStatusBotoes;
  end;
end;

procedure TFrmLancarEntradaMercadoriaPreCompra.DBIOperatorPrepareDelete;
begin
  QueryBuscaItensAtendidos.DisableControls;
  QueryBuscaItensAtendidos.First;
  try
    DMConexaoSPK.DBGenerico.StartTransaction;
    while not QueryBuscaItensAtendidos.EOF do
    begin
      FGerenciaEntradaPCompra.AtualizaQtdAtendidaPComp(QueryBuscaItensAtendidos.FieldByName('QTDITEMCONVERTIDO').AsFloat,
                                                   QueryBuscaItensAtendidos.FieldByName('CODATENDIMENTO').AsInteger,
                                                   QueryBuscaItensAtendidos.FieldByName('SEQITEMPEDIDO').AsInteger,
                                                   '-');
      QueryBuscaItensAtendidos.Next;
    end;
    FGerenciaEntradaPCompra.DeletaCabEntradaPComp(QuerySelect.FieldByName('id').AsInteger);
    DMConexaoSPK.CommitFDConnection(DMConexaoSPK.DBGenerico);
    QueryBuscaItensAtendidos.EnableControls;
  except
    DMConexaoSPK.RollBackFDConnection(DMConexaoSPK.DBGenerico);
  end;
end;

procedure TFrmLancarEntradaMercadoriaPreCompra.DBIOperatorStartTransaction(
  Operation: TDBIOperation);
begin
  DMConexaoSPK.DBGenerico.StartTransaction;
end;

procedure TFrmLancarEntradaMercadoriaPreCompra.TrataStatusBotoes;
begin
  btnConfirmar.Enabled := ((pos(QuerySelect.FieldByName('indstatus').AsString,'A|C') > 0) and
                           (QuerySelect.FieldByName('INDTIPOINCLUSAO').AsString = 'M'));

  btnFaturar.Enabled := ((QuerySelect.FieldByName('indstatus').AsString = 'C') and
                         (QuerySelect.FieldByName('INDTIPOINCLUSAO').AsString = 'M'));

  btnIrNota.Enabled := (QuerySelect.FieldByName('seqnota').AsInteger > 0);

  if QuerySelect.FieldByName('indstatus').AsString = 'C' then
  begin
    btnConfirmar.Caption := 'F2 - Estornar';
    btnConfirmar.ImageIndex := 6;
    btnConfirmar.DisabledImageIndex := 7;
  end
  else
  begin
    btnConfirmar.Caption := 'F2 - Confirmar';
    btnConfirmar.ImageIndex := 4;
    btnConfirmar.DisabledImageIndex := 5;
  end;
end;

procedure TFrmLancarEntradaMercadoriaPreCompra.DBIOperatorTransactionError(
  Operation: TDBIOperation);
begin
  DMConexaoSPK.RollBackFDConnection(DMConexaoSPK.DBGenerico);

end;

procedure TFrmLancarEntradaMercadoriaPreCompra.DBIOperatorTransactionSucessfull(
  Operation: TDBIOperation);
begin
  DMConexaoSPK.CommitFDConnection(DMConexaoSPK.DBGenerico);
end;

procedure TFrmLancarEntradaMercadoriaPreCompra.ednIdAtendimentoExit(
  Sender: TObject);
begin
  if ((not DBIOperator.IsPopulate) and (Trunc(ednIdAtendimento.GetValue) > 0)) then
    DBIOperator.DoSelect;
end;

procedure TFrmLancarEntradaMercadoriaPreCompra.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  ItemMenu.Checked := False;
end;


procedure TFrmLancarEntradaMercadoriaPreCompra.FormCreate(Sender: TObject);
begin
  inherited;
  FGerenciaEntradaPCompra := TGerenciaEntradaPCompra.Create;
end;

procedure TFrmLancarEntradaMercadoriaPreCompra.FormDestroy(
  Sender: TObject);
begin
  inherited;
  FreeAndNil(FGerenciaEntradaPCompra);
end;

procedure TFrmLancarEntradaMercadoriaPreCompra.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if ((Key = vk_f2) and (btnConfirmar.Enabled))  then
    btnConfirmar.Click;
  if ((key = vk_f3) and (btnFaturar.Enabled)) then
    btnFaturar.Click;
  if ((key = vk_f6) and (btnIrNota.Enabled)) then
    btnIrNota.Click;
end;

procedure TFrmLancarEntradaMercadoriaPreCompra.mniIrPedidoClick(Sender: TObject);
var
  _CodAtendimento: Integer;
begin
  if (QueryBuscaItensAtendidos.fieldByName('CODATENDIMENTO').AsInteger > 0) then
  begin
    _CodAtendimento := QueryBuscaItensAtendidos.fieldByName('CODATENDIMENTO').AsInteger;
    TFormControl.AbreTelaSolicitada(185);
    FrmPreCompra.CodAtendimento := _CodAtendimento;
    FrmPreCompra.PesquisaPosInsert := True;
    FrmPreCompra.DBIOperator.DoClear;
  end;
end;

procedure TFrmLancarEntradaMercadoriaPreCompra.pmGridPopup(Sender: TObject);
begin
  mniIrPedido.Enabled := not QueryBuscaItensAtendidos.IsEmpty;
end;

procedure TFrmLancarEntradaMercadoriaPreCompra.QueryBuscaItensAtendidosAfterOpen(
  DataSet: TDataSet);
begin
  inherited;
  // #,##0.0000;(#,##0.0000)
  QueryBuscaItensAtendidosQtdItemPedido.DisplayFormat := ' #,##0.0000;(#,##0.0000)';
  QueryBuscaItensAtendidosQtdItemConvertido.DisplayFormat := ' #,##0.0000;(#,##0.0000)';
  QueryBuscaItensAtendidosQtdAtendida.DisplayFormat := ' #,##0.0000;(#,##0.0000)';
  QueryBuscaItensAtendidosQtdFaturada.DisplayFormat := ' #,##0.0000;(#,##0.0000)';
end;

procedure TFrmLancarEntradaMercadoriaPreCompra.btnConfirmarClick(Sender: TObject);
var
  _Operacao: String;
  _IdAtendimento: integer;

  function ValidaRegrasOperacao: Boolean;
  begin
    Result := True;
    if (_Operacao = 'C') then //Confirmando
      Result := TInterfaceUsuario.Usuario.VerificaAcessoPrograma(704,fConfirmar,true)
    else if (_Operacao = 'A') then //Estorno de confirmação
    begin
      if (not TInterfaceUsuario.Usuario.VerificaAcessoPrograma(704,fDesconfirmar,true)) then
        Result := False
      else if (QuerySelect.FieldByName('SeqNota').AsInteger > 0) then
      begin
        TMessageDlg.MessageDlgRazem('Não é possível estornar atendimento com nota vinculada.' + sLineBreak +
                   'Sequência da Nota de entrada: ' + QuerySelect.FieldByName('SeqNota').AsString,
                   mtWarning, [mbOK],0);
        Result := False;
        DBIOperator.VerificaNavegacao;
      end;
    end;
  end;
begin
  DBIOperator.VerificaNavegacao;
  if QuerySelect.FieldByName('indstatus').AsString = 'A' then
    _Operacao := 'C'
  else if QuerySelect.FieldByName('indstatus').AsString = 'C' then
    _Operacao := 'A';
  if (ValidaRegrasOperacao and
      (TMessageDlg.MessageDlgRazem('Deseja realmente alterar o status do atendimento?',mtConfirmation,[mbYes,mbNo],0) = idYes)) then
  begin
    _IdAtendimento := QuerySelect.FieldByName('ID').AsInteger;
    try
      DMConexaoSPK.DBGenerico.StartTransaction;
      try
        FGerenciaEntradaPCompra.UpdateStatusEntradaPComp(_IdAtendimento,_Operacao);
        DMConexaoSPK.CommitFDConnection(DMConexaoSPK.DBGenerico);
        TMessageDlg.MessageDlgRazem('Operação realizada com sucesso!',mtInformation,[mbOk],0);
      except
        on E:Exception do
        begin
          DMConexaoSPK.RollBackFDConnection(DMConexaoSPK.DBGenerico);
          TSPKFalha.TrataExceptionSPK(e);
        end;
      end;
    finally
      DBIOperator.VerificaNavegacao;
    end;
  end;
end;

procedure TFrmLancarEntradaMercadoriaPreCompra.btnEditarClick(Sender: TObject);
begin
  if DBIOperator.IsPopulate then
    DBIOperator.VerificaNavegacao;
  if QueryBuscaItensAtendidos.IsEmpty then
    TMessageDlg.MessageDlgRazem('Não há atendimento a ser editado.', mtWarning, [mbOK],0)
  else if DBIOperator.IsPopulate and (QuerySelectIndStatus.AsString <> 'A') then
    TMessageDlg.MessageDlgRazem('Operação não permitida, pois o atendimento já está confirmado.', mtWarning, [mbOK],0)
  else if (QuerySelectINDTIPOINCLUSAO.AsString <> 'M') then
    TMessageDlg.MessageDlgRazem('Operação não permitida, pois o tipo do lançamento é diferente de manual.', mtWarning, [mbOK],0)
  else if TInterfaceUsuario.Usuario.VerificaAcessoPrograma(ItemMenu.Tag, fAlterar, true) then
  begin
    Application.CreateForm(TfrmEntradaItemPc,frmEntradaItemPc);
    try
      frmEntradaItemPc.Visible := false;
      frmEntradaItemPc.PreparaForm(QuerySelect.FieldByName('id').AsInteger);
      frmEntradaItemPc.DadosEmpresa := DadosEmpresa;
      frmEntradaItemPc.ShowModal;
      if frmEntradaItemPc.ModalResult = mrOk then
      begin
        DBIOperator.DoClear;
        ednIdAtendimento.SetValue(frmEntradaItemPc.idAtendimento);
        DBIOperator.DoSelect;
      end;
    finally
      FreeAndNil(frmEntradaItemPc);
    end;
  end;
end;

procedure TFrmLancarEntradaMercadoriaPreCompra.btnFaturarClick(Sender: TObject);
begin
  DBIOperator.VerificaNavegacao;
  if QuerySelectSeqNota.AsInteger > 0 then
  begin
    TMessageDlg.MessageDlgRazem('Jà existe uma nota de entrada vinculada a este atendimento.' + sLineBreak +
               'Sequência da nota: ' + QuerySelectSeqNota.AsString, mtWarning, [mbOK],0);
    DBIOperator.VerificaNavegacao;
  end
  else if (TMessageDlg.MessageDlgRazem('Deseja realmente incluir a nota fiscal de entrada referente a este atendimento?',mtConfirmation,[mbYes,mbNo],0) = idYes) then
  begin
    TFormControl.AbreTelaSolicitada(38);
    FrmNotaFiscalEntrada.DBIOperator.DoClear;
    FrmNotaFiscalEntrada.SetItensAtendimPedido(trunc(ednIdAtendimento.GetValue)); //Popula os itens atendidos na nota
  end
  else
    DBIOperator.VerificaNavegacao;
end;

procedure TFrmLancarEntradaMercadoriaPreCompra.btnIrNotaClick(Sender: TObject);
begin
  if DBIOperator.IsPopulate then
    DBIOperator.VerificaNavegacao;

  if QuerySelect.FieldByName('seqnota').AsInteger > 0 then
  begin
    if TFormControl.AbreTelaSolicitada(38) then
    begin
      FrmNotaFiscalEntrada.codempresalogado := DadosEmpresa.CodEmpresa;
      FrmNotaFiscalEntrada.DBIOperator.DoClear;
      FrmNotaFiscalEntrada.cbIndPEStatus.Checked := False;
      FrmNotaFiscalEntrada.ednSeqNota.SetValue(QuerySelect.FieldByName('seqnota').AsFloat);
      FrmNotaFiscalEntrada.DBIOperator.DoSelect;
    end;
  end
  else
  begin
    TMessageDlg.MessageDlgRazem('Não há nota fiscal de entrada vinculada a este atendimento.', mtWarning, [mbOK], 0);
    DBIOperator.VerificaNavegacao;
  end;
end;

procedure TFrmLancarEntradaMercadoriaPreCompra.btnNovoClick(Sender: TObject);
begin
  if DBIOperator.IsPopulate then
    DBIOperator.VerificaNavegacao;

  if DBIOperator.IsPopulate and (QuerySelectIndStatus.AsString <> 'A') then
    TMessageDlg.MessageDlgRazem('Operação não permitida, pois o atendimento já está confirmado.', mtWarning, [mbOK],0)
  else if TInterfaceUsuario.Usuario.VerificaAcessoPrograma(ItemMenu.Tag,fIncluir,true) then
  begin
    try
      Application.CreateForm(TfrmEntradaItemPc,frmEntradaItemPc);
      frmEntradaItemPc.Visible := false;
      frmEntradaItemPc.DadosEmpresa := DadosEmpresa;
      frmEntradaItemPc.PreparaForm(0);
      frmEntradaItemPc.ShowModal;
      if frmEntradaItemPc.Modalresult = mrOk then
      begin
        if DBIOperator.IsPopulate then
          DBIOperator.VerificaNavegacao
        else
        begin
          IdAtendimento := frmEntradaItemPc.idAtendimento;
          PesquisaPosInsert := True;
          DBIOperator.DoSelect;
        end;
      end;
    finally
      FreeAndNil(frmEntradaItemPc);
    end;
  end;
end;

procedure TFrmLancarEntradaMercadoriaPreCompra.DBGridDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  TFuncoesDBGrid.ZebraDBGrid(TDBGrid(Sender), Rect, DataCol, Column, State);
end;

procedure TFrmLancarEntradaMercadoriaPreCompra.dbgrdDetalheTitleClick(
  Column: TColumn);
begin
  TFuncoesDBGrid.OrdenaGrid(dsBuscaItensAtendidos, Column, dbgrdDetalhe);
end;

procedure TFrmLancarEntradaMercadoriaPreCompra.DBGrid2DblClick(
  Sender: TObject);
begin
  if pgcHeranca.ActivePageIndex = 1 then
    pgcHeranca.ActivePageIndex := 0
  else
    if DBIOperator.CheckChanges then
      pgcHeranca.ActivePageIndex := 1;
end;

end.