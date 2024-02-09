import axios from "axios";
import { placesNearbySearchResponseSchema, type PlacesNearbySearchResponse, type Place } from "../schemas/locationResultSchema";

const url = "http://localhost:3000/data"

const getNearbyCafes = async (): Promise<Place[]> => {
  const result = await axios.get(url);

  const response = placesNearbySearchResponseSchema.parse(result.data);

  return response.results;
}

const locationService = {getNearbyCafes}

export default locationService;
