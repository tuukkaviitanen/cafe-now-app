import {z} from "zod";

export const locationSchema = z.object({
  lat: z.number(),
  lng: z.number(),
})

export type Location = z.infer<typeof locationSchema>;
