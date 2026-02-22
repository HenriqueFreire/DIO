import express from 'express';
import cors from 'cors';
import routes from './routes/routes';
import dotenv from 'dotenv';

dotenv.config();

const app: express.Application = express();

app.use(express.json())
app.use(cors())
app.use(routes)

export default app;
