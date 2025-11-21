import databases
import sqlalchemy as sa
from sqlalchemy.ext.asyncio import create_async_engine

from src.config import settings

database = databases.Database(settings.database_url)
metadata = sa.MetaData()

engine = create_async_engine(settings.database_url)
