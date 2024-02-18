import { port } from './utils/environment';
import app from './app';

const server = app.listen(port, () => {
  console.log(`Listening on port ${port}`);
});

server.keepAliveTimeout = 120000; // 120 seconds
server.headersTimeout = 120000; // 120 seconds
