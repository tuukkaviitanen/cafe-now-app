import axios from 'axios';
import {
  placesNearbySearchResponseSchema,
  type Place,
} from '../schemas/placesNearbySearchResponseSchema';
import { googleApiKey, mockApiUrl, nodeEnv } from '../config';
import type { PlacesNearbySearchRequest } from '../schemas/placesNearbySearchRequestSchema';

const getNearbyCafes = async ({
  latitude,
  longitude,
  radius,
}: PlacesNearbySearchRequest): Promise<Place[]> => {
  const apiUrl =
    nodeEnv === 'production'
      ? `https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${latitude},${longitude}&radius=${radius}&type=cafe&key=${googleApiKey}`
      : mockApiUrl!; // Program would have aborted in config.ts if nodeEnv is not production and mockApiUrl doesn't exist

  const axiosResponse = await axios.get(apiUrl);

  const parsedResponse = placesNearbySearchResponseSchema.parse(
    axiosResponse.data,
  );

  return parsedResponse.results;
};

const locationService = { getNearbyCafes };

export default locationService;
