import * as http from 'http';
import { app } from './app';

const server = http.createServer(app);

const port = process.env.PORT || 3333;

server.listen(port, () => {
  console.log(`Servidor iniciado na porta ${port}`);
});
