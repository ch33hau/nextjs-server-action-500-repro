# Next.js: malformed server action requests return 500

Any multipart POST is treated as a possible server action, on every path.
Some invalid ones are answered with 500 instead of 4xx.

```sh
npm install
npm run build && npm start
npm run repro
```
