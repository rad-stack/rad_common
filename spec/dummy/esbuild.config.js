const esbuild = require('esbuild');
const path = require('path');

const radCommonJsWatchPlugin = {
  name: 'rad-common-js-watch',
  setup(build) {
    build.onLoad({ filter: /.*/ }, async (args) => {
      if (args.path.includes('rad_common_js')) {
        return {
          watchDirs: [path.resolve(__dirname, 'rad_common_js/src')]
        };
      }
    });
  }
};

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
    },
    plugins: [radCommonJsWatchPlugin]
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
