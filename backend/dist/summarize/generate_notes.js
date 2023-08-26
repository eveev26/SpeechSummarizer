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
exports.generate_meeting_minutes = void 0;
var transcript = require('./test_transcript');
const cohere = require('cohere-ai');
cohere.init('MMUi7kMlMrfBI0cGhXM9w8fngkwFyNPtjaGWWF4S'); // This is your trial API key
const tokens = ~~(transcript.transcript().split(" ").length / 2);
function generate_meeting_minutes() {
    () => __awaiter(this, void 0, void 0, function* () {
        const response = yield cohere.generate({
            model: 'command',
            prompt: `The output is as follows:\n
                  - \"Meeting Minutes:\" followed by the company name mentioned\n
                  - \"Date:\" followed by the date mentioned. If not mentioned, write [ date ] instead\n
                  - \"Attendees:\" followed by a list of people present in the meeting\n
                  end of output\n\n
                  The transcript is: ` + transcript.transcript(),
            max_tokens: 56,
            temperature: 0,
            k: 0,
            stop_sequences: [],
            return_likelihoods: 'NONE'
        });
        console.log(response.body.generations[0].text + '\n\n');
        const response2 = yield cohere.generate({
            model: 'command',
            prompt: 'Organize the transcript into sections and make a summary for each section like this:\n\nSection 1: {input a section title]\n- point 1.1\n- point 1.2\n\nSection 2:  {input a section title]\n- point 2.1\n- point 2.2\n\n... continue for however many sections there are\n\ntranscript:\n' + transcript.transcript(),
            max_tokens: tokens,
            temperature: 0,
            k: 0,
            stop_sequences: [],
            return_likelihoods: 'NONE'
        });
        console.log(response2.body.generations[0].text + '\n\n');
        // console.log(`${response2.body.generations[0].text}`);
        // No idea why but response3 gives errors if you wait a little while
        const response3 = yield cohere.generate({
            model: 'command',
            prompt: 'The output is as follows:\n- \"Next Steps: \" followed by a list of things that will happen after the meeting\nend of output\n\nThe transcript is:\n' + transcript.transcript(),
            max_tokens: 300,
            temperature: 0,
            k: 0,
            stop_sequences: [],
            return_likelihoods: 'NONE'
        });
        console.log(response3.body.generations[0].text);
    });
}
exports.generate_meeting_minutes = generate_meeting_minutes;
;
