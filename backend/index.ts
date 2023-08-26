import express, { Express, Request, Response } from 'express';
import dotenv from 'dotenv';
import {textRouter} from './backend/routes/speech';

dotenv.config();

const app: Express = express();
const port = 8080;

// app.post('/', (req: Request, res: Response) => {
//   res.send('Express + TypeScript Server');
// });

app.use('/speech-to-text', textRouter);

app.listen(port, () => {
  console.log(`⚡️[server]: Server is running at http://localhost:${port}`);
});