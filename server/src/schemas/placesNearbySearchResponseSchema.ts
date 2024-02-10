import {z} from "zod";
import { locationSchema } from "./locationSchema";

const placeGeometrySchema = z.object({
  location: locationSchema,
  viewport: z.object({
    northeast: locationSchema,
    southwest: locationSchema
  }),
});

const placeOpeningHoursPeriodSchema = z.object({
  close: z.object({
    day: z.number(),
    time: z.string(),
  }),
  open: z.object({
    day: z.number(),
    time: z.string(),
  }),
});

const placeOpeningHoursSchema = z.object({
  open_now: z.boolean(),
  periods: z.array(placeOpeningHoursPeriodSchema).optional(),
  weekday_text: z.array(z.string()).optional(),
});

const placePhotoSchema = z.object({
  height: z.number(),
  html_attributions: z.array(z.string()),
  photo_reference: z.string(),
  width: z.number(),
});

const placePlusCodeSchema = z.object({
  compound_code: z.string(),
  global_code: z.string(),
});

export const placeSchema = z.object({
  business_status: z.string().optional(),
  formatted_address: z.string().optional(),
  geometry: placeGeometrySchema,
  icon: z.string(),
  name: z.string(),
  opening_hours: placeOpeningHoursSchema.optional(),
  photos: z.array(placePhotoSchema).optional(),
  place_id: z.string(),
  plus_code: placePlusCodeSchema.optional(),
  rating: z.number().optional(),
  reference: z.string(),
  types: z.array(z.string()),
  user_ratings_total: z.number().optional(),
});

export const placesNearbySearchResponseSchema = z.object({
  html_attributions: z.array(z.string()).optional(),
  next_page_token: z.string().optional(),
  results: z.array(placeSchema),
  status: z.string(),
});

export type PlacesNearbySearchResponse = z.infer<typeof placesNearbySearchResponseSchema>;

export type Place = z.infer<typeof placeSchema>;
