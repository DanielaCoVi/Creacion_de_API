from fastapi import FastAPI
from route.router import user


app = FastAPI(title="PI06 -  Data Engineering - Berenice Contreras")


app.include_router(user)


