/*Realizar una consulta sobre la tabla canciones con la siguiente información:
Solo los 10 primeros caracteres del nombre de la canción en mayúscula.
La duración de la canción expresada en minutos. Ejemplo 5:10
El peso en kbytes en número entero (sin decimales, 1000 bytes = 1 kb)
El precio formateado con 3 decimales, Ej: $100.123
El primer compositor de la canción (notar que si hay más de uno, mostrar separados por coma)*/
use musimundos;
select * from canciones;

select substring(UPPER(nombre),1, 10) as CANCION
,sec_to_time(round(milisegundos/1000,0)) as DURACION
,round(bytes/1000) as KBYTES
,concat('$', format(precio_unitario,3)) as PRECIO
,CASE
	WHEN compositor IS NULL or compositor='' THEN '<sin datos>'
    ELSE SUBSTRING_INDEX(compositor, ',',1)
END as COMPOSITOR
from canciones;
