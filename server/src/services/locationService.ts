import axios from "axios";
import { placesNearbySearchResponseSchema, type Place } from "../schemas/placesNearbySearchResponseSchema";
import { googleApiKey, mockApiUrl, nodeEnv } from "../config";
import type { PlacesNearbySearchRequest } from "../schemas/placesNearbySearchRequestSchema";

const getNearbyCafes = async ({location: {lat, lng}, radius}: PlacesNearbySearchRequest): Promise<Place[]> => {

  const url = (nodeEnv === "production")
  ? `https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${lat}%${lng}&radius=${radius}&type=cafe&key=${googleApiKey}`
  : mockApiUrl!; // Program would have aborted in config.ts if nodeEnv is not production and mockApiUrl doesn't exist

  const result = await axios.get(url);

  const response = placesNearbySearchResponseSchema.parse(result.data);

  return response.results;
}

const locationService = {getNearbyCafes}

export default locationService;
