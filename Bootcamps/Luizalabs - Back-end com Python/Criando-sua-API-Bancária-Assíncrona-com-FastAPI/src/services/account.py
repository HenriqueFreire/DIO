from databases.interfaces import Record

from src.database import database
from src.models.account import accounts
from src.schemas.account import AccountIn


class AccountService:
    async def read_all(self, limit: int, last_id: int = 0) -> list[Record]:
        query = accounts.select().where(accounts.c.id > last_id).limit(limit)
        return await database.fetch_all(query)

    async def create(self, account: AccountIn) -> Record:
        command = accounts.insert().values(user_id=account.user_id, balance=account.balance)
        account_id = await database.execute(command)

        query = accounts.select().where(accounts.c.id == account_id)
        return await database.fetch_one(query)
