
const speech = require('@google-cloud/speech');


const client = new speech.SpeechClient();
const gcsUri = 'gs://cloud-samples-data/speech/brooklyn_bridge.raw';

// const gcsUri = 'gs://cloud-samples-data/speech/brooklyn_bridge.raw';
export const transcribe = async function transcribeSpeech(gcsUri: string) {

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
        const [response] = await client.recognize(request);
        const transcription = response.results
            .map(result => result.alternatives[0].transcript)
            .join('\n');
        console.log(`Transcription: ${transcription}`);
        return transcription;
    } catch (error) {
        console.error('Error:', error);
        throw error;
    }

}
