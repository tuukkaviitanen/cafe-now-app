export const port = Number(process.env.PORT) | 8080;

export const googleApiKey = process.env.GOOGLE_API_KEY;

export const nodeEnv = process.env.NODE_ENV;

export const mockApiUrl = process.env.MOCK_API_URL;

if (!nodeEnv) {
  console.error('NODE_ENV not set. Program will abort.');
  process.abort();
}

if (nodeEnv === "production" && !googleApiKey) {
  console.error('Program is running in production mode and GOOGLE_API_KEY not provided. Program will abort.');
  process.abort();
}

if (nodeEnv !== 'production' && !mockApiUrl) {
  console.error(
    'Program is set to run a development build, but MOCK_API_URL is not provided. Program will abort.',
  );
}

console.log(`Program is running in ${nodeEnv} mode`);
