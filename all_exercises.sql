/*
This file contains all the SQLite exercises in one file.

CHANGES TO BE MADE
--1.5 (Order by?)
--2.2 (Order by?)
--2.3 (Order by?)
--2.4 (Order by?)
--2.8 (Order by?)

--3.7 (Duplicates)
--3.8 (Duplicates)
--3.9 (Duplicates)
--3.11 (Order by?)
--3.13 (Order by?)
--3.14 (Order by?, Duplicates)
--3.16 (Order, Duplicates)
--3.17 (Duplicates)

--4.3 (Order by?)
--4.4 (Order by?)
--4.6 (Order by?)

--6.5 (Order by?)

--8.8 (Order by?)

--9.1 (Order by?)

--------------------
Different topics: 13

1 SELECT 6
2 WHERE 9
3 JOIN, JOIN LEFT 17
4 AND OR NOT LIKE 7
5 DISTINCT 4
6 NOT NULL 5
7 ORDER BY 4
8 MIN MAX SUM AVG COUNT 11
9 UNION, INTERSECT, EXCEPT, IN 6
10 GROUP BY 4
11 HAVING 3
12 CREATE TABLE 9
13 SUBQUERIES: WHERE->SELECT, EXISTS, NOT EXISTS, IN, NOT IN 7

Total exercises:
6+9+17+7+4+5+4+11+6+4+3+9+7
=92
*/

--1. SELECT (6 exercises)

--1.1
/*
Create a query to display the entire movie table.
Order by release year.

Hae kaikki tiedot movie-taulusta.
Järjestä elokuvat julkaisuvuoden mukaan.
*/

SELECT * FROM Movie
ORDER BY release_year;

--1.2
/*
Create a query to display the movie title
and release year from the "Movie" table.
Order by the title and release year.

Hae elokuvien nimet ja julkaisuvuodet Movie-taulusta.
Järjestä nimen ja julkaisuvuoden mukaan.
*/

SELECT title, release_year
FROM Movie
ORDER BY title, release_year;

--1.3
/*
Create a query to display the titles,
genres and box office results for all of the movies
with the "action" genre. Order by box office,
the largest one on top.

Hae elokuvan nimi, genre ja tuotto kaikille
elokuville joiden genre on “action”.
Järjestä tuoton mukaan, suurin ensimmäiseksi.
*/
SELECT title, genre, box_office
FROM Movie
WHERE genre='action'
ORDER BY box_office DESC;

--1.4
/*
Create queries to output all the data
from Movie table and Actor table.
Order movies by genre and box office
and actors by the date of birth with the oldest first.

Hae kaikki tiedot tauluista elokuvat ja näyttelijät.
Järjestä elokuvat genren ja tuoton mukaan ja
näyttelijät syntymäpäivän mukaan, vanhin ensimmäiseksi.
*/
SELECT * FROM Movie
ORDER BY genre, box_office;
SELECT * FROM Actor
ORDER BY birth_date;

--1.5 (Order by?)
/*
Query every movie's title, comment and commentor.

Hae jokaisen elokuvan nimi, kommentti ja arvostelija.
*/
SELECT title, comment, reviewer
FROM Movie
JOIN Reception ON Movie.movie_id = Reception.movie_id;

--1.6
/*
Query studio name, studio headquarters and founding year for studios
that were founded after yera 1980. Rename columns as "Studio", "Päämaja"
and "Perustamisvuosi". Order by studio name in alphabetical order.

Hae taulusta studio studion nimi,
studion päämaja, ja perustamisvuosi
niille studioille jotka on perustettu vuoden 1980 jälkeen.
Nimeä kolumnit nimillä “Studio”, “Päämaja” ja “Perustamisvuosi”.
Järjestä aakkosjärjestyksessä studion nimen perusteella.
*/
SELECT studio_name AS "Studio",
headquarter AS "Päämaja",
founded_year AS "Perustamisvuosi"
FROM Studio
WHERE founded_year > 1980
ORDER BY studio_name ASC;

--2 WHERE (9 exercises)

--2.1
/*
Query studios that were founded before year 1990 and
that have revenue less than one billion.
Order by revenue, the largest first on top.

Etsi studio taulusta studiot,
jotka ovat perustettu ennen 1990
ja heidän tuottonsa on ollut alle miljardi.
Järjestä ne tuoton mukaan suurimasta pienimpään.
*/
SELECT * FROM Studio
WHERE founded_year >1990
AND revenue < 10000000000
ORDER BY revenue DESC;

--2.2 (Order by?)
/*
Query from Actor table every actor
taller than 180cm.

Hae Actor taulusta kaikki
yli 180 cm näyttelijät.
*/
SELECT * FROM Actor
WHERE "height (cm)" >= 180;

--2.3 (Order by?)
/*
Query awards received by the movie "Morbius".
Query only the names of the awards.

Hae elokuvan "Morbius" saamat palkinnot.
Tulosta vain palkintojen nimet.
*/

SELECT award_name
FROM Award
WHERE movie_id = 6;

--2.4 (Order by?)
/*
Query all the names of the directors'
who are not from the United States.
Query only the names.

Hae kaikki ohjaajien nimet,
jotka eivät ole Yhdysvalloista.
Tulosta vain nimi.
*/
SELECT name
FROM Director
WHERE nationality_id != 1;

--2.5
/*
Query all data for Julia Roberts.

Hae Julia Robertsin kaikki tiedot.
*/
SELECT *
FROM Actor
WHERE name = 'Julia Roberts';

--2.6
/*
Query every studio that
was founded before year 1980.
Order by the oldest first.

Hae kaikki studiot jotka on perustettu
ennen vuotta 1980.
Järjestä vanhimmasta uusimpaan.
*/
SELECT *
FROM Studio
WHERE founded_year < 1980
ORDER BY founded_year ASC;

--2.7
/*
Query every romantic movie.
Order by box office, the largest first on top.

Etsi kaikki romanttiset elokuvat.
Järjestä tuoton mukaan suurimmasta pienimpään.
*/
SELECT *
FROM Movie
WHERE genre = 'romantic'
ORDER BY box_office DESC;

--2.8 (Order by?)
/*
Query every movie that has won the Jussi-award.
Query only the name and the received award.
(Note! In this exercise you must use JOIN ON)

Hae elokuvat jotka ovat voittaneet
Jussi-palkinnon. Tulosta vain elokuvan nimi
ja voitettu palkinto.
(Huom! Tehtävässä tarvii käyttää JOIN ON
lauseketta)
*/
SELECT award_name, title
from Award
JOIN Movie on Award.movie_id = Movie.movie_id
WHERE award_name LIKE '%jussi%';

--2.9 (Subquery)
/*
Query all movies that have not won any awards.
Show only the title of the movie.
Order by title in alphabetical order.

Hae kaikki elokuvat, jotka eivät ole voittaneet palkintoja.
Näytä vain elokuvien nimet.
Järjestä aakkosjärjestykseen elokuvan nimen perusteella.
*/
SELECT title
FROM Movie
WHERE NOT EXISTS (
    SELECT movie_id
    FROM Award
    WHERE Award.movie_id = Movie.movie_id
)
ORDER BY title ASC;

--3 JOIN, LEFT JOIN (17 exercises)

--3.1
/*
Query every movie’s id, title and the name of the studio
that made the movie. Use INNER JOIN.
Order by studio name in alphabetical order.

Hae jokaisen elokuvan id, nimi sekä elokuvan tehneen studion nimi.
Käytä INNER JOINia.
Järjestä studion nimen mukaan aakkosjärjestykseen.
*/

SELECT Movie.movie_id, Movie.title, Studio.studio_name
FROM Movie
INNER JOIN Studio ON Movie.studio_id = Studio.studio_id
ORDER BY studio_name;

--3.2
/*
Query every actor’s name and nationality
who are from the United States.
Use INNER JOIN. Order by the actor’s name
in reversed alphabetical order.

Hae jokaisen yhdysvaltalaisnäyttelijän nimi
ja kansalaisuus. Käytä INNER JOINia.
Järjestä nimen perusteella käänteiseen
aakkosjärjestykseen.
*/
SELECT name, nationality
FROM Actor
INNER JOIN Nationality
ON Actor.nationality_id = Nationality.nationality_id
WHERE nationality = 'United States'
ORDER BY name DESC;

--3.3
/*
Query the name of the movie “Kummeli Kultakuume”,
its studio and the founding year of the studio.
Use INNER JOIN.

Hae Kummeli Kultakuumeen nimi,
studion nimi ja studion perustamisvuosi.
Käytä INNER JOINia.
*/

SELECT title, studio_name, founded_year
FROM Movie
INNER JOIN Studio ON Movie.studio_id = Studio.studio_id
WHERE title='Kummeli Kultakuume';

--3.4
/*
Query the id’s, names and award names of the movies
“The Room”, “Morbius” and “Nacho Libre”.
Use LEFT JOIN.
Order by award name.

Hae elokuvien “The Room”, “Morbius” ja “Nacho Libre”
id:t, nimet ja saatujen palkintojen nimet.
Käytä LEFT JOINia.
Järjestä palkinnon nimen mukaan.
*/
SELECT Movie.movie_id, Movie.title, Award.award_name
FROM Movie LEFT JOIN Award
ON Movie.movie_id = Award.movie_id
WHERE title='The Room'
OR title='Morbius'
OR title='Nacho Libre'
ORDER BY award_name;

--3.5
/*
Query the titles, box office and
the corresponding studio names and
their revenue of the movies that have made
less than 100 million in box office.
Use LEFT JOIN.
Order by studio name and box office.

Hae alle 100 miljoonaa myyneiden elokuvien nimet,
lipputuotot, studioiden nimet ja tuotot.
Käytä LEFT JOINia.
Järjestä studion nimen ja lipputulojen mukaan.
*/
SELECT title, box_office, studio_name, revenue
FROM Movie
LEFT JOIN Studio ON Movie.studio_id = Studio.studio_id
WHERE box_office < 100000000
ORDER BY studio_name, box_office;

--3.6
/*
Query actors’ names and nationalities
with actors who are not from
the United States.
Order by actor name. Use JOIN ON.

Hae näyttelijöiden nimet ja kansallisuudet
niiltä näyttelijöiltä,
jotka eivät ole yhdysvaltalaisia.
Järjestä näyttelijän nimen mukaan.
*/

SELECT name, nationality
FROM Actor
JOIN Nationality
ON Actor.nationality_id = Nationality.nationality_id
WHERE Actor.nationality_id != 1
ORDER BY name;

--3.7 (Duplicates)
/*
Query each actor for each movie.
Show the title of the movie and actor's name.
Order by title in alphabetical order.
Use JOIN ON.

Etsi kuka näyttelijä näyttelee missäkin elokuvassa.
Tulosta elokuva ja näyttelijä.
Järjestä elokuvan mukaan aakkosjärjestyksessä.
Käytä JOIN ON.
*/
SELECT Movie.title,
Actor.name
FROM Movie
JOIN movie_actor ON Movie.movie_id = movie_actor.movie_id
JOIN Actor ON movie_actor.actor_id = Actor.actor_id
ORDER BY title ASC;

--3.8 (Duplicates)
/*
Query movie title, actor's name and actor's nationality for each movie.
Order by title in alphabetical order.
Use JOIN ON.

Etsi kuka näyttelijä näyttelee missäkin elokuvassa
sekä minkä maalainen näyttelijä on.
Tulosta elokuva, näyttelijä ja kansalaisuus.
Järjestä elokuvan mukaan aakkosjärjestyksessä.
Käytä JOIN ON.
*/
SELECT Movie.title, Actor.name, Nationality.nationality
FROM Movie
JOIN movie_actor ON Movie.movie_id = movie_actor.movie_id
JOIN Actor ON movie_actor.actor_id = Actor.actor_id
JOIN Nationality ON Actor.nationality_id = Nationality.nationality_id
ORDER BY title ASC;

--3.9 (Duplicates)
/*
Query actor's name, nationality and the movies they are in
for every Finnish actor.
Use JOIN ON.

Tulosta kaikki suomalaiset näyttelijät,
missä elokuvissa he näyttelevät sekä maan nimi.
Käytä JOIN ON.
*/
SELECT Movie.title, Actor.name, Nationality.nationality
FROM Movie
JOIN movie_actor ON Movie.movie_id = movie_actor.movie_id
JOIN Actor ON movie_actor.actor_id = Actor.actor_id
JOIN Nationality ON Actor.nationality_id = Nationality.nationality_id
WHERE Nationality.nationality = 'Finland'
ORDER BY title ASC;

--3.10
/*
Query the movie id, title and the director of the movie Titanic.
Use two INNER JOINs.

Hae elokuvan Titanic id, nimi ja ohjaaja.
Käytä kahta INNER JOINia.
*/
SELECT Movie.movie_id, Movie.title, Director.name
FROM Movie
INNER JOIN movie_director ON Movie.movie_id = movie_director.movie_id
INNER JOIN Director ON Director.director_id = movie_director.director_id
WHERE Movie.movie_id = 3;

--3.11 (Order by?)
/*
Query all movies produced by Warner Bros.
Show studio name and title of the movie.
Use JOIN ON.

Etsi kaikki elokuvat jotka Warner Bros on tuottanut.
Näytä studion nimi ja elokuvan nimi.
Käytä JOIN ON
*/
SELECT studio_name, title
FROM Movie
JOIN Studio ON Movie.studio_id = Studio.studio_id
WHERE Studio.studio_name= 'Warner Bros.';

--3.12
/*
Query every movies' reviewer and movie title.
Order by reviewer in alphabetical order.
Use JOIN ON.

Hae kunkin elokuvan arvostelija.
Tulosta elokuvan nimi ja arvostelija.
Järjestä arvostelijan mukaan aakkosjärjestyksessä.
Käytä JOIN ON.
*/
SELECT reviewer, title
FROM Reception
JOIN Movie ON Movie.movie_id = Reception.movie_id
ORDER BY reviewer ASC;

--3.13 (Order by?)
/*
Query every movie's title, release year,
names of the reviewers, ratings and reviewer's comments.
Use LEFT JOIN.

Hae kaikkien elokuvien nimet, julkaisuvuodet,
arvostelioiden nimet, arvostelut sekä kommentit.
(Käytä LEFT JOIN)
*/
SELECT
Movie.title,
Movie.release_year,
Reception.reviewer,
Reception.rating_out_5,
Reception.comment
FROM Movie
LEFT JOIN Reception ON
Movie.movie_id = Reception.movie_id;

--3.14 (Order by?, Duplicates)
/*
Query the titles, genres and actor's name for the movies where Leonardo Dicaprio
is acting.
Use JOIN ON.

Tulosta Leonardo Dicaprion näyttelevät
elokuvat ja niiden genret sekä näyttelijän nimi.
Käytä JOIN ON.
*/
SELECT Movie.title,
Movie.genre,
Actor.name
FROM Movie
JOIN movie_actor ON Movie.movie_id = movie_actor.movie_id
JOIN Actor ON movie_actor.actor_id = Actor.actor_id
WHERE Actor.name = 'Leonardo Dicaprio';

--3.15
/*
Query the title, actor’s name and actor’s net worth
for the movies ”Cast Away”, ”Kummeli Kultakuume” and ”Titanic”.
Order by title.

Hae elokuvien ”Cast Away”, ”Kummeli Kultakuume” ja ”Titanic” nimet,
niiden näyttelijöiden nimet sekä näyttelijöiden nettoarvo.
Järjestä elokuvan nimen mukaan.
*/
SELECT DISTINCT title, actor.name, "net_worth (M€)"
FROM Movie
INNER JOIN Movie_actor ON movie.movie_id = Movie_actor.movie_id
INNER JOIN actor ON actor.actor_id = Movie_actor.actor_id
WHERE movie.movie_id=3 OR movie.movie_id=15 OR movie.movie_id=20
ORDER BY title;

--3.16 (Order, Duplicates)
/*
Query every British actor's name, their movies titles and
their nationality.

Hae kaikki englantilaiset näyttelijät.
Tulosta heidän nimi, näytelty elokuva sekä kansalaisuus.
*/
SELECT Movie.title,
Actor.name,
Nationality.nationality
FROM Movie
JOIN movie_actor ON Movie.movie_id = movie_actor.movie_id
JOIN Actor ON movie_actor.actor_id = Actor.actor_id
JOIN Nationality ON Actor.nationality_id = Nationality.nationality_id
WHERE Nationality.nationality_id = 2;

--3.17 (Duplicates)
/*
Query data from 4 different tables:
query movie title, actor's name, actor's antionality,
studio name and studio's headquarters.
Rename the columns in orderly manner.

Hae neljästä eri taulusta tietoa.
Hae elokuva, näyttelijä, näyttelijän kansalaisuus,
Studio ja studion päämaja.
Nimeä kolumnit järkevästi ja selvästi.
*/

SELECT Movie.title AS "Movie",
Actor.name AS "Actor", Nationality.nationality AS "Actor's nationality",
Studio.studio_name AS "Studio", Studio.headquarter AS "Studios headquarter"
FROM Movie
JOIN movie_actor ON Movie.movie_id = movie_actor.movie_id
JOIN Actor ON movie_actor.actor_id = Actor.actor_id
JOIN Studio ON Studio.studio_id = Movie.studio_id
JOIN Nationality ON Nationality.nationality_id = Actor.nationality_id
ORDER BY Movie ASC;

--4 AND, OR, NOT, LIKE (7 exercises)

--4.1
/*
Query the movie title and box office for movies that have their
box office revenue between 100000 and 100 million.
Order by box office, largest first.

Tulosta niiden elokuvien nimi ja tuotto
joiden tuotto oli sadantuhannen ja sadanmiljoonan välissä.
Järjestä elokuvan tuoton mukaan, suurin ensimmäiseksi.
*/
SELECT title, box_office
FROM Movie
WHERE box_office > 100000
AND box_office < 100000000
ORDER BY box_office DESC;

--4.2 (Instructions)
/*
Query movies that have rating between 3 and 5.
Show reviewer, rating, movie id and movie title.
Order by rating in ascending order.

Hae elokuvat, joiden arvosana on 3 ja 5 välissä.
Tulosta arvostelijan nimi, arvosana, elokuvan id ja elokuvan nimi.
Järjestä arvostelun mukaan matalasta korkeaan.
*/

SELECT reviewer, rating_out_5, r.movie_id, title
FROM Reception r
LEFT JOIN Movie m ON r.movie_id = m.movie_id
WHERE rating_out_5 > 3 AND rating_out_5 < 5
ORDER BY rating_out_5 ASC;

--4.3 (Order by?)
/*
Query movie title and id for all movies that
don't have a title beginning with 'The'.

Hae kaikkien elokuvien nimi,
jotka eivät ole 'The' alkusia.
Tulosta näiden elokuvien nimi ja id.
*/
SELECT movie_id, title
FROM Movie
WHERE title NOT LIKE "The%";

--4.4 (Order by?)
/*
Query movie title and id for all movies that
have a title beginning with 'The'.

Hae kaikkien elokuvien nimi ja movie_id,
joiden nimi alkaa ”The” sanalla.
*/

SELECT movie_id, title
FROM Movie
WHERE title LIKE "The%";

--4.5
/*
Query every actor's name, date of birth
and height for actors born after 1970 and
who are over 170cm tall.
Order by height, shortest to tallest.

Hae kaikkien näyttelijöiden nimi,
syntymäpäivä ja pituus, jotka ovat
syntyneet vuoden 1970 jälkeen ja ovat
yli 170cm pitkiä.
Järjestä lyhimmästä pisimpään.
*/

SELECT name, birth_date, "height (cm)"
FROM Actor
WHERE birth_date > '1970-01-01'
AND "height (cm)" > 170
ORDER BY "height (cm)" ASC;

--4.6 (Order by?)
/*
Query every nationality
that has no letter 'n' in it.

Hae kaikki kansalaisuudet
joiden nimessä ei ole n-kirjainta.
*/

SELECT nationality
FROM Nationality
WHERE nationality NOT LIKE '%n%'

--4.7
/*
Query the count of movies that have the letter 'i'
in their title.

Laske yhteen kaikki elokuvat, joiden nimessä on i
*/
SELECT COUNT(title)
FROM Movie
WHERE title LIKE "%i%";

--5 DISTINCT (4 exercises)

--5.1
/*
Create a query to display all of the unique
genres that exist in the 'Movie' table.
Order by genre in alphabetical order.

Näytä elokuvat taulusta kaikki erilliset genret
käytä DISTINCT -kyselyä.
Järjestä aakkosjärjestyksessä.
*/

SELECT DISTINCT genre
FROM Movie
ORDER BY genre ASC;

--5.2
/*
Create a query that retrieves a list of unique genres
from the movie table,
along with the count of movies for each genre.
Name the new column as 'movie_count'.
Order the results by descending movie count for each genre.

Luo kysely, joka hakee elokuvataulusta kaikki erilliset genret,
yhdessä kunkin genren elokuvien lukumäärän kanssa.
Nimeä uusi sarake 'movie_count'.
Järjestä tulokset genren osalta laskevassa järjestyksessä
(mitä genreä on eniten on listan yläpäässä)
*/

SELECT DISTINCT genre , COUNT(*) AS movie_count
FROM Movie
GROUP BY genre
ORDER BY movie_count DESC;

--5.3
/*
Create a query to display all of the unique
awards that containing the word "Movie".
Order the list alphabetically.

Luo kysely joka hakee kaikki erilliset
palkinnot joiden nimessä on sana ‘movie’.
Järjestä aakkosjärjestyksessä.
*/

SELECT DISTINCT award_name
FROM Award
WHERE award_name LIKE '%Movie%'
ORDER BY award_name ASC;

--5.4
/*
Query all different heights of actors.
Make sure all heights are distinct with DISTINCT-clause.
Order by height, tallest to shortest.

Hae kaikkien näyttelijöiden eri pituudet,
tulosta pelkkä pituus-sarake.
Varmista että pituudet ovat kaikki erilaisia
(DISTINCT-lauseke).
Järjestä pisimmästä lyhimpään.
*/

SELECT DISTINCT "height (cm)"
FROM Actor
WHERE "height (cm)" IS NOT NULL
ORDER BY "height (cm)" DESC;

--6 NOT NULL (5 exercises)

--6.1
/*
Find directors whose height is listed in the table
(is not null) and output their name and height.
Order from shortest to tallest.

Etsi ohjaajat joiden pituus on listattu
(ei ole NULL) ja tulosta heidän nimet ja pituudet.
Järjestä lyhimmästä pisimpään.
*/

SELECT name, "height (cm)"
FROM Director
WHERE "height (cm)" IS NOT NULL
ORDER BY "height (cm)" ASC;

--6.2
/*
Find all studios with revenue listed (is not null)
and print studios name and revenue.
Order revenue by ascending order.

Hae kaikki studiot joiden tulot on listattu
( ei ole NULL ) ja tulosta niiden nimi ja tulo.
Järjestä tulon mukaan pienimmästä suurimpaan.
*/

SELECT studio_name, revenue
FROM Studio
WHERE revenue IS NOT NULL
ORDER BY revenue ASC;

--6.3
/*
Find actors whose net worth is in the table
(is not null) and output their name, birthday and net worth.
Order net worth by ascending order.

Hae kaikki näyttelijät joiden nettovarallisuus
on listattu (ei ole NULL) ja tulosta heidän
nimi, syntymäpäivä ja nettovarallisuus.
Järjestä nettovarallisuuden mukaan pienimmästä suurimpaan.
*/

SELECT name, birth_date, "net_worth (M€)"
FROM Actor
WHERE "net_worth (M€)" IS NOT NULL
ORDER BY "net_worth (M€)" ASC;

--6.4
/*
Query all movies that were released before year 1999
and have their box office is listed (is not null).
Order by movie title in alphabetical order.

Etsi kaikki elokuvat jotka on julkaistu
ennen vuotta 1999 ja joiden tuotto on listattu (ei ole null).
Järjestä aakkosjärjestyksessä elokuvan nimen mukaan.
*/

SELECT *
FROM Movie
WHERE release_year < 1999
AND box_office IS NOT NULL
ORDER BY title ASC;

--6.5 (Order by?)
/*
Query the name, date of birth, date of death and the age at death
for directors who have died.
Use NOT NULL for defining the date of death.
Rename the column for age at death as "age_at_death".

Hae nimi, syntymäpäivä, kuolinpäivä ja ikä kuollessa ohjaajille.
Käytä NOT NULL määrittäessäsi kuolinpäivää.
Nimeä uusi sarake nimellä “age_at_death”.
*/

SELECT name, birth_date, date_of_death,
(strftime('%Y', date_of_death) - strftime('%Y', birth_date)) -
(strftime('%m-%d', date_of_death) < strftime('%m-%d', birth_date)) AS age_at_death
FROM Director
WHERE date_of_death IS NOT NULL;

--7 ORDER BY (4 exercises)

--7.1
/*
Query the titles of all movies.
Order by title in alphabetical order.

Laita elokuvat aakkosjärjestykseen.
Tulosta vain elokuvien nimi.
*/

SELECT title
FROM Movie
ORDER BY title ASC;

--7.2
/*
Query all info from Actor table.
Order by birth date, youngest to oldest.

Tulosta Actor taulun tiedot,
niin että näyttelijät ovat
järjestyksessä syntymävuoden perustella
nuorimmasta vanhimpaan.
*/

SELECT *
FROM Actor
ORDER BY birth_date DESC;

--7.3
/*
Query all data from Movie table.
Order by box office, largest to smallest.

Tulosta kaikki taulun Movie tiedot niin,
että laita elokuvat on järjestyksessä
suurimmasta tuottajasta pienimpään.
*/

SELECT *
FROM Movie
ORDER BY box_office DESC;

--7.4
/*
Query movie title, genre and box office for all
movies.
Order by box office, smallest to largest.

Hae elokuvataulusta elokuvan nimi, genre ja tuotto.
Järjestä tuoton mukaan pienimmästä suurimpaan.
*/
SELECT title, genre, box_office
FROM Movie
ORDER BY box_office ASC;

--8 MIN, MAX, SUM, AVG, COUNT (11 exercises)

--8.1
/*
Query the title, genre and box office
for the least profitable movie.
Name the column “box_office”.

Hae vähiten tuottaneen elokuvan nimi, genre ja tuotto.
Tuotto sarakkeen nimi tulee olla “box_office”.
*/

SELECT title, genre, MIN(box_office) AS "box_office"
FROM Movie;

--8.2
/*
Query the title and box office of the most profitable movie.
Name the column “Box office”.

Hae tuottoisimman elokuvan nimi ja tuotto
MAX()-haulla, nimeä tuottosarake “Box office”.
*/

SELECT title, MAX(box_office) AS "Box office"
FROM Movie;

--8.3
/*
Query the name and height of the tallest actor.
Name the height column “height”.

Hae pisimmän näyttelijän nimi ja pituus.
Nimeä pituus-sarake nimellä “height”.
*/

SELECT name, MAX("height (cm)") AS height
FROM Actor;

--8.4
/*
Query the sum of the net worth of directors’ James Cameron and Francis Ford Coppola.
Name the sum column “Total net worth”.

Hae James Cameronin ja Francis Ford Coppolan
nettoarvojen summa Director-taulusta.
Nimeä sarake “Total net worth”.
*/

SELECT SUM("net_worth (M€)") AS "Total net worth"
FROM Director
WHERE name='James Cameron' OR name='Francis Ford Coppola';

--8.5
/*
Query the average of all the ratings from the reception table.
Round the result with ROUND() by 2 decimals.
Name the column “rating average”.

Hae kaikkien arvostelujen välinen keskiarvo Reception-taulusta.
Pyöristä tulos 2 desimaalin tarkkuudelle ROUND()-metodilla.
Nimeä sarake “rating average”.
*/

SELECT ROUND(AVG(rating_out_5), 2) AS "rating average"
FROM Reception;

--8.6
/*
Query the total number of studios.
Use COUNT().
Name the column “Studio count”.

Hae studioiden lukumäärä.
Käytä COUNT()-metodia.
Nimeä sarake “Studio count”.
*/

SELECT COUNT(studio_id) AS "Studio count"
FROM Studio;

--8.7
/*
Count how many actors are born in 1960's.
Name the column " Born in the 60's"

Hae 1960-luvulla syntyneiden näyttelijöiden lukumäärä (COUNT()).
Nimeä sarake nimellä “Born in the 60’s”.
*/

SELECT COUNT(*) AS "Born in the 60's"
FROM Actor
WHERE birth_date >= '1960-01-01'
AND birth_date < '1969-12-31';

--8.8 (Order by?)
/*
Find shortest and tallest director.
Output their name and height.

Hae lyhin ja pisin ohjaaja.
Tulosta heidän nimet ja pituudet.
*/

SELECT name, "height (cm)"
FROM Director
WHERE "height (cm)" = (
SELECT MIN("height (cm)")
FROM Director
)
OR "height (cm)" = (
SELECT MAX("height (cm)")
FROM Director
);

-- SOME EXTRAS

--8.9
/*
DIFFICULT/VAIKEA
Query the count of ratings that are higher than the average of all ratings.
What is the total number of these ratings?
Name the column as "lukumäärä".

Hae kaikkien yli keskiarvon saaneiden arvostelujen määrä keskenään.
Montako näitä arvosteluja on yhteensä.
Tulosta vastaus kolumniin nimellä “lukumäärä”.
*/
SELECT COUNT(*) AS "lukumäärä"
FROM Reception
WHERE rating_out_5 > (
SELECT ROUND(AVG(rating_out_5), 2) AS "rating average"
FROM Reception
);

--8.10
/*
Query the counts of actors and directors into two columns.
Name the columns as "näyttelijät" and "ohjaajat".

Hae kahteen vierekkäiseen kolumniin näyttelijöiden
ja ohjaajien lukumäärät.
Nimeä kolumnit nimellä “näyttelijät” ja “ohjaajat”.
*/
SELECT
(SELECT count(*) FROM Actor) AS "näyttelijät",
(SELECT count(*) FROM Director) AS "ohjaajat";

--8.11
/*
Query the counts of actors, directors, movies, studios and nationalities.
Name the columns.

Hae kolumneihin näyttelijöiden, ohjaajien, elokuvien,
studoiden ja kansalaisuuksien lukumäärät.
Nimeä kolumnit suomeksi.
*/

SELECT
(SELECT count(*) FROM Actor) AS "näyttelijät",
(SELECT count(*) FROM Director) AS "ohjaajat",
(SELECT count(*) FROM Studio) AS "studiot",
(SELECT count(*) FROM Movie) AS "elokuvat",
(SELECT count(*) FROM Nationality) AS "kansalaisuudet"
;

--9 UNION, INTERSECT, EXCEPT, IN (6 exercises)

--9.1 (Order by?)
/*
Find all actors and directors
who are 183 cm tall.
Print their name and height.

Hae kaikki näyttelijät ja ohjaajat jotka ovat 183 cm pitkiä.
Tulosta heidän nimet ja pituudet.
*/
SELECT name, "height (cm)"
FROM Actor
WHERE "height (cm)" = 183
UNION
SELECT name,
"height (cm)"
FROM Director
WHERE "height (cm)" = 183;

--9.2
/*
List all movies that are in superhero,
comedy or thriller genre.
Print their name, genre and release year.
Order them from newest to oldest.

Hae kaikki elokuvat joiden genre on superhero,
komedia tai thriller.
Tulosta näiden elokuvien nimi, genre ja julkaisuvuosi.
Järjestä uusimmasta vanhimpaan.
*/

SELECT title, genre, release_year
FROM Movie
WHERE genre IN ('thriller', 'comedy', 'superhero')
ORDER BY release_year DESC;

--9.3
/*
Write query that lists name of all the directors
that are not actors in their movie.
Order by counter-aplhabetical order.

Kirjoita kysely, joka listaa kaikkien ohjaajien nimet,
jotka eivät ole näyttelijöitä elokuvissaan.
Järjestä käänteisessä aakkosjärjestyksessä.
*/

SELECT name
FROM Director
EXCEPT
SELECT name
FROM Actor
ORDER BY name DESC;

--9.4
/*
Find the common actors who have also directed a movie.
Print only their name(s).

Hae kaikki ohjaajat jotka sekä näyttelevät
että ohjaavat elokuvan.
Tulosta vain heidän nimi/nimet.
*/

SELECT name
FROM Actor
INTERSECT
SELECT name
FROM Director;

--9.5
/*
Retrieve all movies that were released in the years 2020, 2021, and 2022.
Find all the data about the movie(s).

Hae kaikki elokuvat jotka on tehty vuonna 2020, 2021 tai 2022.
Hae elokuvan/elokuvien kaikki tiedot.
*/

SELECT * FROM Movie
WHERE release_year IN (2020, 2021, 2022);

--9.6
/*
Retrieve the name of the movie, genre, release year
and studio name of the movie(s) in the last excersise.

Hae edellisessä tehtävässä haetun elokuvan nimi, genre,
julkaisuvuosi sekä studion nimi.
*/

SELECT title, genre, release_year, studio_name
FROM Movie
JOIN Studio ON Movie.studio_id = Studio.studio_id
WHERE release_year IN (2020, 2021, 2022);

--10 GROUP BY (4 exercises)

--10.1
/*
Query the count for each movie genre.
Name the column of count as "Genrien_maara".
Order by count of genres, ascending order.

Laske kaikkien elokuvien määrä eri genreissä eli
kuinka monta elokuvaa kuuluu kuhunkin genreen.
Nimeä uusi kolumni nimellä ”Genrien_maara” ja
järjestä sen kolumnin mukaan nousevassa järjestyksessä.
*/

SELECT genre, COUNT(*) AS Genrien_maara
FROM Movie
GROUP BY genre
ORDER BY Genrien_maara;

--10.2
/*
Query the count of movies by every studio, studio name and studio id.
Name the column for movie count as "elokuvien_maara".
Order by movie count in descending order.

Etsi elokuvien määrä jokaiselta studiolta ja
tulosta studion nimi ja id.
Nimeä uusi kolumni nimellä ”elokuvien_maara” ja
järjestä sen mukaan laskevassa järjestyksessä.
*/

SELECT COUNT(*) AS elokuvien_maara, s.studio_name, m.studio_id
FROM Movie m
LEFT JOIN Studio s ON m.studio_id = s.studio_id
GROUP BY m.studio_id, s.studio_name
ORDER BY elokuvien_maara DESC;

--10.3
/*
Query the count of actors from each country and respective countries.
Name the column as "nayttelijoiden_maara".
Order by count column in descending order.

Etsi näyttelijöiden määrät eri maista ja
näytä niiden maiden nimet.
Nimeä uusi kolumni nimellä ”nayttelijoiden_maara”
ja järjestä sen mukaan laskevalla järjestyksellä.
*/

SELECT COUNT(*) AS nayttelijoiden_maara, n.nationality
FROM Actor a
LEFT JOIN Nationality n
ON a.nationality_id = n.nationality_id
GROUP BY a.nationality_id, n.nationality_id
ORDER BY nayttelijoiden_maara DESC;

--10.4
/*
Query the count of Oscar awards for each movie that has won
any of the Academy awards.
Show the number of received awards and the title of the movie.
Name the column of award count.
Order by the count of awards.

Löydä kaikki elokuvat, jotka ovat saaneet Oscar palkinnon
(Huomioi Oscar palkinnon nimi ei ole Oscar!)
ja laske kuinka monta jokainen elokuva on saanut.
Tässä tulee tulostaa Oscarien määrä ja elokuvien nimi.
Nimeä palkintojen määrän sarake.
Järjestä Oscar palkintojen määrän mukaan.
*/

SELECT COUNT (Award.award_id) AS oscar_maara, Movie.title
FROM Award
INNER JOIN
Movie ON Award.movie_id = Movie.movie_id
WHERE Award.award_name LIKE '%Academy Awards%'
GROUP BY Movie.movie_id
ORDER BY oscar_maara ASC;

--11 HAVING (3 exercises)

--11.1
/*
Query the names and the total number of films of the
studios that have more than 2 movies on the list.
Name the count column as “total movies”.
Group by the studio id and set the minimal limit by HAVING.
Order by the movie total, the largest first.

Hae studioiden nimet ja studioiden elokuvien
kokonaislukumäärä niistä studioista,
joilla on enemmän kuin 2 elokuvaa listassa.
Nimeä lukumääräsarake “total movies”.
Ryhmitä tulokset GROUP BY – metodilla studion id:n mukaan
ja tee lukumäärärajaus HAVING – metodilla.
Järjestä elokuvien lukumäärän mukaan, suurin ensimmäisenä.
*/

SELECT studio.studio_name, COUNT(movie.studio_id) AS "total movies"
FROM movie
INNER JOIN studio ON movie.studio_id = studio.studio_id
GROUP BY movie.studio_id
HAVING COUNT(movie.studio_id) > 2
ORDER BY "total movies" DESC;

--11.2
/*
Query studio headquarters and the total number of them in the cities
that have more than 1 headquarters.
Name the count column as “studios_in_city”.
Group by the headquarter and limit by HAVING
using the count of headquarters.
Order by the headquarter.

Hae studioiden päämajan sijainnit ja
studioiden lukumäärä kaupungeissa,
joissa on enemmän kuin yksi päämaja.
Nimeä lukumääräsarake “studios_in_city”.
Ryhmitä GROUP BY:lla päämajan mukaan ja rajaa
HAVING – metodilla käyttäen päämajojen lukumäärää.
Järjestä päämajan mukaan.
*/

SELECT headquarter, COUNT(headquarter) AS "studios_in_city"
FROM studio
GROUP BY headquarter
HAVING COUNT(headquarter) > 1
ORDER BY headquarter;

--11.3
/*
Query studio id’s, names and the total of their movies’
box office for the studios that have their
box office sum total more than 400 million.
Group by studio id.
Limit with HAVING by using the total as the limit.

Hae studioiden id:t, nimet ja elokuvien
lipputulojen summat niiltä studioilta,
joiden summat ylittävät 400 miljoonaa.
Ryhmitä GROUP BY:lla studion id:n mukaan.
Käytä HAVING määrittämään summan vähimmäisrajaa.
Järjestä studion nimen mukaan.
*/

SELECT studio.studio_id, studio.studio_name,
SUM(movie.box_office) AS "total"
FROM studio
INNER JOIN movie ON movie.studio_id = studio.studio_id
GROUP BY studio.studio_id
HAVING total > 400000000
ORDER BY studio_name;

--12 CREATE TABLE (9 exercises)

--12.1
/*
Create a table for a movie course. Table has columns for
student name, age and thei favourite movie.
Each student has to have a generated id.
Remember to use English for naming columns.
Name the table "Course".

Rakenna Elokuva kurssia varten taulukko,
jossa on määritetty opiskelijoiden nimi, ikä ja lempielokuva.
Jokaiselle opiskelijalle tulee generoimaan oma id.
Muista, että kurssi on englanniksi,
joten taulutkin tulevat olla.
Taulukon nimi tulee olemaan Course.
*/

CREATE TABLE Course(
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT,
age INTEGER,
favourite_movie TEXT
);

--12.2
/*
Insert the following student data onto table.

Aseta opiskelijoiden data taulukkoon.

DATA:
Matias Halonen, 19, Muumipeikko ja pyrstötähti
Sini Lahtinen, 18, Saw X
Hans Müller, 23, All quiet on the western front
Chen Yi, 20, Pretty woman
*/

INSERT INTO Course (name, age, favourite_movie) VALUES
('Matias Halonen', 19, 'Muumipeikko ja pyrstötähti'),
('Sini Lahtinen', 18, 'Saw X'),
('Hans Müller', 23, 'All quite on the western front'),
('Chen Yi', 20, 'Pretty woman');

--12.3
/*
Sini Lahtinen has informed that her age and favourite movie
are wrong in the table. The correct values are 22 and 'Twilight'.
Update these into the table.

Sini Lahtinen ilmoitti, että hänen ikänsä oli väärin
ja samoin lempielokuva.
Oikeat tiedot ovat 22 ja Twilight.
Päivitä nämä tiedot.
*/

UPDATE Course SET favourite_movie = 'Twilight' WHERE id = '2';
UPDATE Course SET age = 22 WHERE id = '2';

--12.4
/*
Hans informed that he will drop the course.
Remove him from the table.

Hans ilmoittikin, jättävänsä kurssin tekemättä.
Poista hänet taulukosta.
*/

DELETE FROM Course WHERE id = 3;

--12.5
/*
Teacher told that there are two new students joining.
Add them into the table.

Opettaja ilmoittaa, että saatiin kurssille uusia oppilaita,
jotka tulee lisätä taulukkoon.

DATA:
Joel Korhonen, 23,  The Exorcist
Fabian Olsen, 20, The Dark knight
*/

INSERT INTO Course (name, age, favourite_movie) VALUES
('Joel Korhonen', 23,  'The Exorcist'),
('Fabian Olsen', 20, 'The Dark knight');

--12.6
/*
Add a new column for the table for
the favourite character of each student.

Lisää taulukkoon uusi sarake,
jossa määrittelet heidän lempi hahmonsa:

DATA:
Matias Halonen – Muumipeikko
Sini Lahtinen – Edward
Chen Yi – Joker
Joel Korhonen – Superman
Fabian Olsen – Batman
*/

ALTER TABLE Course ADD COLUMN favorite_character TEXT;
UPDATE Course
SET favorite_character = 'Muumipeikko' WHERE id = 1;
UPDATE Course
SET favorite_character = 'Edward' WHERE id = 2;
UPDATE Course
SET favorite_character = 'Joker' WHERE id = 4;
UPDATE Course
SET favorite_character = 'Superman' WHERE id = 5;
UPDATE Course
SET favorite_character = 'Batman' WHERE id = 6;

--12.7
/*
Change the id column's name to student_id.

Muuta id sarakkeen nimeksi  student_id.
*/

ALTER TABLE Course
RENAME COLUMN id TO student_id;

--12.8
/*
Teacher wants to give students a grade.
Create a new table with columns for student id and  grades.

Opettaja haluaa antaa opiskelijoille numerot.
Tee uusi taulu, jossa on opiskelijoiden pelkästään id ja numero.

DATA:
Matias Halonen – arvosana: 4
Sini Lahtinen – arvosana: 4
Chen Yi – arvosana: 5
Joel Korhonen – arvosana: 1
Fabian Olsen – arvosana: 2
*/

CREATE TABLE Student(
id INTEGER,
grade INTEGER,
FOREIGN KEY (id) REFERENCES Course(student_id)
);

INSERT INTO Student (id, grade) VALUES
(1,4),
(2,4),
(4,5),
(5,1),
(6,2);

--12.9
/*
The course is over, delete both tables in the database.

Kurssi on ohi niin poista molemmat taulut tietokannasta.
*/

DROP TABLE Student;
DROP TABLE Course;

--13 SUBQUERIES: WHERE->SELECT, EXISTS, NOT EXISTS, IN, NOT IN (7 exercises)

--13.1
/*
Query the name and net worth for the actor
who has the biggest value in euros.
Name the net worth column as “worth”.
Use a subquery in WHERE-statement.

Hae näyttelijän nimi ja ikä siltä näyttelijältä,
jolla on suuri nettoarvo euroissa.
Nimeä arvon sarake “worth”.
Käytä alikyselyä WHERE-lausekkeessa.
*/

SELECT name, "net_worth (M€)" AS worth
FROM actor
WHERE worth = (SELECT MAX("net_worth (M€)") FROM actor)
;

--13.2
/*
Query all the studio id’s and studio names of the studios
that have movies in the list and their headquarters is in Paris.
Use EXISTS in WHERE-statement.
Order by studio id.

Hae kaikki studio id:t ja studioiden nimet niiltä studioilta,
joilla on elokuvia listassa ja joiden päämaja
sijaitsee Pariisissa.
Käytä EXISTS-hakua WHERE-lausekkeessa.
Järjestä studio id:n mukaan.
*/

SELECT studio_id, studio_name
FROM studio
WHERE EXISTS (SELECT * FROM movie WHERE movie.studio_id = studio.studio_id
AND headquarter = 'Paris')
ORDER BY studio_id
;

--13.3
/*
Query the studio id’s, studio names and founding years
for the studios that have movies on the list
and have been founded in 1995 or later.
Use NOT EXISTS in WHERE-statement.
Order by founded year.
NOTE: the point is to eliminate all non-suitable
results with NOT EXISTS,
so it might be wise to use the foundation year in a
“reverse” manner as a limiter.

Hae kaikki studio id:t, studioiden nimet ja perustamisvuodet
niiltä studioilta, joilla on elokuvia listassa ja
jotka on perustettu vuonna 1995 tai sen jälkeen.
Käytä NOT EXISTS WHERE-lausekkeessa.
Järjestä perustamisvuoden mukaan.
HUOM: tarkoitus on eliminoida NOT EXISTS avulla
kaikki ei-täsmäävät rivit, joten perustamisvuotta
voi käyttää “käänteisesti” vertailua varten.
*/

SELECT studio_id, studio_name, founded_year
FROM studio
WHERE NOT EXISTS (SELECT * FROM movie WHERE movie.studio_id = studio.studio_id
AND founded_year < 1995)
ORDER BY founded_year
;

--13.4
/*
Query movie id’s, titles and genres
for the movies that were produced
by the studio “Columbia Pictures”.
Use IN in WHERE-statement.
Order by genre.
You can use studio id for the IN subquery.

Hae elokuvien id:t, nimet ja genret niille elokuville,
jotka on tuottanut “Columbia Pictures”.
Käytä IN kyselyä WHERE-lausekkeessa.
Järjestä genren mukaan.
Voit käyttää studion id:tä IN-alikyselyssä.
*/

SELECT movie_id, title, genre
FROM movie
WHERE studio_id IN (SELECT studio_id FROM studio
WHERE studio_name = 'Columbia Pictures')
ORDER BY genre
;

--13.5
/*
Query actors’ names and nationalities
for actors who are not from the
United States, Poland or France.
Use NOT IN in WHERE-clause.
You can use nationality id’s for the query.
Order by actors’ names.

Hae näyttelijöiden nimet ja kansalaisuudet
niiltä näyttelijöiltä,
jotka eivät ole yhdysvaltalaisia, puolalaisia
tai ranskalaisia.
Käytä NOT IN – ehtoa WHERE-lausekkeessa.
Voit käyttää kansallisuus-id:tä haun ehdossa.
Järjestä näyttelijöiden nimen mukaan.
*/

SELECT name, nationality
FROM actor, nationality
WHERE actor.nationality_id = nationality.nationality_id
AND nationality.nationality_id NOT IN (1, 4, 5)
ORDER BY name;

--13.6
/*
Query movie names and genres that have not been produced
by Warner Bros’, Sony Pictures, Paramount Pictures
or Columbia Pictures.
Use NOT IN with WHERE-clause.
You can use studio ids for query.
Order by title and genre.

Hae elokuvien nimet ja genret, jotka eivät ole Warner Bros'in,
Sony Picturesin, Columbia Picturesin tai Paramount Picturesin tuottamia.
Käytä NOT IN-ehtoa WHERE-lausekkeessa. Voit käyttää pelkkiä studioiden id:tä hakuehdossa.
Järjestä elokuvan nimen ja genren mukaan.
*/

SELECT title, genre
FROM Movie
WHERE studio_id NOT IN (1, 3, 6, 11)
ORDER BY title, genre
;

--13.7
/*
Query the combined average of the movie box office profits
for Sony Pictures and Columbia Pictures.
Use AVG() for the average and SUM() for the subquery.
Name the column “average profit”.
NOTE: Calculate the sums by grouping the movie box office profits
by studio id, then you will have two groups
from which can be used for the average.

Hae Sony Picturesin ja Columbia Picturesin tekemien
elokuvien tuottojen summien keskiarvo.
Käytä AVG() keskiarvoa varten ja SUM() alikyselyä varten.
Nimeä sarake “average profit”.
HUOM: Laske alikyselyssä summat ryhmäyttämällä
elokuvat studio id:n mukaan, siten lopussa on kaksi summien ryhmää,
joista voidaan laskea keskiarvo.
*/

SELECT AVG(movies.profit) AS "average profit"
FROM (SELECT SUM("box_office") AS profit
FROM movie
WHERE studio_id = 11 OR studio_id = 6
GROUP BY studio_id)
AS movies;
