'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "d41d8cd98f00b204e9800998ecf8427e",
"assets/AssetManifest.bin.json": "884108b9692f7ddc541ef5f02a7b131f",
"assets/AssetManifest.json": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/fonts/KAIU.TTF": "06626fe96f16a33672b0add18956488a",
"assets/assets/fonts/SANSHCBOLD.otf": "3963e54f53ada0430a7cc77b5ddbdd5f",
"assets/assets/fonts/SANSHCNORMAL.otf": "c5f9ac76bb6c9d667bc8dbb78c9af1f4",
"assets/assets/fonts/SourceHanSans-Normal.ttc": "48d8ff092449e21d733d142867172074",
"assets/assets/google_fonts/NotoSansTC-Black.otf": "63711c7566c02120f591c997c0f348f2",
"assets/assets/google_fonts/NotoSansTC-Bold.otf": "e65e211d51416cb1853b9cb5e713dddb",
"assets/assets/google_fonts/NotoSansTC-Light.otf": "c00e9b8596456a466cb704a6ffe75326",
"assets/assets/google_fonts/NotoSansTC-Medium.otf": "62c0f41ff6fc3b2273077d35a9c4766e",
"assets/assets/google_fonts/NotoSansTC-Regular.otf": "e7cd9c56373d6318f38e8abfc69ceb10",
"assets/assets/google_fonts/NotoSansTC-Thin.otf": "f264daf4f2f370bc1f0d4fd598d5df0b",
"assets/assets/google_fonts/OFL.txt": "2c309aad324a15dea6c68973d9bb7cf0",
"assets/assets/google_fonts/Roboto-Black.ttf": "301fe70f8f0f41c236317504ec05f820",
"assets/assets/google_fonts/Roboto-BlackItalic.ttf": "c470ca2b5b4f4437a3fe71b113a289a2",
"assets/assets/google_fonts/Roboto-Bold.ttf": "9ece5b48963bbc96309220952cda38aa",
"assets/assets/google_fonts/Roboto-BoldItalic.ttf": "0be9fa8f2863998d1e52c84165976880",
"assets/assets/google_fonts/Roboto-Italic.ttf": "465d1affcd03e9c6096f3313a47e0bf5",
"assets/assets/google_fonts/Roboto-Light.ttf": "6090d256d88dcd7f0244eaa4a3eafbba",
"assets/assets/google_fonts/Roboto-LightItalic.ttf": "2ffc058ddedacfeaa23542026c8108e2",
"assets/assets/google_fonts/Roboto-Medium.ttf": "b2d307df606f23cb14e6483039e2b7fa",
"assets/assets/google_fonts/Roboto-MediumItalic.ttf": "cabdb4a12e5de710afde298809306937",
"assets/assets/google_fonts/Roboto-Regular.ttf": "f36638c2135b71e5a623dca52b611173",
"assets/assets/google_fonts/Roboto-Thin.ttf": "4f0b85f5b601a405bdc7b23aad6d2a47",
"assets/assets/google_fonts/Roboto-ThinItalic.ttf": "7384da64612787e3662872e9d19cbc2d",
"assets/assets/images/7pc4rNCmEqo.jpg": "9fb7d8ccdad267e7dfcb6d6401db854e",
"assets/assets/images/anchk-concert.jpg": "7025b33629e01dd24e869f163178c993",
"assets/assets/images/anchk-logo%2520(1).PNG": "64e6d84b4ca011dd835fc15da67d5536",
"assets/assets/images/anchk-logo.PNG": "64e6d84b4ca011dd835fc15da67d5536",
"assets/assets/images/Anchk.png": "fd384611924ae693a5a9b2d5dd774b28",
"assets/assets/images/anchkorg-banner.png": "f718a4a3d800d806b022fb38425a3d73",
"assets/assets/images/apple_icon.svg": "0fc5c1431bfb7f3442754566f7730ac6",
"assets/assets/images/ArJj0pMqJls.jpg": "085cc90578dea9b4980822133b9a204f",
"assets/assets/images/b53oI2p-UrI.jpg": "3adb2fb114f45d8b907399ca634f59ee",
"assets/assets/images/blueBubbleBG.JPG": "e612aeb6ca4901d636051abc463fbc02",
"assets/assets/images/BountifulGraceChurch.jpg": "edc47601b204472d82cbb929c0c1fd6f",
"assets/assets/images/C2szYJuQymI.jpg": "69ee3dd491bf1e8a63f07d49b4bab8ad",
"assets/assets/images/cbtc-123.jpg": "465bbf0e369570113a2bcbc685015d57",
"assets/assets/images/cbtc-2x2.jpg": "6ba4c152f96c2a31fe0936fb8b8a8c89",
"assets/assets/images/cbtc-bj.jpg": "768f7d8f41f070bf5b886033ab4b34d8",
"assets/assets/images/cbtc.jpg": "34913a7a038968aa6aa911c8165ddf3f",
"assets/assets/images/cbtc.png": "58ee7210daed63ab68733c3e1b50866a",
"assets/assets/images/cbtc3.jpg": "d7721a3503089ce6f2def6d2b04d6b6e",
"assets/assets/images/CkjbpbRrRYo.jpg": "5f348c878e4c0a29e12089c8cb298e37",
"assets/assets/images/concert-wall-paper.jpg": "eec993e0eda900ed0314017866cd7943",
"assets/assets/images/C_&_M_A_Bountiful_Grace_Church.png": "53dafdf33ca8663aa1f6035397a9e292",
"assets/assets/images/divider-g8f3e8fda8_640.png": "413ae7cd93c7afea6f307e3c3b70ced2",
"assets/assets/images/emailQRcode.PNG": "7b459196f30278653628488081677cc7",
"assets/assets/images/gCwHitVRirI.jpg": "1233d0d1f979cb0625b5adea07f0e25b",
"assets/assets/images/github_icon.svg": "058a5b6f0e4bed8f73f20c466c1f705d",
"assets/assets/images/google_icon.svg": "ea735e62c31af39012853c932d74375a",
"assets/assets/images/heng_on_baptist_church.png": "20fc604a980cc7f379d108d6e1ef8432",
"assets/assets/images/Hp8P_CXOQ68.jpg": "ab7a55f77311bc8802108f466e112a09",
"assets/assets/images/IMG_1390.JPG": "8a3ac048bd9c4537e709d119da7fb8c8",
"assets/assets/images/IMG_1391.JPG": "13c26a17980bd6b71c4c191d57eb9ade",
"assets/assets/images/IMG_1392.JPG": "dad32cc1308a0180984f369ea4b0c463",
"assets/assets/images/IMG_1393.JPG": "c657bcb72e73d23e6a8f0df639c105d4",
"assets/assets/images/IMG_1394.JPG": "c8871602974310f5c5d547517355e73d",
"assets/assets/images/logo%25202.JPG": "a5981fa8bf70fa6e186908bc72852225",
"assets/assets/images/map.jpg": "34850d08357689996132c86821e119c0",
"assets/assets/images/mrIP.JPG": "75040b59ca9d193d81e5eb2c28a55f88",
"assets/assets/images/PHOTO-2021-10-30-10-22-55.jpg": "db821f5ec8a36b94d8ad734457a4ed52",
"assets/assets/images/preachers.jpg": "2f24e4fc2a7e45bf5599ff4e49f7bd30",
"assets/assets/images/preachers2.jpg": "c0eddaa59aacf75652367152813b00b4",
"assets/assets/images/slogon.JPG": "144febb70fa9608e790f94dccf39bcae",
"assets/assets/images/twitter_icon.svg": "775bb21be282839c826b043f5d57987d",
"assets/assets/images/UXP9sR0A0vQ.jpg": "f970499c47d448b4f61f066742bf9c31",
"assets/assets/images/ytbPlayBotton.png": "a29ebc43f2475b4c7235fad683f498d8",
"assets/FontManifest.json": "e6bab54e488a6cc5efb062170576b157",
"assets/fonts/MaterialIcons-Regular.otf": "c2e304d8325de93a971c219273be413c",
"assets/NOTICES": "57c0918529ee983251540cdacb21888b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/youtube_player_iframe/assets/player.html": "ea69af402f26127fa4991b611d4f2596",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon-32x32.png": "5a9ddb8f0f5fb630e3ed02d78ea09b95",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "0615ee05e29159780e88d8d2e3ca5c25",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "95f65a6ec35d41f79d9de1cbde93dd62",
"/": "95f65a6ec35d41f79d9de1cbde93dd62",
"main.dart.js": "7eb4810031fb3a0f7e97932e66ac28de",
"manifest.json": "4edd5e35fff3a661939359b2ec91f3ea",
"version.json": "a9e168978cc2962d4d5ab45dc74ff899"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
