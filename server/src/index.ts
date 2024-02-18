import { port } from './utils/environment';
import app from './app';
import { createServer } from 'node:http';

const server = createServer(app);

server.keepAliveTimeout = 120000; // 120 seconds
server.headersTimeout = 120000; // 120 seconds

server.listen(port, () => {
  console.log(`Listening on port ${port}`);
});
