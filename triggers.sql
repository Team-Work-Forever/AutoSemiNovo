-- Trigger para precoSIva
create or replace function log_somar_extras()
  returns trigger 
  language plpgsql
  as
$$
begin
	if new.extras > 0 then

        update fatura
        set precosiva = precosiva + new.extras
        where numfatura = new.numfatura;
	end if;

	return new;
end;
$$;
create or replace trigger somar_extras
  after insert
  on fatura
  for each row
  execute procedure log_somar_extras();


-- Trigger fazer precoCIva
create or replace function log_preco_taxa()
  returns trigger 
  language plpgsql
  as
$$
begin
	if new.taxa > 0 then
        update fatura
        set precoCIva = precoSIva * (1 + (new.taxa / 100))
        where numfatura = new.numfatura;
	end if;

	return new;
end;
$$;
create or replace trigger preco_taxa
  after insert
  on fatura
  for each row
  execute procedure log_preco_taxa();