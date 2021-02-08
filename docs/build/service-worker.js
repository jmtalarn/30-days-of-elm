// Generated file ** DO NOT EDIT DIRECTLY ** Edit Elm files instead
//
// This is implemented using Workbox
// https://developers.google.com/web/tools/workbox
//

importScripts('https://storage.googleapis.com/workbox-cdn/releases/5.1.2/workbox-sw.js');

const registerRoute = workbox.routing.registerRoute;
const NetworkFirst = workbox.strategies.NetworkFirst;
const CacheFirst = workbox.strategies.CacheFirst;
const StaleWhileRevalidate = workbox.strategies.StaleWhileRevalidate;
const ExpirationPlugin = workbox.expiration.ExpirationPlugin;
const precacheAndRoute = workbox.precaching.precacheAndRoute;

// https://developers.google.com/web/tools/workbox/guides/precache-files
precacheAndRoute( 
[
    {
        "url": "/elm-0.0.9-7d79f10.min.js",
        "revision": "0.0.9"
    },
    {
        "url": "/manifest.json",
        "revision": "0.0.9"
    },
    {
        "url": "/",
        "revision": "0.0.9"
    },
    {
        "url": "/page-a",
        "revision": "0.0.9"
    },
    {
        "url": "/page-b",
        "revision": "0.0.9"
    },
    {
        "url": "/day-1",
        "revision": "0.0.9"
    },
    {
        "url": "/day-2",
        "revision": "0.0.9"
    },
    {
        "url": "/day-3",
        "revision": "0.0.9"
    },
    {
        "url": "/day-4",
        "revision": "0.0.9"
    },
    {
        "url": "/day-5",
        "revision": "0.0.9"
    },
    {
        "url": "/day-6",
        "revision": "0.0.9"
    },
    {
        "url": "/day-7",
        "revision": "0.0.9"
    },
    {
        "url": "/day-8",
        "revision": "0.0.9"
    },
    {
        "url": "/day-9",
        "revision": "0.0.9"
    },
    {
        "url": "/day-10",
        "revision": "0.0.9"
    },
    {
        "url": "/day-11",
        "revision": "0.0.9"
    },
    {
        "url": "/day-12",
        "revision": "0.0.9"
    },
    {
        "url": "/day-13",
        "revision": "0.0.9"
    },
    {
        "url": "/day-14",
        "revision": "0.0.9"
    },
    {
        "url": "/day-15",
        "revision": "0.0.9"
    },
    {
        "url": "/day-16",
        "revision": "0.0.9"
    },
    {
        "url": "/day-17",
        "revision": "0.0.9"
    },
    {
        "url": "/day-18",
        "revision": "0.0.9"
    },
    {
        "url": "/day-19",
        "revision": "0.0.9"
    },
    {
        "url": "/day-20",
        "revision": "0.0.9"
    },
    {
        "url": "/day-21",
        "revision": "0.0.9"
    },
    {
        "url": "/day-22",
        "revision": "0.0.9"
    },
    {
        "url": "/day-23",
        "revision": "0.0.9"
    },
    {
        "url": "/day-24",
        "revision": "0.0.9"
    },
    {
        "url": "/day-25",
        "revision": "0.0.9"
    },
    {
        "url": "/day-26",
        "revision": "0.0.9"
    },
    {
        "url": "/day-27",
        "revision": "0.0.9"
    },
    {
        "url": "/day-28",
        "revision": "0.0.9"
    },
    {
        "url": "/day-29",
        "revision": "0.0.9"
    },
    {
        "url": "/day-30",
        "revision": "0.0.9"
    },
    {
        "url": "/icons/128.png",
        "revision": "1e6107b75b03b60ea9f0fccb4e4236a4eb0a482c"
    },
    {
        "url": "/icons/144.png",
        "revision": "7c184e21a8fc44eba2c653aa2d0e62cb75427c9b"
    },
    {
        "url": "/icons/152.png",
        "revision": "0e0ece055aaa83de97c06b10f12f1d6d4d6b714e"
    },
    {
        "url": "/icons/16.png",
        "revision": "8c70bd43a7077ed662b8ace7dd212903035d3f48"
    },
    {
        "url": "/icons/192.png",
        "revision": "53d0e47d4bd030cd15ca0d33b3b628ee8494205b"
    },
    {
        "url": "/icons/256.png",
        "revision": "898d21323ec122b49b36b5753b31b0c67bba98f5"
    },
    {
        "url": "/icons/32.png",
        "revision": "bfac25e4aee7172db213b148e889c076a278347c"
    },
    {
        "url": "/icons/512.png",
        "revision": "46d886e7feecb12f446256758f7860bd823e9aaf"
    },
    {
        "url": "/icons/64.png",
        "revision": "711d2d9c1419ce5aa111c19928da0851d0025702"
    }
]
);

registerRoute(
    ({request}) => request.destination === 'script',
    new NetworkFirst()
);

registerRoute(
    // Cache style assets, i.e. CSS files.
    ({request}) => request.destination === 'style',
    // Use cache but update in the background.
    new StaleWhileRevalidate({
        // Use a custom cache name.
        cacheName: 'css-cache',
    })
);

// From https://developers.google.com/web/tools/workbox/guides/common-recipes
registerRoute(
  ({request}) => request.destination === 'image',
  new CacheFirst({
    cacheName: 'images',
    plugins: [
      new ExpirationPlugin({
        maxEntries: 60,
        maxAgeSeconds: 30 * 24 * 60 * 60, // 30 Days
      }),
    ],
  })
);
