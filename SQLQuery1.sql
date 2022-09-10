/* ISHOD 5*/

/*1*/
select * from Grad
select * from Kupac
select * from Racun

select distinct g.naziv, sum(r.KupacID) as 'Broj Kupaca' from Grad as g
inner join Kupac as k on k.GradID = g.IDGrad
inner join racun as r on k.IDkupac = r.KupacID
group by g.Naziv



/*2*/

select Ime, Prezime, 'Provjeriti' as ALERT from Kupac WHERE (Prezime LIKE '%''%')


/*3*/
select * from Kupac
select * from Racun
select month(r.DatumIzdavanja) as BrojMjeseca, k.Ime, k.Prezime, sum(r.IDRacun) as brojRacuna  from Racun as r
left join kupac as k on k.IDKupac = r.KupacID
group by r.IDRacun, r.DatumIzdavanja, k.Ime, K.Prezime



/*4*/
select * from Stavka
select * from Racun

select sum(s.UkupnaCijena) as 'SUMA', month(r.DatumIzdavanja) as 'Mjesec' from stavka as S
left join racun as r on r.IDRacun = s.RacunID
group by month(r.DatumIzdavanja)
order by month(r.DatumIzdavanja) asc


/*ISHOD 6*/

/*1*/

select distinct g.Naziv
from Grad as g
where g.IDGrad in (
    select k.GradID
    from Kupac as k
    where k.IDKupac in (
        select r.KupacID
        from Racun as r 
        where r.KomercijalistID in (
            select kom.IDKomercijalist
            from Komercijalist as kom
            where kom.ime = 'Miro' and kom.Prezime = 'Mirić' 
        )
    )
)

/*ili*/

select distinct g.Naziv from Grad as g
where g.IDGrad in (select k.GradID from Kupac as k where k.IDKupac 
in (select r.KupacID from racun as r where r.KomercijalistID
in (select kom.IDKomercijalist from Komercijalist as kom
where kom.ime = 'Miro' and kom.Prezime = 'Mirić')
)
)


/*2*/
SELECT g.Naziv, (
    SELECT COUNT(r.KreditnaKarticaID)
    FROM Kupac AS k
    INNER JOIN Racun AS r ON r.KupacID=k.IDKupac
    WHERE k.GradID=g.IDGrad 
    AND r.KreditnaKarticaID IS NOT NULL
) AS 'BrojRacunaPlacenihKarticom'
FROM Grad AS g
ORDER BY BrojRacunaPlacenihKarticom DESC


/*3*/
select pk.Naziv, (
	select count(*)
	from Proizvod as p
	where p.PotkategorijaID = pk.IDPotkategorija
) as 'brojProizvoda'
from Potkategorija as pk
where (
	select count(*)
	from Proizvod as p
	where p.PotkategorijaID = pk.IDPotkategorija
) < (
	select count(p1.IDProizvod) / (
	select count(pk2.IDPotkategorija)
	from Potkategorija as pk2 
)
from Proizvod as p1
inner join Potkategorija as pk1 on pk1.IDPotkategorija = p1.PotkategorijaID
)


/*4*/
select kom.Ime, kom.Prezime, (
	select top 1 r.DatumIzdavanja
	from racun as r
	where r.KomercijalistID = kom.IDKomercijalist
	order by r.DatumIzdavanja desc
)
from Komercijalist as kom


/*ISHOD 5*/

/*1*/
select * from Kupac
select * from Grad
select * from Drzava

select d.Naziv,g.Naziv,k.Ime, k.Prezime,'PROVJERITI' as 'ALERT' from drzava as d
inner join grad as g on g.DrzavaID = d.IDDrzava
inner join kupac as k on k.GradID = g.IDGrad
where (k.prezime like '%č%' 
or k.prezime like '%ć%'
or k.prezime like '%š%'
or k.prezime like '%đ%'
or k.prezime like '%ž%'
or k.ime like '%č%'
or k.ime like '%ć%'
or k.ime like '%š%'
or k.ime like '%đ%'
or k.ime like '%ž%')

/*2*/
select * from Racun

select IDRacun, FORMAT(DatumIzdavanja,'dd-MM-yy') from Racun

/*3*/

select * from Kupac
select * from Racun

select k.ime, k.prezime,(select count(r.KreditnaKarticaID)
from racun as r where r.KupacID=k.IDKupac) as Kartica from kupac as k

/*4*/
select * from Racun
select * from Stavka

select r.KreditnaKarticaID,(select sum(s.UkupnaCijena) from Stavka as s where s.RacunID = r.IDRacun)as Suma from Racun as r
where Suma < 3


/*ISHOD 6*/

/*1*/
select * from Racun
select * from Stavka

select r.IDRacun,r.DatumIzdavanja,(select sum(s.UkupnaCijena) from Stavka as s where s.RacunID = r.IDRacun)as UkupnaCijena from Racun as r

/*2*/

select * from Komercijalist
select * from Racun
select * from Stavka
select * from Proizvod

select k.Ime, k.Prezime from komercijalist as k
where k.IDKomercijalist in (select r.KomercijalistID from racun as r where r.IDRacun
in (select s.RacunID from Stavka as s where s.ProizvodID
in (select p.IDProizvod from Proizvod as p where p.Boja = 'šarena')))


/*3*/

select * from Komercijalist
select * from Racun
select * from Stavka

select distinct k.Ime, k.Prezime,(select r.DatumIzdavanja from racun as r where r.KomercijalistID = k.IDKomercijalist), from Komercijalist as k