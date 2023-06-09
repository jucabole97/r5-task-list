import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {TranslationServiceClient} from "@google-cloud/translate";
import * as dotenv from "dotenv";

admin.initializeApp();
dotenv.config();

const credentialsPath = process.env.GOOGLE_APPLICATION_CREDENTIALS;

export const translateTaskText = functions
  .region("us-central1")
  .firestore
  .document("tasks{taskId}")
  .onCreate(async (snapshot) => {
    const task = snapshot.data();
    const textsToTranslate = [task.title_es, task.description_es];
    const translatedTask = await translateText(textsToTranslate, "en");

    await snapshot.ref.update({
      title_en: translatedTask[0],
      description_en: translatedTask[1],
    });

    console.log("Tarea traducida:", translatedTask);
  });

/**
 * Method to translate text list by target language.
 * @param {string[]} texts - Text list to translate.
 * @param {string} targetLanguage - Target language to translate text.
 * @return {Promise<string[]>} - Promise to text list.
*/
async function translateText(
  texts: string[],
  targetLanguage: string): Promise<string[]> {
  const translate = new TranslationServiceClient({
    keyFilename: credentialsPath,
  });

  const request = {
    parent: "projects/r5-task-list/locations/global",
    contents: [...texts],
    mimeType: "text/plain",
    sourceLanguageCode: targetLanguage,
    targetLanguageCode: "sr-Latn",
  };

  const [response] = await translate.translateText(request);

  const translateTexts: string[] = [];

  for (const translation of response.translations ?? []) {
    if (translation != null) {
      translateTexts.push(translation.translatedText ?? "");
    }
  }

  return translateTexts;
}
