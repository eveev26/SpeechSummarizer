"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.transcribe = void 0;
const speech = require('@google-cloud/speech');
const client = new speech.SpeechClient();
const gcsUri = 'gs://cloud-samples-data/speech/brooklyn_bridge.raw';
// const gcsUri = 'gs://cloud-samples-data/speech/brooklyn_bridge.raw';
const transcribe = function transcribeSpeech(gcsUri) {
    return __awaiter(this, void 0, void 0, function* () {
        const audio = {
            uri: gcsUri,
        };
        const config = {
            encoding: 'FLAC',
            languageCode: 'en-US',
            audioChannelCount: 2,
        };
        const request = {
            audio: audio,
            config: config,
        };
        try {
            const [response] = yield client.recognize(request);
            const transcription = response.results
                .map(result => result.alternatives[0].transcript)
                .join('\n');
            console.log(`Transcription: ${transcription}`);
            return transcription;
        }
        catch (error) {
            console.error('Error:', error);
            throw error;
        }
    });
};
exports.transcribe = transcribe;
