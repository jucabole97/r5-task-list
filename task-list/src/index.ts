/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import {onRequest} from "firebase-functions/v2/https";

import {TranslationServiceClient} from "@google-cloud/translate";
import * as dotenv from "dotenv";

const text = "Hola mundo!";
const credentialsPath = process.env.GOOGLE_APPLICATION_CREDENTIALS;

dotenv.config();

/**
 * Method to translate text list by target language.
 * @return {Promise<string[]>} - Promise to text list.
*/
async function translateText(): Promise<string> {
  const translate = new TranslationServiceClient({
    keyFilename: credentialsPath,
  });
  // Construct request
  const request = {
    parent: "projects/r5-task-list/locations/global",
    contents: [text],
    mimeType: "text/plain", // mime types: text/plain, text/html
    sourceLanguageCode: "es",
    targetLanguageCode: "en",
  };

  // Run request
  const [response] = await translate.translateText(request);

  for (const translation of response.translations ?? []) {
    console.log("Translation:", translation.translatedText);
  }

  const translates = response.translations ?? [];

  return translates[0].translatedText ?? "Hola mundo!";
}

export const translate = onRequest((request, response) => {
  const text = translateText();
  response.send(text);
});
