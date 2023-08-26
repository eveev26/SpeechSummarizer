
export const return_meeting_minutes = async function return_meeting_minutes(transcript: String) {

    const cohere = require('cohere-ai');
    cohere.init('MMUi7kMlMrfBI0cGhXM9w8fngkwFyNPtjaGWWF4S'); // This is your trial API key
    const tokens = ~~(transcript.split(" ").length / 2);


    const response = await cohere.generate({
        model: 'command',
        prompt: `The output is as follows:\n
                      - \"Meeting Minutes:\" followed by the company name mentioned\n
                      - \"Date:\" followed by the date mentioned. If not mentioned, write [ date ] instead\n
                      - \"Attendees:\" followed by a list of people present in the meeting\n
                      end of output\n\n
                      The transcript is: ` + transcript,
        max_tokens: 56,
        temperature: 0,
        k: 0,
        stop_sequences: [],
        return_likelihoods: 'NONE'
    });
    console.log(response.body.generations[0].text + '\n\n');

    const response2 = await cohere.generate({
        model: 'command',
        prompt: 'Organize the transcript into sections and make a summary for each section like this:\n\nSection 1: {input a section title]\n- point 1.1\n- point 1.2\n\nSection 2:  {input a section title]\n- point 2.1\n- point 2.2\n\n... continue for however many sections there are\n\ntranscript:\n' + transcript,
        max_tokens: tokens,
        temperature: 0,
        k: 0,
        stop_sequences: [],
        return_likelihoods: 'NONE'
    });
    console.log(response2.body.generations[0].text + '\n\n');
    // console.log(`${response2.body.generations[0].text}`);

    // No idea why but response3 gives errors if you wait a little while
    const response3 = await cohere.generate({
        model: 'command',
        prompt: 'The output is as follows:\n- \"Next Steps: \" followed by a list of things that will happen after the meeting\nend of output\n\nThe transcript is:\n' + transcript,
        max_tokens: 300,
        temperature: 0,
        k: 0,
        stop_sequences: [],
        return_likelihoods: 'NONE'
    });
    console.log(response3.body.generations[0].text);
    return response3.body.generations[0].text;
}
