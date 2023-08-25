import express, { Request, Response } from 'express';

export const textRouter = express.Router();

textRouter.use(express.json());

textRouter.post('/', async (req: Request, res: Response) => {
    
});