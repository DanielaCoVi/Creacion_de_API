DROP DATABASE if exists stream_plataforms;
CREATE DATABASE stream_plataforms;

USE stream_plataforms;

DROP TABLE IF EXISTS global;
CREATE TABLE global (
Show_id  VARCHAR(250) Primary key,
Type  VARCHAR(255),
Title  VARCHAR(255),
Director   VARCHAR(1200),
Cast      VARCHAR(1200),
Country    VARCHAR(255),
Date_added   VARCHAR(255),
Release_year  INTEGER,
Rating    VARCHAR(255),
Duration   TEXT,
Listed_in  VARCHAR(255),
Description VARCHAR(2000),
Score  INTEGER,
Duration_int	INTEGER,
Duration_type	VARCHAR(255)
) ENGINE=InnoDB CHARSET=utf8 COLLATE=utf8_spanish2_ci;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\platforms_final.csv' 
INTO TABLE global
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '\n' 
LINES TERMINATED BY '\r\n' IGNORE 1 LINES;


SET GLOBAL log_bin_trust_function_creators = 1;

SELECT * FROM global;


-- CONSULTAS
-- 1.Cantidad de veces que aparece una keyword en el título de peliculas/series, por plataforma.
-- get_word_count('netflix', 'love')
-- platform- cantidad
-- netflix- 196
DROP PROCEDURE IF EXISTS get_word_count;
DELIMITER //
CREATE PROCEDURE get_word_count(IN plataforma VARCHAR(250), IN keyword VARCHAR(250), OUT  plat VARCHAR(250), OUT cantidad INTEGER)
BEGIN
    SET plat = plataforma;
    SET cantidad = (
        SELECT COUNT(*) 
        FROM global 
        WHERE Show_id LIKE CONCAT(LEFT(plataforma, 1), '%') and Title LIKE CONCAT('%', keyword, '%')
    );
    SELECT @plat, @cantidad;
END//
DELIMITER ;

CALL get_word_count('netflix' ,'love', @plat, @cantidad);
SELECT  @plat, @cantidad;

-- 2.Cantidad de películas por plataforma con un puntaje mayor a XX en determinado año
-- get_score_count('netflix', 85, 2010)
-- Cantidad de películas por plataforma
-- 20
DROP PROCEDURE IF EXISTS get_score_count;
DELIMITER //
CREATE PROCEDURE get_score_count(IN plataforma VARCHAR(250), IN puntaje INTEGER, IN anio INTEGER, OUT resultado INTEGER)
BEGIN
    SET resultado = (
        SELECT COUNT(Title) 
        FROM global 
        WHERE show_id LIKE CONCAT(LEFT(plataforma, 1), '%') AND score > puntaje AND Release_year = anio AND duration_type = 'min'
    );
END//
DELIMITER ;

CALL get_score_count('netflix', 85, 2010, @resultado);
SELECT @resultado;


-- 3.La segunda película con mayor score para una plataforma determinada, según el orden alfabético de los títulos.
-- get_second_score('amazon')
-- title - score
-- 15-minute cardio core 8.0 workout (with weights) - 100

DROP PROCEDURE IF EXISTS get_second_score;
DELIMITER //
CREATE PROCEDURE get_second_score(IN plataforma VARCHAR(250), OUT titulo VARCHAR(250), OUT puntaje INTEGER)
BEGIN
		SELECT Title, Score INTO titulo, puntaje
		FROM global
		WHERE Show_id LIKE CONCAT(LEFT(plataforma, 1), '%')
		ORDER BY Score DESC, Title ASC
		LIMIT 1,1;

END //
DELIMITER ;

CALL get_second_score('amazon',@titulo, @puntaje);
SELECT @titulo, @puntaje;  



-- 4.Película que más duró según año, plataforma y tipo de duración
-- get_longest('netflix', 'min', 2016)
-- title - duration - duration_type
-- sairat - 172 - min

DROP PROCEDURE IF EXISTS get_longest;
DELIMITER //
CREATE PROCEDURE get_longest(IN plataforma VARCHAR(250), IN duration_type VARCHAR(10), IN anio INTEGER, OUT titulo VARCHAR(250), OUT duracion INTEGER, OUT duration_type_out VARCHAR(10))
BEGIN
    SELECT Title, Duration_int, Duration_type INTO titulo, duracion, duration_type_out 
    FROM global
    WHERE Release_year = anio AND Show_id LIKE CONCAT(LEFT(plataforma, 1), '%') AND duration_type = 'min' 
    ORDER BY Duration_int DESC
    LIMIT 1;
END //
DELIMITER ;

CALL get_longest('netflix', 'min', 2016,@titulo, @duracion, @duration_type_out);
SELECT @titulo, @duracion, @duration_type_out; 

-- 5.Cantidad de series y películas por rating
-- get_rating_count('18+')
-- rating- cantidad
-- 18+ - 243

DROP PROCEDURE IF EXISTS get_rating_count;
DELIMITER //
CREATE PROCEDURE get_rating_count(IN tipo VARCHAR(10), OUT categoria VARCHAR(10), OUT cantidad INTEGER)
BEGIN
    SELECT Rating, COUNT(Rating) INTO categoria, cantidad 
    FROM global
    WHERE Rating = tipo;
END //
DELIMITER ;


CALL get_rating_count('18+',@categoria, @cantidad);
SELECT @categoria, @cantidad; 

