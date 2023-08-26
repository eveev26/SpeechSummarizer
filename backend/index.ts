import express, { Express, Request, Response } from 'express';
import dotenv from 'dotenv';
import {textRouter} from './src/routes/speech.js';
import { generate_meeting_minutes } from "./summarize/generate_notes";

dotenv.config();

const app: Express = express();
const port = 8080;
// const http = require('http');
// var transcript = require('./summarize/test_transcript');
// var index = require('./summarize/generate_notes');

// app.post('/', (req: Request, res: Response) => {
//   res.send('Express + TypeScript Server');
// });

app.use('/speech-to-text', textRouter);

app.listen(port, () => {
  console.log(`⚡️[server]: Server is running at http://localhost:${port}`);
  generate_meeting_minutes();
});