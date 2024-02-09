
export const port = Number(process.env.PORT) | 8080;

export const googleApiKey = process.env.GOOGLE_API_KEY;

export const nodeEnv = process.env.NODE_ENV;

if (!googleApiKey){
  console.error("GOOGLE_API_KEY not set. Program will abort.")
  process.abort();
}

if (!nodeEnv){
  console.error("NODE_ENV not set. Program will abort.")
  process.abort();
}

console.log(`Program is running in ${nodeEnv} mode`)
