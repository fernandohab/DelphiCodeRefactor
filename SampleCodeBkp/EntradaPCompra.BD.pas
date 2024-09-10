unit EntradaPCompra.BD;

interface

uses
  EntradaPCompra.Classes, System.SysUtils, System.Classes;

type
  TEntradaPCompBD = class
  public
    function InsertCabAtendPComp(Sender: TEntradaPComp): Boolean;
    function DeleteCabAtendPComp(Sender: TEntradaPComp):Boolean;
    function InsertItemAtendPComp(Sender: TEntradaPComp):Boolean;
    function DeleteItemAtendPComp(Sender: TEntradaPComp):Boolean;
    function UpdateQtdAtendida(Sender: TEntradaPComp;pOperacao:string): Boolean;
    function UpdateFaturamento(Sender: TEntradaPComp;pOperacao:string):Boolean;
    function UpdateStatusAtendPComp(Sender: TEntradaPComp):Boolean;
  end;

implementation

uses
  SPKFalha, SPKFalha.Consts,SPKBancoDados.DMConexaoSPK,SPKFalha.LogErro, uDataModulePrincipal;

{ TEntradaPCompBD }

function TEntradaPCompBD.InsertCabAtendPComp(Sender: TEntradaPComp): Boolean;
const
  cInstMetodo = '''TEntradaPCompBD.InsertCabAtendPComp'' responsável por inserir no BD o cab do atendimneto do pedido de compra.';
var
  I: Integer;
var
  vScripts: TStringList;
begin
  try
    Result := False;
    vScripts := Sender.GetScriptsInsertCabAtendPComp;
    try
      for I := 0 to vScripts.Count - 1 do
        DMConexaoSPK.DBGenerico.ExecSQL(vScripts.Strings[I]);
      Result := True;
    finally
      FreeAndNil(vScripts);
    end;
  except
    on E: Exception do
      RaiseSPK(E,format(cMsgInstFalha,[cInstMetodo, E.Message]));
  end;
end;

function TEntradaPCompBD.DeleteCabAtendPComp(Sender: TEntradaPComp): Boolean;
const
  cInstMetodo = '''TEntradaPCompBD.DeleteCabAtendPComp'' responsável por deletar do BD o cabecalho do atendimneto do pedido de compra.';
var
  I: Integer;
var
  vScripts: TStringList;
begin
  try
    Result := False;
    vScripts := Sender.GetScriptsDeleteCabAtendPComp;
    try
      for I := 0 to vScripts.Count - 1 do
        DMConexaoSPK.DBGenerico.ExecSQL(vScripts.Strings[I]);
      Result := True;
    finally
      FreeAndNil(vScripts);
    end;
  except
    on E: Exception do
      RaiseSPK(E,format(cMsgInstFalha,[cInstMetodo, E.Message]));
  end;
end;

function TEntradaPCompBD.InsertItemAtendPComp(Sender: TEntradaPComp): Boolean;
const
  cInstMetodo = '''TEntradaPCompBD.InsertItemAtendPComp'' responsável por inserir no BD o item do atendimneto do pedido de compra.';
var
  I: Integer;
var
  vScripts: TStringList;
begin
  try
    Result := False;
    vScripts := Sender.GetScriptsInsertItemAtendPComp;
    try
      for I := 0 to vScripts.Count - 1 do
        DMConexaoSPK.DBGenerico.ExecSQL(vScripts.Strings[I]);
      Result := True;
    finally
      FreeAndNil(vScripts);
    end;
  except
    on E: Exception do
      RaiseSPK(E,format(cMsgInstFalha,[cInstMetodo, E.Message]));
  end;
end;


function TEntradaPCompBD.DeleteItemAtendPComp(Sender: TEntradaPComp): Boolean;
const
  cInstMetodo = '''TEntradaPCompBD.DeleteItemAtendPComp'' responsável por deletar do BD o item do atendimento do pedido de compra.';
var
  I: Integer;
var
  vScripts: TStringList;
begin
  try
    Result := False;
    vScripts := Sender.GetScriptsDeleteItemAtendPComp;
    try
      for I := 0 to vScripts.Count - 1 do
        DMConexaoSPK.DBGenerico.ExecSQL(vScripts.Strings[I]);
      Result := True;
    finally
      FreeAndNil(vScripts);
    end;
  except
    on E: Exception do
      RaiseSPK(E,format(cMsgInstFalha,[cInstMetodo, E.Message]));
  end;
end;

function TEntradaPCompBD.UpdateQtdAtendida(Sender: TEntradaPComp; pOperacao: string): Boolean;
const
  cInstMetodo = '''TEntradaPCompBD.UpdateQtdAtendida'' responsável por atualizar as qtds atendidas no BD.';
var
  I: Integer;
var
  vScripts: TStringList;
begin
  try
    Result := False;
    vScripts := Sender.GetScriptsUpdateQtdAtendida(pOperacao);

    try
      for I := 0 to vScripts.Count - 1 do
        DMConexaoSPK.DBGenerico.ExecSQL(vScripts.Strings[I]);
      Result := True;
    finally
      FreeAndNil(vScripts);
    end;
  except
    on E: Exception do
      RaiseSPK(E,format(cMsgInstFalha,[cInstMetodo, E.Message]));
  end;
end;

function TEntradaPCompBD.UpdateFaturamento(Sender: TEntradaPComp;
  pOperacao: string): Boolean;
const
  cInstMetodo = '''TEntradaPCompBD.UpdateFaturamento'' responsável por atualizar as qtds faturadas no BD.';
var
  I: Integer;
var
  vScripts: TStringList;
begin
  try
    Result := False;
    vScripts := Sender.GetScriptsUpdateFaturamento(pOperacao);

    try
      for I := 0 to vScripts.Count - 1 do
        DMConexaoSPK.DBGenerico.ExecSQL(vScripts.Strings[I]);
      Result := True;
    finally
      FreeAndNil(vScripts);
    end;
  except
    on E: Exception do
      RaiseSPK(E,format(cMsgInstFalha,[cInstMetodo, E.Message]));
  end;
end;

function TEntradaPCompBD.UpdateStatusAtendPComp(Sender:TEntradaPComp): Boolean;
const
  cInstMetodo = '''TEntradaPCompBD.UpdateStatusAtendPComp'' responsável por atualizar o Status do Atendimento do Pedido de Verndas no BD.';
var
  I: Integer;
var
  vScripts: TStringList;
begin
  try
    Result := False;
    vScripts := Sender.GetScriptsUpdateStatusAtendPComp;
    try
      for I := 0 to vScripts.Count - 1 do
        DMConexaoSPK.DBGenerico.ExecSQL(vScripts.Strings[I]);
      Result := True;
    finally
      FreeAndNil(vScripts);
    end;
  except
    on E: Exception do
      RaiseSPK(E,format(cMsgInstFalha,[cInstMetodo, E.Message]));
  end;
end;
end.