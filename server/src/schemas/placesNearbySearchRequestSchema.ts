import {z} from "zod";
import { locationSchema } from "./locationSchema";

export const placesNearbySearchRequestSchema = z.object({
  location: locationSchema,
  radius: z.number(),
})

export type PlacesNearbySearchRequest = z.infer<typeof placesNearbySearchRequestSchema>;
