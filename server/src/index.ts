import { port } from './utils/environment';
import app from './app';

app.listen(port, () => {
  console.log(`Listening on port ${port}`);
});
