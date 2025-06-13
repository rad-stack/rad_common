const esbuild = require('esbuild');

async function build() {
  const nodeEnv = process.env.NODE_ENV || 'development';
  const ctx = await esbuild.context({
    entryPoints: ['app/javascript/application.js'],
    outdir: 'app/assets/builds',
    bundle: true,
    sourcemap: true,
    format: 'esm',
    publicPath: '/assets',
    minify: nodeEnv === 'production',
    define: {
      'process.env.SENTRY_DSN': JSON.stringify(process.env.SENTRY_DSN || ''),
      'process.env.NODE_ENV': JSON.stringify(nodeEnv),
      global: 'window'
    }
  });

  if (process.argv.includes('--watch')) {
    await ctx.watch();
  } else {
    await ctx.rebuild();
    ctx.dispose();
  }
}

build().catch((err) => {
  console.error(err);
  process.exit(1);
});
