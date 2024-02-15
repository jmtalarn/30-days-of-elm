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
        "url": "/30-days-of-elm/elm-0.0.14-697a00c.min.js",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/manifest.json",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day1",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day2",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day3",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day4",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day5",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day6",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day7",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day8",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day9",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day10",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day11",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day12",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day13",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day14",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day15",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day16",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day17",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day18",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day19",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day20",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day21",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day22",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day23",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day24",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day25",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day26",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day27",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day28",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day29",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/day30",
        "revision": "0.0.14.697a00c"
    },
    {
        "url": "/30-days-of-elm/icons/128.png",
        "revision": "fa1639c924072b59cad77408e194d922c378ad58.697a00c"
    },
    {
        "url": "/30-days-of-elm/icons/144.png",
        "revision": "a39419f8cbdb4cd854228825db81d6ff5e586eab.697a00c"
    },
    {
        "url": "/30-days-of-elm/icons/152.png",
        "revision": "f0fc5fd98dedd06d67e7d3d9709315c579126a55.697a00c"
    },
    {
        "url": "/30-days-of-elm/icons/16.png",
        "revision": "bcd93addf48b1b164768eade6c1d066045ca41ea.697a00c"
    },
    {
        "url": "/30-days-of-elm/icons/192.png",
        "revision": "6caf86e4529cb61ed2708fb4bb61aa65e7d7ed81.697a00c"
    },
    {
        "url": "/30-days-of-elm/icons/256.png",
        "revision": "8b690c7a43277ae70a0f2ebe763fbd0c0ab204b8.697a00c"
    },
    {
        "url": "/30-days-of-elm/icons/32.png",
        "revision": "89136decab0e9c9f378edb279cdfa54d739f778b.697a00c"
    },
    {
        "url": "/30-days-of-elm/icons/512.png",
        "revision": "fb5257f2ef194a869cccee2461b1b5d5f1a2c06f.697a00c"
    },
    {
        "url": "/30-days-of-elm/icons/64.png",
        "revision": "274d48a5b098f3dc910d88a3684443fc7c535047.697a00c"
    },
    {
        "url": "/30-days-of-elm/images/earth-clip-rotating-17.gif",
        "revision": "f4b364a7472ca4f75b1e95a17003fd401831e53a.697a00c"
    },
    {
        "url": "/30-days-of-elm/images/earth.svg",
        "revision": "14eef1ea11ebb2435e60722429ec1e449f8a62d5.697a00c"
    },
    {
        "url": "/30-days-of-elm/images/jupiter.svg",
        "revision": "7961f41d801a77d1697d65b7c494d542cfd75f3f.697a00c"
    },
    {
        "url": "/30-days-of-elm/images/mars.svg",
        "revision": "af65f209bf0c1754fdc29419650ba37925330df3.697a00c"
    },
    {
        "url": "/30-days-of-elm/images/mercury.svg",
        "revision": "5757a62c9afde6c01259393fd5828dad206b98fb.697a00c"
    },
    {
        "url": "/30-days-of-elm/images/neptune.svg",
        "revision": "afaa2ae9e4572e6c6626228143e9d0e4cddcc485.697a00c"
    },
    {
        "url": "/30-days-of-elm/images/pluto.svg",
        "revision": "17873b1670cb45588998b6c4cfb04c6e58fca261.697a00c"
    },
    {
        "url": "/30-days-of-elm/images/saturn.svg",
        "revision": "caf8031d703ee60ce6255630fda2d4ec13eb4870.697a00c"
    },
    {
        "url": "/30-days-of-elm/images/sun.svg",
        "revision": "db0b253e3f91a52b9a0edc2e0c2225b2d09d3668.697a00c"
    },
    {
        "url": "/30-days-of-elm/images/uranus.svg",
        "revision": "c46dafd21ec2cde387f085f03bca03bfc38f5b34.697a00c"
    },
    {
        "url": "/30-days-of-elm/images/venus.svg",
        "revision": "293fc5cd204a2e650f155984c06192f27a6a7f74.697a00c"
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
