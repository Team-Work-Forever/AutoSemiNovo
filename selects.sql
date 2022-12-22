-- Selecionar todos os cliente que fizeram aquisições no Stand
Select c.nome, c.nomeApelido, c.nif, c.nCC, c.dataNasc, c.telefone 
from cliente c, aquisicao a
where a.idCliente = c.idCliente;

-- Selecionar veiculos com ano entre 2000 e 2019, por ordem crescente do preço
Select matricula, precoBase, ano, garantia, foiVendido
from veiculo
where ano BETWEEN 2000 AND 2019 and foiVendido is TRUE
order by precoBase ASC;

-- Selecionar veiculos com tração Dianteira
Select v.matricula, v.precoBase, v.ano, v.quilometros, v.cilindrada, v.potencia, v.garantia, v.nPorta, v.lotacao, v.emissaoC02, v.consumoUrbano, v.nPneus, v.foiVendido, t.nome
from veiculo v, tracao t
where v.idTracao = t.idTracao and t.nome = 'Tracao Dianteira';

-- Selecionar fatura da aquisição
Select precoCIva, precoSIva, taxa, dataEmissao, extras
from fatura;

-- Selecionar todos os vendedores numa aquisição
Select v.nome, v.nomeApelido, v.telefone, a.numCompra, a.dataCompra
from vendedor v, aquisicao a, linhavendedor lv
where lv.idVendedor = v.idVendedor and lv.numCompra = a.numCompra;

-- Selecionar cliente que adquiriram veiculos de um tipo
select c.*, est.nome as estado
from infoveiculos v
inner join linhaCompra lc
    on v.matricula = lc.matricula
inner join aquisicao aq
    on lc.numCompra = aq.numCompra
inner join cliente c
    on aq.idCliente = c.idCliente
inner join estado est
    on est.idEstado = aq.idEstado
where v.tipoVeiculo = 'Carro'
;

-- Selecionar pneus de veiculo cuja matricula é 'RE-99-01'
select * from veiculosPneu where matricula = 'RE-99-01';

-- Selecionar Veiculos de um tipo e de uma marca
select matricula, tipoVeiculo, marca
from infoveiculos;

-- Selecionar o preco total de todos os veiculos em stock
select SUM(precoBase) as stockValue
from infoveiculos
where foiVendido is FALSE
;

-- Selecionar aquisições pagas, bem como as suas informações: Linhas de Vendedores, Fatura, Forma de Pagamento, Estado
select aq.numCompra, aq.dataCompra, aq.sinal, c.nome as cliente, est.nome as estado, v.nome as vendedor
from aquisicao aq
inner join cliente c
    on c.idCliente = aq.idCliente
inner join estado est
    on est.idEstado = aq.idEstado
right join fatura f
    on f.numCompra = aq.numCompra
inner join formapagamento fp
    on fp.idFPagamento = f.idFPagamento
inner join linhavendedor lv
    on lv.numCompra = aq.numCompra
inner join vendedor v
    on v.idVendedor = lv.idVendedor
;

-- Total que cada vendedor gerou ao stand autoseminovo
select
    v.nome || ' ' || v.nomeApelido as vendedor,
    sum(fat.precosiva) as totalVendido
from vendedor v
inner join linhavendedor lv
    on lv.idVendedor = v.idVendedor
inner join aquisicao aq
    on lv.numCompra = aq.numCompra
inner join estado est
    on aq.idEstado = est.idEstado
inner join fatura fat
    on fat.numCompra = aq.numCompra
where est.nome = 'Concluida'
group by vendedor
;

-- Selecionar Todas as aquisições de um Cliente, bem como os artigos
select
    aq.numCompra,
    aq.dataCompra,
    aq.sinal,
    est.nome as estado,
    lc.quantidade,
    lc.precoBase * lc.quantidade as precobase,
    v.matricula
from aquisicao aq
inner join cliente c
    on aq.idCliente = c.idCliente
inner join estado est
    on est.idEstado = aq.idEstado
inner join linhacompra lc
    on lc.numCompra = aq.numCompra
inner join infoveiculos v
    on lc.matricula = v.matricula
where aq.idCliente = 2
;

-- Ano em que a autoseminovo vendeu mais apartir de 2020
select
    fat.ano,
    max(fat.soma)
from 
(select
        extract(year from dataEmissao) as ano,
        sum(fat.precosiva) as soma
from fatura fat
group by extract(year from dataEmissao)
) fat
group by ano
having ano > 2020
;

-- Select veiculos e suas marcas
select
    iv.matricula,
    iv.marca,
    iv.modelo,
    iv.ano
from infoveiculos iv
where iv.foiVendido is false
;

-- Media de lucro por ano
select
    extract(year from dataEmissao) as ano,
    avg(precosiva)
from fatura fat
inner join aquisicao aq
    on fat.numCompra = aq.numCompra
inner join estado est
    on est.idEstado = aq.idEstado
group by extract(year from dataEmissao)
;