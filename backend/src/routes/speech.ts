import express, { Request, Response } from 'express';
import * as  textService from "../services/speech-to-text.service.js";
import * as  summaryService from "../summarize/generate_notes.js";
import { return_meeting_minutes } from '../summarize/generate_notes.js'; 


export const textRouter = express.Router();

textRouter.use(express.json());

textRouter.post('/', async (req: Request, res: Response) => {
    try {
     
   
        const gcsUri = req.body.file_url;
           // Print the gcsUri value to the console
        console.log("Received gcsUri:", gcsUri);
     
       const transcribe = await textService.transcribe(gcsUri);

     //ToDo: Integrate with genete meeting minutes class 
      const response = await summaryService.return_meeting_minutes(transcribe); 
   
       res.status(201).json(response);
    
   
     } catch (e) {
       if (typeof e === "object" && e instanceof Error && e.message) {
         res.status(500).send(e.message);
       } else {
         res.status(500).send("An unknown error occurred.");
       }
     }
});