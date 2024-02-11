import { describe, it, expect } from 'bun:test';
import supertest from 'supertest';

import app from '../app';

const api = supertest(app);

//nock('http://localhost:3000').get('/').reply(200, mockData).persist();

describe('api endpoints', () => {
  describe('/nearbyCafes', () => {
    it('returns 400 when no query parameters', () => {
      api.get('/nearbyCafes').expect(400);
    });

    it('returns 200 when valid query parameters sent', () => {
      api
        .get('/nearbyCafes?latitude=61.49911&longitude=23.78712&radius=3000')
        .expect(200);
    });

    it('returns object when valid query parameters sent', async () => {
      const response = await api
        .get('/nearbyCafes?latitude=61.49911&longitude=23.78712&radius=3000')
        .expect(200);

      expect(response.status).toEqual(200);
    });
  });
});
