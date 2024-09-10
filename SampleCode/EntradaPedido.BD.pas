unit EntradaPedido.BD;

interface

uses
  EntradaPedidora.Classes, System.SysUtils, System.Classes;
trad

type trad
  TEntradaPedidoBD = class
  public
	function NewInsertCabAtendPedido(Sender: TEntradaPedido): Boolean;
    function InsertCabAtendPedido(Sender: TEntradaPedido): Boolean;
    function DeleteCabAtendPedido(Sender: TEntradaPedido):Boolean;
    function InsertItemAtendPedido(Sender: TEntradaPedido):Boolean;
    function DeleteItemAtendPedido(Sender: TEntradaPedido):Boolean;
    function UpdateQtdAtendida(Sender: TEntradaPedido;pOperacao:string): Boolean;
    function UpdateFaturamento(Sender: TEntradaPedido;pOperacao:string):Boolean;
    function UpdateStatusAtendPedido(Sender: TEntradaPedido):Boolean;
  end;

implementation

uses
  AMGFalha, AMGFalha.Consts,AMGBancoDados.DMConexaoAMG,AMGFalha.LogErro, uDataModulePrincipal;

{ TEntradaPedidoBD }


function TEntradaPedidoBD.InsertCabAtendPedido(Sender: TEntradaPedido): Boolean;
const
  cDescMetodo = '''TEntradaPedidoBD.InsertCabAtendPedido'' responsável por inserir no BD o cabecalho do atendimneto do pedido de compra.';
var
  I: Integer;
var
  slScripts: TStringList;
begin
  try
    Result := False;
    slScripts := Sender.GetScriptsInsertCabAtendPedido;
    try
      for I := 0 to slScripts.Count - 1 do
        DMConexaoAMG.DBGenerico.ExecSQL(slScripts.Strings[I]);
      Result := True;
    finally
      FreeAndNil(slScripts);
    end;
  except
    on E: Exception do
      RaiseAMG(E,format(cMsgInstFalha,[cDescMetodo, E.Message]));
  end;
end;


function TEntradaPedidoBD.InsertCabAtendPedido(Sender: TEntradaPedido): Boolean;
const
  cDescMetodo = '''TEntradaPedidoBD.InsertCabAtendPedido'' responsável por inserir no BD o cab do atendimneto do pedido de compra.';
var
  I: Integer;
var
  slScripts: TStringList;
begin
  try
    Result := False;
    slScripts := Sender.GetScriptsInsertCabAtendPedido;
    try
      for I := 0 to slScripts.Count - 1 do
        DMConexaoAMG.DBGenerico.ExecSQL(slScripts.Strings[I]);
      Result := True;
    finally
      FreeAndNil(slScripts);
    end;
  except
    on E: Exception do
      RaiseAMG(E,format(cMsgInstFalha,[cDescMetodo, E.Message]));
  end;
end;

function TEntradaPedidoBD.DeleteCabAtendPedido(Sender: TEntradaPedido): Boolean;
const
  cDescMetodo = '''TEntradaPedidoBD.DeleteCabAtendPedido'' responsável por deletar do BD o cabecalho do atendimneto do pedido de compra.';
var
  I: Integer;
var
  slScripts: TStringList;
begin
  try
    Result := False;
    slScripts := Sender.GetScriptsDeleteCabAtendPedido;
    try
      for I := 0 to slScripts.Count - 1 do
        DMConexaoAMG.DBGenerico.ExecSQL(slScripts.Strings[I]);
      Result := True;
    finally
      FreeAndNil(slScripts);
    end;
  except
    on E: Exception do
      RaiseAMG(E,format(cMsgInstFalha,[cDescMetodo, E.Message]));
  end;
end;

function TEntradaPedidoBD.InsertItemAtendPedido(Sender: TEntradaPedido): Boolean;
const
  cDescMetodo = '''TEntradaPedidoBD.InsertItemAtendPedido'' responsável por inserir no BD o item do atendimneto do pedido de compra.';
var
  I: Integer;
var
  slScripts: TStringList;
begin
  try
    Result := False;
    slScripts := Sender.GetScriptsInsertItemAtendPedido;
    try
      for I := 0 to slScripts.Count - 1 do
        DMConexaoAMG.DBGenerico.ExecSQL(slScripts.Strings[I]);
      Result := True;
    finally
      FreeAndNil(slScripts);
    end;
  except
    on E: Exception do
      RaiseAMG(E,format(cMsgInstFalha,[cDescMetodo, E.Message]));
  end;
end;


function TEntradaPedidoBD.DeleteItemAtendPedido(Sender: TEntradaPedido): Boolean;
const
  cDescMetodo = '''TEntradaPedidoBD.DeleteItemAtendPedido'' responsável por deletar do BD o item do atendimento do pedido de compra.';
var
  I: Integer;
var
  slScripts: TStringList;
begin
  try
    Result := False;
    slScripts := Sender.GetScriptsDeleteItemAtendPedido;
    try
      for I := 0 to slScripts.Count - 1 do
        DMConexaoAMG.DBGenerico.ExecSQL(slScripts.Strings[I]);
      Result := True;
    finally
      FreeAndNil(slScripts);
    end;
  except
    on E: Exception do
      RaiseAMG(E,format(cMsgInstFalha,[cDescMetodo, E.Message]));
  end;
end;

function TEntradaPedidoBD.UpdateQtdAtendida(Sender: TEntradaPedido; pOperacao: string): Boolean;
const
  cDescMetodo = '''TEntradaPedidoBD.UpdateQtdAtendida'' responsável por atualizar as qtds atendidas no BD.';
var
  I: Integer;
var
  slScripts: TStringList;
begin
  try
    Result := False;
    slScripts := Sender.GetScriptsUpdateQtdAtendida(pOperacao);

    try
      for I := 0 to slScripts.Count - 1 do
        DMConexaoAMG.DBGenerico.ExecSQL(slScripts.Strings[I]);
      Result := True;
    finally
      FreeAndNil(slScripts);
    end;
  except
    on E: Exception do
      RaiseAMG(E,format(cMsgInstFalha,[cDescMetodo, E.Message]));
  end;
end;

function TEntradaPedidoBD.UpdateFaturamento(Sender: TEntradaPedido;
  pOperacao: string): Boolean;
const
  cDescMetodo = '''TEntradaPedidoBD.UpdateFaturamento'' responsável por atualizar as qtds faturadas no BD.';
var
  I: Integer;
var
  slScripts: TStringList;
begin
  try
    Result := False;
    slScripts := Sender.GetScriptsUpdateFaturamento(pOperacao);

    try
      for I := 0 to slScripts.Count - 1 do
        DMConexaoAMG.DBGenerico.ExecSQL(slScripts.Strings[I]);
      Result := True;
    finally
      FreeAndNil(slScripts);
    end;
  except
    on E: Exception do
      RaiseAMG(E,format(cMsgInstFalha,[cDescMetodo, E.Message]));
  end;
end;

function TEntradaPedidoBD.UpdateStatusAtendPedido(Sender:TEntradaPedido): Boolean;
const
  cDescMetodo = '''TEntradaPedidoBD.UpdateStatusAtendPedido'' responsável por atualizar o Status do Atendimento do Pedido de Verndas no BD.';
var
  I: Integer;
var
  slScripts: TStringList;
begin
  try
    Result := False;
    slScripts := Sender.GetScriptsUpdateStatusAtendPedido;
    try
      for I := 0 to slScripts.Count - 1 do
        DMConexaoAMG.DBGenerico.ExecSQL(slScripts.Strings[I]);
      Result := True;
    finally
      FreeAndNil(slScripts);
    end;
  except
    on E: Exception do
      RaiseAMG(E,format(cMsgInstFalha,[cDescMetodo, E.Message]));
  end;
end;
end.