from fastapi import APIRouter
import mysql.connector as myconn
from mysql.connector import Error
import os

user= APIRouter()


@user.post("/Bienvenid@ a la API stream_plataforms")
async def Saludo():
    return {f"Saludos": "Gracias por curiosear aquí"}

'''
 CONSULTAS
-- 1.Cantidad de veces que aparece una keyword en el título de peliculas/series, por plataforma.
-- get_word_count('netflix', 'love')
-- platform- cantidad
-- netflix- 196
'''


    
@user.post("/api/Consulta1/{plataforma: str}{keyword: str}") 
async def get_word_count(plataforma: str, keyword: str):
                
    co = myconn.connect(host="localhost",
                            database="stream_plataforms",
                            user="root",
                            password="Berenice123#")
    
    try:

        if co.is_connected():                                    
            cursor = co.cursor()

            params = (plataforma, keyword, '', 0)

            data = cursor.callproc('get_word_count', params)
            
           
            return {f'Plataforma: {data[2]} y la cantidad de veces que aparece la palabra keyword es {data[3]}'}

    except Error as ex:
        return "Error durante la conección:", ex
    finally:
        if co.is_connected():
           co.close()


'''
 2.Cantidad de películas por plataforma con un puntaje mayor a XX en determinado año
-- get_score_count('netflix', 85, 2010)
-- Cantidad de películas por plataforma
-- 20
'''

@user.post("/api/Consulta2/{plataforma: str}{score: int}{release_year: int}") 
async def get_score_count(plataforma: str, score: int, release_year: int):

    co = myconn.connect(host="localhost",
                            database="stream_plataforms",
                            user="root",
                            password="Berenice123#")
    
    try:

        if co.is_connected():                                    
            cursor = co.cursor()

            params=(plataforma, score, release_year, 0)

            data = cursor.callproc('get_score_count', params)
     

            return {f'Cantidad de películas por plataforma: {data[3]}'}

    except Error as ex:
        return "Error durante la conección:", ex
    finally:
        if co.is_connected():
           co.close()

''' 
3.La segunda película con mayor score para una plataforma determinada, según el orden alfabético de los títulos.
-- get_second_score('amazon')
-- title - score
-- 15-minute cardio core 8.0 workout (with weights) - 100
'''

@user.post("/api/Consulta3/{plataforma: str}") 
async def get_second_score(plataforma: str):        

    co = myconn.connect(host="localhost",
                            database="stream_plataforms",
                            user="root",
                            password="Berenice123#")
    
    try:

        if co.is_connected():                                    
            cursor = co.cursor()

            params=(plataforma, '', 0)

            data = cursor.callproc('get_second_score', params)
     

            return {f'La segunda película con mayor score: {data[1]}, con la cantidad de: {data[2]}'}

    except Error as ex:
        return "Error durante la conección:", ex
    finally:
        if co.is_connected():
           co.close()

'''
 4.Película que más duró según año, plataforma y tipo de duración
-- get_longest('netflix', 'min', 2016)
-- title - duration - duration_type
-- sairat - 172 - min
'''

@user.post("/api/Consulta4/{plataforma: str}{duration_type: str}{release_year: int}") 
async def get_longest(plataforma: str, duration_type: str, release_year: int):        

    co = myconn.connect(host="localhost",
                            database="stream_plataforms",
                            user="root",
                            password="Berenice123#")
    
    try:

        if co.is_connected():                                    
            cursor = co.cursor()

            params=(plataforma, duration_type, release_year, '', 0, '')

            data = cursor.callproc('get_longest', params)

            return {f'Película que más duro: {data[3]} con: {data[4]} {data[5]}'}

    except Error as ex:
        return "Error durante la conección:", ex
    finally:
        if co.is_connected():
           co.close()


'''
 5.Cantidad de series y películas por rating
-- get_rating_count('18+')
-- rating- cantidad
-- 18+ - 243
'''

@user.post("/api/Consulta5/{clasificación: str}") 
async def get_rating_count(clasificación: str):        

    co = myconn.connect(host="localhost",
                            database="stream_plataforms",
                            user="root",
                            password="Berenice123#")
    
    try:

        if co.is_connected():                                    
            cursor = co.cursor()

            params=(clasificación, '', 0)

            data = cursor.callproc('get_rating_count', params)

            return {f'Esta clasificación: {data[1]} tiene la cantidad de: {data[2]}'}

    except Error as ex:
        return "Error durante la conección:", ex
    finally:
        if co.is_connected():
           co.close()

