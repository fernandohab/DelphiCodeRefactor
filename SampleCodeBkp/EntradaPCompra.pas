unit EntradaPCompra;

interface

uses
  USUARIO.InterfaceUsuario,EntradaPCompra.Classes, DB, System.SysUtils, EntradaPCompra.BD,
  SPKESTOQUE.InterfaceEstoque, SPKPARCEIRO.InterfaceParceiro, Dialogs, System.UITypes;

type
  TSPKPreCompra = class
  private
  public
    constructor Create;
    destructor Destroy; override;
    function GetValUnitFornecedorTabPreco(aCodFornecedor, aCodItem: Integer): Double;
  end;

  TStcSPKPreCompra = class
  private
    class var FSPKPreCompra: TSPKPreCompra;
    class function GetSPKPreCompra: TSPKPreCompra; Static;
  public
    class property SPKPreCompra: TSPKPreCompra read GetSPKPreCompra;
  end;


  TDadosItemPComp = record
    ID                 : Integer;
    CODATENDIMENTO     : Integer;
    SEQITEMPEDIDO      : Integer;
    SEQITEM            : Integer;
    SEQGRADE           : Integer;
    QUANTIDADE         : Double;
    QTDITEMCONVERTIDO  : Double;
  end;

  TGerenciaEntradaPCompra = class(TObject)
  private
    FEntradaPComp: TEntradaPComp;
    FEntradaPCompBD: TEntradaPCompBD;
    procedure SetEntradaPComp(Sender: TEntradaPComp);
  public
    constructor Create;
    function CriaInsereEntradaPComp(cTPInclusao:string; var ID: Integer): Boolean;
    function DeletaCabEntradaPComp(ID:Integer):boolean;
    function CriaInsereEntradaItemPComp(aDadosItem: TDadosItemPComp):Boolean;
    function DeletaEntradaItemPComp(cDataSetItens:TDataSet;IDAtendimPComp:integer):Boolean;
    function AtualizaQtdAtendidaPComp(aQtdItemConvertido: Double;
      aCodAtendimento, aSeqItemAtendimento: Integer; aOperacao: string):Boolean;
    function AtualizaQtdFaturadaPComp(aQtdItemConvertido: Double;
      aCodAtendimento, aSeqItemAtendimento: Integer; aOperacao: string):Boolean;
    function UpdateStatusEntradaPComp(ID:Integer;cStatus:string):boolean;
    function DatasetItemParaTDadosItemPComp(aDataSetItem: TDataSet; aId: Integer): TDadosItemPComp;
    destructor Destroy; OverRide;
  end;

implementation

uses
  SPKFalha, SPKFalha.Consts,SPKBancoDados.DMConexaoSPK,SPKFalha.LogErro,  SPKBiblioteca;

{ TGerenciaEntradaPCompra }

constructor TGerenciaEntradaPCompra.Create;
begin
  FEntradaPCompBD := TEntradaPCompBD.Create;
end;

function TGerenciaEntradaPCompra.CriaInsereEntradaPComp(cTPInclusao:string; var ID: Integer): Boolean;
const
  cInstMetodo = '''TEntradaPCompBD.CriaInsertEntradaPComp'' responsável por converter o dataset para classe entrada pedido de compra e inserir no BD.';
var
  vEntradaPComp: TEntradaPComp;
begin
  try
    Result := False;
    vEntradaPComp := TEntradaPComp.Create;
    if ID = 0 then
      ID := DMConexaoSPK.ObtemSequenciaGenerator('GENENTRADAPCOMP');
    vEntradaPComp.ID := ID;
    vEntradaPComp.INDTIPOINCLUSAO := cTPInclusao;
    vEntradaPComp.DATAAtendimento := DMConexaoSPK.ObtemDataAtual;
    vEntradaPComp.USUARIO := TInterfaceUsuario.Usuario.Nome;
    vEntradaPComp.INDSTATUS := 'A';
    SetEntradaPComp(vEntradaPComp);
    Result := FEntradaPCompBD.InsertCabAtendPComp(vEntradaPComp);
  except
    on E: Exception do
      RaiseSPK(E,Format(cMsgInstFalha,[cInstMetodo, E.Message]));
  end;
end;

function TGerenciaEntradaPCompra.DatasetItemParaTDadosItemPComp(
  aDataSetItem: TDataSet; aId: Integer): TDadosItemPComp;
begin
  Result.ID := aId;
  Result.CODATENDIMENTO := aDataSetItem.FieldByName('CODATENDIMENTO').AsInteger;
  Result.SEQITEMPEDIDO := aDataSetItem.FieldByName('SEQITEMPEDIDO').AsInteger;
  Result.SEQITEM := aDataSetItem.FieldByName('SEQITEM').AsInteger;
  if Result.SEQITEM <= 0 then
    Result.SEQITEM := aDataSetItem.RecNo;
  Result.SEQGRADE := aDataSetItem.FieldByName('SEQGRADE').AsInteger;
  Result.QUANTIDADE := aDataSetItem.FieldByName('QUANTIDADE').AsFloat;
  Result.QTDITEMCONVERTIDO := aDataSetItem.FieldByName('QTDITEMCONVERTIDO').AsFloat;
end;

function TGerenciaEntradaPCompra.DeletaCabEntradaPComp(ID:Integer):boolean;
const
  cInstMetodo = '''TEntradaPCompBD.DeletaCabEntradaPComp'' responsável por Excluir o atendimento do pedido de compra do banco de dados.';
var
  vEntradaPComp: TEntradaPComp;
begin
  try
    result := false;
    vEntradaPComp := TEntradaPComp.Create;
    vEntradaPComp.id := ID;
    SetEntradaPComp(vEntradaPComp);
    Result := FEntradaPCompBD.DeleteCabAtendPComp(vEntradaPComp);
  except
    on E: Exception do
      RaiseSPK(E,Format(cMsgInstFalha,[cInstMetodo, E.Message]));
  end;
end;


function TGerenciaEntradaPCompra.CriaInsereEntradaItemPComp(
  aDadosItem: TDadosItemPComp): Boolean;
const
  cInstMetodo = '''TEntradaPCompBD.CriaInsereEntradaItemPComp'' responsável por converter o dataset dos itens para classe entrada pedido de compra e inserir no BD.';
var
  vEntradaPComp: TEntradaPComp;
  vItem: TItemEntradaPComp;
  vItens: TItensEntradaPComp;
begin
  try
    Result := False;
    vEntradaPComp := TEntradaPComp.Create;
    vEntradaPComp.ID := aDadosItem.ID;
    vItens := TItensEntradaPComp.Create;
    if ((aDadosItem.QUANTIDADE > 0) and
        (aDadosItem.SEQITEMPEDIDO > 0)) then
    begin
      vItem := TItemEntradaPComp.Create;
      vItem.ID := vEntradaPComp.ID;
      vItem.SEQITEM := aDadosItem.SEQITEM;
      vItem.SEQGRADE := aDadosItem.SEQGRADE;
      vItem.QTDITEM := aDadosItem.QUANTIDADE;
      vItem.INDFATURADO := 'N';
      vItem.DATAENTRADA := DMConexaoSPK.ObtemDataAtual;
      vItem.HORAENTRADA := FormatDateTime('HH:MM',DMConexaoSPK.ObtemDataHoraAtual);
      vItem.USUARIOENTRADA := TInterfaceUsuario.Usuario.Nome;
      vItem.CODATENDIMENTO := aDadosItem.CODATENDIMENTO;
      vItem.SEQITEMPEDIDO := aDadosItem.SEQITEMPEDIDO;
      vItens.Add(vItem);
      vEntradaPComp.Itens := vItens;
      SetEntradaPComp(vEntradaPComp);
      Result := FEntradaPCompBD.InsertItemAtendPComp(vEntradaPComp);
    end;
  except
    on E: Exception do
      RaiseSPK(E,Format(cMsgInstFalha,[cInstMetodo, E.Message]));
  end;
end;

function TGerenciaEntradaPCompra.DeletaEntradaItemPComp(cDataSetItens:TDataSet;IDAtendimPComp:integer):Boolean;
const
  cInstMetodo = '''TEntradaPCompBD.DeletaEntradaItemPComp'' responsável por deletar os itens do pedido de compra do BD.';
var
  vEntradaPComp: TEntradaPComp;
  vItem: TItemEntradaPComp;
  vItens: TItensEntradaPComp;
begin
  try
    Result := False;
    vEntradaPComp := TEntradaPComp.Create;
    vItens := TItensEntradaPComp.Create;
    if cDataSetItens.FieldByName('SEQITEMPEDIDO').AsInteger > 0 then
    begin
      vItem := TItemEntradaPComp.Create;
      vItem.ID := IDAtendimPComp;
      vItem.CODATENDIMENTO := cDataSetItens.FieldByName('CODATENDIMENTO').AsInteger;
      vItem.SEQITEMPEDIDO := cDataSetItens.FieldByName('SEQITEMPEDIDO').AsInteger;
      vItens.Add(vItem);
      vEntradaPComp.Itens := vItens;
      SetEntradaPComp(vEntradaPComp);
      Result := FEntradaPCompBD.DeleteItemAtendPComp(vEntradaPComp);
    end;
  except
    on E: Exception do
      RaiseSPK(E,Format(cMsgInstFalha,[cInstMetodo, E.Message]));
  end;
end;

function TGerenciaEntradaPCompra.AtualizaQtdAtendidaPComp(aQtdItemConvertido: Double;
  aCodAtendimento, aSeqItemAtendimento: Integer; aOperacao: string): Boolean;
const
cInstMetodo = '''TEntradaPCompBD.AtualizaQtdAtendidaPComp'' responsável por atualizar a qtd atendida no pedido de compra.';
var
  vEntradaPComp: TEntradaPComp;
  vItem: TItemEntradaPComp;
  vItens: TItensEntradaPComp;
begin
  try
    vEntradaPComp := TEntradaPComp.Create;
    vItens := TItensEntradaPComp.Create;
    vItem := TItemEntradaPComp.Create;
    vItem.QTDITEM := aQtdItemConvertido;
    vItem.CODATENDIMENTO := aCodAtendimento;
    vItem.SEQITEMPEDIDO := aSeqItemAtendimento;
    vItens.Add(vItem);
    vEntradaPComp.Itens := vItens;
    SetEntradaPComp(vEntradaPComp);
    Result := FEntradaPCompBD.UpdateQtdAtendida(vEntradaPComp,aOperacao);
  except
    on E: Exception do
      RaiseSPK(E,Format(cMsgInstFalha,[cInstMetodo, E.Message]));
  end;
end;

function TGerenciaEntradaPCompra.AtualizaQtdFaturadaPComp(aQtdItemConvertido: Double;
  aCodAtendimento, aSeqItemAtendimento: Integer; aOperacao: string): Boolean;
const
  cInstMetodo = '''TEntradaPCompBD.AtualizaQtdFaturadaPComp'' responsável por atualizar a qtd faturada no pedido de compra.';
var
  _EntradaPComp: TEntradaPComp;
  _Item: TItemEntradaPComp;
  _Itens: TItensEntradaPComp;
begin
  try
    _EntradaPComp := TEntradaPComp.Create;
    _Itens := TItensEntradaPComp.Create;
    _Item := TItemEntradaPComp.Create;
    _Item.QTDITEM := aQtdItemConvertido;
    _Item.CODATENDIMENTO := aCodAtendimento;
    _Item.SEQITEMPEDIDO := aSeqItemAtendimento;
    _Itens.Add(_Item);
    _EntradaPComp.Itens := _Itens;
    SetEntradaPComp(_EntradaPComp);
    Result := FEntradaPCompBD.UpdateFaturamento(_EntradaPComp,aOperacao);
  except
    on E: Exception do
      RaiseSPK(E,Format(cMsgInstFalha,[cInstMetodo, E.Message]));
  end;
end;

function TGerenciaEntradaPCompra.UpdateStatusEntradaPComp(ID:Integer;cStatus:string):boolean;
const
  cInstMetodo = '''TEntradaPCompBD.UpdateStatusEntradaPComp'' responsável por atualizar o status do atendimento do pedido de compra.';
var
  vEntradaPComp: TEntradaPComp;
begin
  try

    Result := False;
    vEntradaPComp := TEntradaPComp.Create;
    vEntradaPComp.id := ID;
    vEntradaPComp.INDSTATUS := cStatus;
    SetEntradaPComp(vEntradaPComp);
    Result := FEntradaPCompBD.UpdateStatusAtendPComp(vEntradaPComp);
  except
    on E: Exception do
      RaiseSPK(E,Format(cMsgInstFalha,[cInstMetodo, E.Message]));
  end;
end;

destructor TGerenciaEntradaPCompra.Destroy;
begin
  if FEntradaPComp <> Nil then
    FreeAndNil(FEntradaPComp);
  FreeAndNil(FEntradaPCompBD);
end;


procedure TGerenciaEntradaPCompra.SetEntradaPComp(Sender: TEntradaPComp);
begin
  if FEntradaPComp <> Nil then
    FreeAndNil(FEntradaPComp);
  FEntradaPComp := Sender;
end;

{ TSPKPreCompra }

constructor TSPKPreCompra.Create;
begin

end;

destructor TSPKPreCompra.Destroy;
begin

  inherited;
end;

function TSPKPreCompra.GetValUnitFornecedorTabPreco(aCodFornecedor,
  aCodItem: Integer): Double;
var
  _DadosFornecedor: TDadosFornecedor;
begin
  Result := 0;
  _DadosFornecedor := TInterfaceParceiro.SpkParceiro.GetDadosFornecedor(aCodFornecedor);

  if _DadosFornecedor.CodTabelaCusto > 0 then
    Result := TInterfaceEstoque.Estoque.GetValUnitarioTabelaPreco(aCodItem, _DadosFornecedor.CodTabelaCusto);

end;

{ TStcSPKPreCompra }

class function TStcSPKPreCompra.GetSPKPreCompra: TSPKPreCompra;
begin
  if FSPKPreCompra = Nil then
    FSPKPreCompra := TSPKPreCompra.Create;
  Result := FSPKPreCompra;
end;

initialization
  TStcSPKPreCompra.FSPKPreCompra := Nil;

finalization
  FreeAndNil(TStcSPKPreCompra.FSPKPreCompra);

end.