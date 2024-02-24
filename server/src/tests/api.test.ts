import { describe, it, expect } from 'bun:test';
import supertest from 'supertest';
import { z } from 'zod';

import app from '../app';
import { placeSchema } from '../schemas/placesNearbySearchResponseSchema';

const api = supertest(app);

describe('api endpoints', () => {
  describe('/nearbyCafes', () => {
    describe('returns 200', () => {
      it('when valid query parameters sent', async () => {
        const response = await api.get(
          '/nearbyCafes?latitude=61.49911&longitude=23.787120',
        );
        expect(response.status).toBe(200);
      });

      it('and a response body with array of places when valid query parameters sent', async () => {
        const response = await api.get(
          '/nearbyCafes?latitude=61.49911&longitude=23.78712',
        );

        expect(response.body).toBeObject();

        const parseResult = z.array(placeSchema).safeParse(response.body);

        expect(parseResult.success).toBe(true);
      });
    });
    describe('returns 400', () => {
      it('when no query parameters are given', async () => {
        const response = await api.get('/nearbyCafes');
        expect(response.status).toBe(400);
      });
      describe('when latitude', () => {
        it('is missing', async () => {
          const response = await api.get('/nearbyCafes?longitude=23.78712');
          expect(response.status).toBe(400);
        });

        it('is malformatted', async () => {
          const response = await api.get(
            '/nearbyCafes?latitude=61.4asd9911&longitude=23.78712',
          );
          expect(response.status).toBe(400);
        });

        it('is over 90', async () => {
          const response = await api.get(
            '/nearbyCafes?latitude=91&longitude=23.78712',
          );
          expect(response.status).toBe(400);
        });

        it('is under -90', async () => {
          const response = await api.get(
            '/nearbyCafes?latitude=-91&longitude=23.78712',
          );
          expect(response.status).toBe(400);
        });
      });

      describe('when longitude', () => {
        it('is missing', async () => {
          const response = await api.get('/nearbyCafes?latitude=61.49911');
          expect(response.status).toBe(400);
        });

        it('is malformatted', async () => {
          const response = await api.get(
            '/nearbyCafes?latitude=61.49911&longitude=23.7871v2',
          );
          expect(response.status).toBe(400);
        });

        it('is over 180', async () => {
          const response = await api.get(
            '/nearbyCafes?latitude=61.49911&longitude=181',
          );
          expect(response.status).toBe(400);
        });

        it('is under -180', async () => {
          const response = await api.get(
            '/nearbyCafes?latitude=61.49911&longitude=-181',
          );
          expect(response.status).toBe(400);
        });
      });
    });
  });
});
