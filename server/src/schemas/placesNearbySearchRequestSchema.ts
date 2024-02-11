import { z } from 'zod';

export const placesNearbySearchRequestSchema = z.object({
  latitude: z.coerce.number().min(-90).max(90),
  longitude: z.coerce.number().min(-180).max(180),
  radius: z.coerce.number().positive(),
});

export type PlacesNearbySearchRequest = z.infer<
  typeof placesNearbySearchRequestSchema
>;
