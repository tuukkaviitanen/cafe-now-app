import { z } from 'zod';

export const placesNearbySearchRequestSchema = z.object({
  latitude: z.coerce.number(),
  longitude: z.coerce.number(),
  radius: z.coerce.number(),
});

export type PlacesNearbySearchRequest = z.infer<
  typeof placesNearbySearchRequestSchema
>;
