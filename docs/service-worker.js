// Generated file ** DO NOT EDIT DIRECTLY ** Edit Elm files instead

self.addEventListener('install', event => {
    self.skipWaiting();
});

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
        "url": "/30-days-of-elm/elm-0.0.14-25dc551.min.js",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/manifest.json",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day1",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day2",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day3",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day4",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day5",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day6",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day7",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day8",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day9",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day10",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day11",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day12",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day13",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day14",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day15",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day16",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day17",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day18",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day19",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day20",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day21",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day22",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day23",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day24",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day25",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day26",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day27",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day28",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day29",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/day30",
        "revision": "0.0.14.25dc551"
    },
    {
        "url": "/30-days-of-elm/icons/128.png",
        "revision": "fa1639c924072b59cad77408e194d922c378ad58.25dc551"
    },
    {
        "url": "/30-days-of-elm/icons/144.png",
        "revision": "a39419f8cbdb4cd854228825db81d6ff5e586eab.25dc551"
    },
    {
        "url": "/30-days-of-elm/icons/152.png",
        "revision": "f0fc5fd98dedd06d67e7d3d9709315c579126a55.25dc551"
    },
    {
        "url": "/30-days-of-elm/icons/16.png",
        "revision": "bcd93addf48b1b164768eade6c1d066045ca41ea.25dc551"
    },
    {
        "url": "/30-days-of-elm/icons/192.png",
        "revision": "6caf86e4529cb61ed2708fb4bb61aa65e7d7ed81.25dc551"
    },
    {
        "url": "/30-days-of-elm/icons/256.png",
        "revision": "8b690c7a43277ae70a0f2ebe763fbd0c0ab204b8.25dc551"
    },
    {
        "url": "/30-days-of-elm/icons/32.png",
        "revision": "89136decab0e9c9f378edb279cdfa54d739f778b.25dc551"
    },
    {
        "url": "/30-days-of-elm/icons/512.png",
        "revision": "fb5257f2ef194a869cccee2461b1b5d5f1a2c06f.25dc551"
    },
    {
        "url": "/30-days-of-elm/icons/64.png",
        "revision": "274d48a5b098f3dc910d88a3684443fc7c535047.25dc551"
    }
]
);


registerRoute(
    ({request}) => {
        return request.destination === 'document'
    },
    new NetworkFirst()
);

registerRoute(
    ({request}) => {
        return request.destination === 'script'
    },
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
