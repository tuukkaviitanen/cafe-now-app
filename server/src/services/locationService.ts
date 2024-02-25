import axios from 'axios';
import {
  placesNearbySearchResponseSchema,
  type Place,
} from '../schemas/placesNearbySearchResponseSchema';
import { googleApiKey, mockApiUrl, nodeEnv } from '../utils/environment';
import type { PlacesNearbySearchRequest } from '../schemas/placesNearbySearchRequestSchema';

const getNearbyCafes = async ({
  latitude,
  longitude,
}: PlacesNearbySearchRequest): Promise<Place[]> => {
  const apiUrl =
    nodeEnv === 'production'
      ? `https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${latitude},${longitude}&type=cafe&rankby=distance&key=${googleApiKey}&opennow=true`
      : mockApiUrl!; // Program would have aborted in environment.ts if nodeEnv is not production and mockApiUrl doesn't exist

  const axiosResponse = await axios.get(apiUrl);

  const parsedResponse = placesNearbySearchResponseSchema.parse(
    axiosResponse.data,
  );

  return parsedResponse.results;
};

const locationService = { getNearbyCafes };

export default locationService;
