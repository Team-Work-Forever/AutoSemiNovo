-- Updates 

-- Retificar precoBase de veiculo de 18500€ para 15890€
update veiculo
set precoBase = 15890
where matricula = '52-NE-29';

-- Aquisicao passar de estado em Progresso -> Concluido
update aquisicao
set idEstado = 1
where numCompra = 4;

update veiculo
set foiVendido = true
where matricula = '94-LD-53';


-- Deletes

-- Remover Carro com matricula 
delete from formapagamento
where idFPagamento = 5;