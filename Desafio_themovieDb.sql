--Dentre os filmes em cartaz, qual o filme com maior receita e qual sua receita e seu orçamento?
select tm.title, tm.revenue, tm.budget  from tb_movie
where now_playing = 'S' and 
tm.revenue in (select Max(revenue) from tb_movie);



/*Dentre as produtoras com filmes em cartaz ou filmes a serem lançados, qual teve o maior lucro (receita 
– orçamento) acumulado nos últimos 10 anos? Considere que o lucro é distribuído igualmente entre as
companhias produtoras.*/


select 
tpc.production_companies,
(tm.revenue - tm.budget) as lucro, 
YEAR(tm.release_date) as ano
from tb_movie tm
inner join production_companies  tpc
on tpc.id_production_companies = tm.id_production_companies
where tm.now_playing = 'S' or tm.up_coming = 'S'
and ano >= '2010' 
group by 1
order by 2 desc
limit 1;
 


--Que diretor(a) dirigiu filmes com o maior orçamento acumulado dos últimos 20 anos?

select 
tp.name,
sum(tm.budget) as acumulado, 
YEAR(tm.release_date) as ano
from tb_movie tm
inner join tb_cast tc
on tc.id_movie = tm.movie
inner join crew tcw
on tcw.id_person = tc.id_person
inner join tb_person tp
on tp.id_person = tc.id_person
where tc.job = 'Director'
and ano >= '2000' 
group by 1
order by 2 desc;
 



--Quais os 3 gêneros com maior número de filmes nos últimos 5 anos

select * from (
select count (tm.movies),
YEAR(release_date) as ano,  tg.genres
 from tb_movie tm
inner join genres tg
on tg.id_genres = tm.id_genres 
where ano >= '2015' 
order by 1 desc)
limit 3; 




--Quais os países com a maior quantidade de filmes em cartaz produzidos em seus territórios?

select count (tm.movies), tpc. production_country  from tb_movie tm
inner join tb_production_companies tpc
on tpc.  production_countries = tm.  production_countries 
group by 2
order by 1 desc;