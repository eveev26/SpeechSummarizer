import express, { Request, Response } from 'express';
import dotenv from 'dotenv';

dotenv.config();

export const textRouter = express.Router();

textRouter.use(express.json());

textRouter.post('/', async (req: Request, res: Response) => {
    
});