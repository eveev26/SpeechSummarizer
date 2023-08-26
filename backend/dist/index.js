"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const dotenv_1 = __importDefault(require("dotenv"));
const speech_1 = require("./routes/speech");
const generate_notes_1 = require("./summarize/generate_notes");
dotenv_1.default.config();
const app = (0, express_1.default)();
const port = 8080;
// const http = require('http');
// var transcript = require('./summarize/test_transcript');
// var index = require('./summarize/generate_notes');
// app.post('/', (req: Request, res: Response) => {
//   res.send('Express + TypeScript Server');
// });
app.use('/speech-to-text', speech_1.textRouter);
app.listen(port, () => {
    console.log(`⚡️[server]: Server is running at http://localhost:${port}`);
    (0, generate_notes_1.generate_meeting_minutes)();
});
