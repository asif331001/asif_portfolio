{{flutter_js}}
{{flutter_build_config}}

_flutter.loader.load({
  onEntrypointLoaded: async function(engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine();
    await appRunner.runApp();

    requestAnimationFrame(() => {
      requestAnimationFrame(() => {
        const loader = document.getElementById('portfolio-loader');

        if (!loader) {
          return;
        }

        loader.classList.add('loader-hidden');

        window.setTimeout(() => {
          loader.remove();
          document.body.style.overflow = '';
        }, 450);
      });
    });
  }
});
