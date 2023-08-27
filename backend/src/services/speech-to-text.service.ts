
import speech from '@google-cloud/speech';
import { protos } from '@google-cloud/speech';
import '../routes/speech.js';


const client = new speech.SpeechClient();
// const gcsUri = 'gs://cloud-samples-data/speech/brooklyn_bridge.raw';

export const transcribe = async function transcribeSpeech(gcsUri: string): Promise<string> {

    const audio = {
        uri: gcsUri,
    };
    const config: protos.google.cloud.speech.v1.IRecognitionConfig = {
       encoding: 'FLAC',
       audioChannelCount: 2,
        // encoding: 'LINEAR16',
        // sampleRateHertz: 16000,
        languageCode: 'en-US',
     

    };
    const request: protos.google.cloud.speech.v1.IRecognizeRequest = {
        audio: audio,
        config: config,
    };

    try {
        const [operation] = await client.longRunningRecognize(request);
        const [response] = await operation.promise();

        if (response.results && response.results.length > 0) {
            const transcription = response.results
                .map(result => {
                    if (result.alternatives && result.alternatives.length > 0) {
                        return result.alternatives[0].transcript;
                    } else {
                        return '';
                    }
                })
                .join('\n');
            console.log(`Transcription: ${transcription}`);
            return transcription;
        } else {
            console.log('No transcription results found.');
            return '';
        }
    } catch (error) {
        console.error('Error:', error);
        throw error;
    }

}