const esbuild = require('esbuild');
const path = require('path');
const fs = require('fs');
const { execSync } = require('child_process');

const radCommonPath = execSync('bundle show rad_common')
  .toString()
  .trim();

const watchRadCommonPlugin = {
  name: 'watch-rad-common',
  setup(build) {
    const radCommonJsPath = path.join(radCommonPath, 'app/javascript/rad_common');

    build.onLoad({ filter: /.*/ }, async (args) => {
      if (args.path.includes('rad_common')) {
        return {
          contents: await fs.promises.readFile(args.path, 'utf8'),
          loader: 'js',
          watchDirs: [radCommonJsPath]
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
    alias: {
      'rad_common': path.join(radCommonPath, 'app/javascript/rad_common')
    },
    nodePaths: [path.join(__dirname, 'node_modules')],
    plugins: [watchRadCommonPlugin]
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
