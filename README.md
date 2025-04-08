# `@lib/run`

Compile and run TypeScript in Node with source map support in under 50 lines of code.

Directly run a TypeScript file right now without installing anything but Node:

```bash
npx @lib/run script.ts
```

Or install:

```bash
npm install --save-dev @lib/run
```

Then:

```bash
npx run script.ts
```

Or within a `package.json` script:

```bash
run script.ts
```

The option `-p` will `require()` a JS file before loading the TypeScript compiler. It can be given multiple times:

```bash
npx run -p ./preload-1.js -p ./preload-2.js script.ts
```

# License

0BSD, which means use as you wish and no need to mention this project or its author. Consider it public domain in practice.
