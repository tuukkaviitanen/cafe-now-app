import { describe, it, expect } from 'bun:test';
import supertest from 'supertest';
import { z } from 'zod';

import app from '../app';
import { placeSchema } from '../schemas/placesNearbySearchResponseSchema';

const api = supertest(app);

//nock('http://localhost:3000').get('/').reply(200, mockData).persist();

describe('api endpoints', () => {
  describe('/nearbyCafes', () => {
    describe('returns 400', () => {
      it('when no query parameters', async () => {
        const response = await api.get('/nearbyCafes');
        expect(response.status).toBe(400);
      });
      it('when latitude is missing', async () => {
        const response = await api.get(
          '/nearbyCafes?longitude=23.78712&radius=3000',
        );
        expect(response.status).toBe(400);
      });

      it('when longitude is missing', async () => {
        const response = await api.get(
          '/nearbyCafes?latitude=61.49911&radius=3000',
        );
        expect(response.status).toBe(400);
      });

      it('when radius is missing', async () => {
        const response = await api.get(
          '/nearbyCafes?latitude=61.49911&longitude=23.78712',
        );
        expect(response.status).toBe(400);
      });

      it('when latitude is malformatted', async () => {
        const response = await api.get(
          '/nearbyCafes?latitude=61.4asd9911&longitude=23.78712&radius=3000',
        );
        expect(response.status).toBe(400);
      });

      it('when longitude is malformatted', async () => {
        const response = await api.get(
          '/nearbyCafes?latitude=61.49911&longitude=23.7871v2&radius=3000',
        );
        expect(response.status).toBe(400);
      });

      it('when radius is malformatted', async () => {
        const response = await api.get(
          '/nearbyCafes?latitude=61.49911&longitude=23.78712&radius=3s000',
        );
        expect(response.status).toBe(400);
      });

      it('when radius is negative', async () => {
        const response = await api.get(
          '/nearbyCafes?latitude=61.49911&longitude=23.78712&radius=-3000',
        );
        expect(response.status).toBe(400);
      });

      it('when latitude is out of range of -90 to 90', async () => {
        const response = await api.get(
          '/nearbyCafes?latitude=91&longitude=23.78712&radius=3000',
        );
        expect(response.status).toBe(400);
      });

      it('when latitude is out of range of -90 to 90', async () => {
        const response = await api.get(
          '/nearbyCafes?latitude=-91&longitude=23.78712&radius=3000',
        );
        expect(response.status).toBe(400);
      });

      it('when longitude is out of range of -180 to 180', async () => {
        const response = await api.get(
          '/nearbyCafes?latitude=61.49911&longitude=181&radius=3000',
        );
        expect(response.status).toBe(400);
      });

      it('when longitude is out of range of -180 to 180', async () => {
        const response = await api.get(
          '/nearbyCafes?latitude=61.49911&longitude=-181&radius=3000',
        );
        expect(response.status).toBe(400);
      });
    });

    describe('returns 200', () => {
      it('when valid query parameters sent', async () => {
        const response = await api.get(
          '/nearbyCafes?latitude=61.49911&longitude=23.78712&radius=3000',
        );
        expect(response.status).toBe(200);
      });

      it('and a response body with array of places when valid query parameters sent', async () => {
        const response = await api.get(
          '/nearbyCafes?latitude=61.49911&longitude=23.78712&radius=3000',
        );

        expect(response.body).toBeObject();

        const parseResult = z.array(placeSchema).safeParse(response.body);

        expect(parseResult.success).toBe(true);
      });
    });
  });
});
