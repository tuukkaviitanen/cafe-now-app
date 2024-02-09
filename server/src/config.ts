
export const port = Number(process.env.PORT) ?? 8080;

export const googleApiKey = process.env.GOOGLE_API_KEY;

if (!googleApiKey){
  console.error("Google API Key not set. Program will abort.")
  process.abort();
}
