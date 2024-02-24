import { z } from 'zod';

export const locationSchema = z.object({
  lat: z.number(),
  lng: z.number(),
});

const placeGeometrySchema = z.object({
  location: locationSchema,
  viewport: z.object({
    northeast: locationSchema,
    southwest: locationSchema,
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

const placeEditorialSummarySchema = z.object({
  language: z.string().optional(),
  overview: z.string().optional(),
});

export const placeSchema = z.object({
  business_status: z.union([
    z.literal('OPERATIONAL'),
    z.literal('CLOSED_TEMPORARILY'),
    z.literal('CLOSED_PERMANENTLY'),
  ]),
  formatted_address: z.string().optional(),
  geometry: placeGeometrySchema,
  icon: z.string(),
  name: z.string(),
  opening_hours: placeOpeningHoursSchema.optional(),
  place_id: z.string(),
  rating: z.number().optional(),
  reference: z.string(),
  types: z.array(z.string()),
  vicinity: z.string().optional(),
  website: z.string().optional(),
  price_level: z.number().optional(),
  wheelchair_accessible_entrance: z.boolean().optional(),
  editorial_summary: placeEditorialSummarySchema.optional(),
});

export const placesNearbySearchResponseSchema = z.object({
  html_attributions: z.array(z.string()).optional(),
  next_page_token: z.string().optional(),
  results: z.array(placeSchema),
  status: z.string(),
});

export type PlacesNearbySearchResponse = z.infer<
  typeof placesNearbySearchResponseSchema
>;

export type Place = z.infer<typeof placeSchema>;

export type Location = z.infer<typeof locationSchema>;
