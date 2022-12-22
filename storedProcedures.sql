-- Pagar compra
Create OR replace PROCEDURE pagarCompra (
    c_aquisicao int,
    c_extras int,
    c_idFPagamento int
)
LANGUAGE plpgsql AS
$$
DECLARE
    _totalPreco int;
BEGIN

    update aquisicao
    set idEstado = 1
    where numCompra = c_aquisicao;

    select
        quantidade * precobase as total
    from linhacompra
    where numCompra = c_aquisicao
    into _totalPreco; 

    insert into 
    fatura (precosiva, taxa, extras, numCompra, idFPagamento) 
    values (_totalPreco, 23, c_extras, c_aquisicao, c_idFPagamento);

    update veiculo
    set foiVendido = true
    where matricula = (
        select 
            matricula
        from linhacompra lc
        where numCompra = c_aquisicao
    );

END $$;