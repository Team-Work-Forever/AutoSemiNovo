-- Index para identificar mais rapidamente veiculos
create unique index indexMatricula
on veiculo (matricula);

-- Index para identificar mais rapidamente aquisicoes
create unique index indexAquisicao
on aquisicao (numCompra);