'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "/manifest.json": "e84956a5f9ed0f157efb099a928923eb",
"/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"/assets/AssetManifest.json": "eca79b7671996c553eaee20b56baeeaa",
"/assets/LICENSE": "c834fbc123c09d8f5e5f8825090ca8a1",
"/assets/assets/parking-hypermarket.jpg": "4849f52f776d7b3853a862ff5887b031",
"/assets/assets/place-image.png": "c33812e888708344785de30b2f28fd96",
"/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"/assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"/assets/FontManifest.json": "01700ba55b08a6141f33e168c4a6c22f",
"/main.dart.js": "ad180d82dcb430cb6507ef1bee62555f",
"/index.html": "ccecc3c32da4797b0a2a50fd66b9d6bf"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
