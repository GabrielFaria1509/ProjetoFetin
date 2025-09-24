const CACHE_NAME = 'tism-v1.0.0';
const STATIC_CACHE = 'tism-static-v1.0.0';
const DYNAMIC_CACHE = 'tism-dynamic-v1.0.0';
const API_CACHE = 'tism-api-v1.0.0';

// Recursos críticos para precache
const PRECACHE_RESOURCES = [
  '/',
  '/index.html',
  '/main.dart.js',
  '/flutter.js',
  '/flutter_service_worker.js',
  '/manifest.json',
  '/favicon.png',
  '/icons/Icon-192.png',
  '/icons/Icon-512.png',
  '/assets/images/TISM-logo.png',
  '/assets/images/TISM-heart.png',
  // Fontes críticas
  'https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap',
];

// URLs da API para cache
const API_URLS = [
  '/api/posts',
  '/api/user/profile',
  '/api/diary/entries',
];

// Estratégias de cache
const CACHE_STRATEGIES = {
  CACHE_FIRST: 'cache-first',
  NETWORK_FIRST: 'network-first',
  STALE_WHILE_REVALIDATE: 'stale-while-revalidate',
  NETWORK_ONLY: 'network-only',
  CACHE_ONLY: 'cache-only'
};

// Install event - Precache recursos críticos
self.addEventListener('install', event => {
  console.log('[SW] Installing...');
  event.waitUntil(
    Promise.all([
      caches.open(STATIC_CACHE).then(cache => {
        console.log('[SW] Precaching static resources');
        return cache.addAll(PRECACHE_RESOURCES);
      }),
      self.skipWaiting()
    ])
  );
});

// Activate event - Limpar caches antigos
self.addEventListener('activate', event => {
  console.log('[SW] Activating...');
  event.waitUntil(
    Promise.all([
      caches.keys().then(cacheNames => {
        return Promise.all(
          cacheNames.map(cacheName => {
            if (cacheName !== STATIC_CACHE && 
                cacheName !== DYNAMIC_CACHE && 
                cacheName !== API_CACHE) {
              console.log('[SW] Deleting old cache:', cacheName);
              return caches.delete(cacheName);
            }
          })
        );
      }),
      self.clients.claim()
    ])
  );
});

// Fetch event - Estratégias de cache inteligentes
self.addEventListener('fetch', event => {
  const { request } = event;
  const url = new URL(request.url);

  // Ignorar requests não-GET
  if (request.method !== 'GET') return;

  // Estratégia para diferentes tipos de recursos
  if (isStaticResource(url)) {
    event.respondWith(cacheFirst(request, STATIC_CACHE));
  } else if (isAPIRequest(url)) {
    event.respondWith(networkFirst(request, API_CACHE));
  } else if (isImageRequest(url)) {
    event.respondWith(staleWhileRevalidate(request, DYNAMIC_CACHE));
  } else {
    event.respondWith(networkFirst(request, DYNAMIC_CACHE));
  }
});

// Cache First - Para recursos estáticos
async function cacheFirst(request, cacheName) {
  try {
    const cache = await caches.open(cacheName);
    const cachedResponse = await cache.match(request);
    
    if (cachedResponse) {
      return cachedResponse;
    }
    
    const networkResponse = await fetch(request);
    if (networkResponse.ok) {
      cache.put(request, networkResponse.clone());
    }
    return networkResponse;
  } catch (error) {
    console.error('[SW] Cache first failed:', error);
    return getOfflineFallback(request);
  }
}

// Network First - Para API e conteúdo dinâmico
async function networkFirst(request, cacheName) {
  try {
    const networkResponse = await fetch(request);
    if (networkResponse.ok) {
      const cache = await caches.open(cacheName);
      cache.put(request, networkResponse.clone());
    }
    return networkResponse;
  } catch (error) {
    console.log('[SW] Network failed, trying cache:', request.url);
    const cache = await caches.open(cacheName);
    const cachedResponse = await cache.match(request);
    
    if (cachedResponse) {
      return cachedResponse;
    }
    
    return getOfflineFallback(request);
  }
}

// Stale While Revalidate - Para imagens e recursos não críticos
async function staleWhileRevalidate(request, cacheName) {
  const cache = await caches.open(cacheName);
  const cachedResponse = await cache.match(request);
  
  const fetchPromise = fetch(request).then(networkResponse => {
    if (networkResponse.ok) {
      cache.put(request, networkResponse.clone());
    }
    return networkResponse;
  }).catch(() => cachedResponse);
  
  return cachedResponse || fetchPromise;
}

// Verificadores de tipo de recurso
function isStaticResource(url) {
  return url.pathname.includes('.js') || 
         url.pathname.includes('.css') || 
         url.pathname.includes('.woff') ||
         url.pathname.includes('.woff2') ||
         url.pathname === '/' ||
         url.pathname === '/index.html';
}

function isAPIRequest(url) {
  return url.pathname.startsWith('/api/') || 
         url.hostname.includes('api.') ||
         API_URLS.some(apiUrl => url.pathname.startsWith(apiUrl));
}

function isImageRequest(url) {
  return url.pathname.includes('.png') || 
         url.pathname.includes('.jpg') || 
         url.pathname.includes('.jpeg') ||
         url.pathname.includes('.gif') ||
         url.pathname.includes('.webp') ||
         url.pathname.includes('.svg');
}

// Fallbacks offline
function getOfflineFallback(request) {
  const url = new URL(request.url);
  
  if (request.destination === 'document') {
    return caches.match('/offline.html') || 
           caches.match('/') || 
           new Response('Offline - TISM não está disponível', {
             status: 503,
             headers: { 'Content-Type': 'text/plain' }
           });
  }
  
  if (isImageRequest(url)) {
    return caches.match('/icons/Icon-192.png') ||
           new Response('', { status: 404 });
  }
  
  return new Response('Recurso não disponível offline', {
    status: 404,
    headers: { 'Content-Type': 'text/plain' }
  });
}

// Background Sync para dados offline
self.addEventListener('sync', event => {
  console.log('[SW] Background sync:', event.tag);
  
  if (event.tag === 'diary-sync') {
    event.waitUntil(syncDiaryEntries());
  } else if (event.tag === 'forum-sync') {
    event.waitUntil(syncForumPosts());
  }
});

// Sincronização de entradas do diário
async function syncDiaryEntries() {
  try {
    const pendingEntries = await getStoredData('pending-diary-entries');
    if (pendingEntries && pendingEntries.length > 0) {
      for (const entry of pendingEntries) {
        await fetch('/api/diary/entries', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(entry)
        });
      }
      await clearStoredData('pending-diary-entries');
      console.log('[SW] Diary entries synced successfully');
    }
  } catch (error) {
    console.error('[SW] Diary sync failed:', error);
  }
}

// Sincronização de posts do fórum
async function syncForumPosts() {
  try {
    const pendingPosts = await getStoredData('pending-forum-posts');
    if (pendingPosts && pendingPosts.length > 0) {
      for (const post of pendingPosts) {
        await fetch('/api/forum/posts', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(post)
        });
      }
      await clearStoredData('pending-forum-posts');
      console.log('[SW] Forum posts synced successfully');
    }
  } catch (error) {
    console.error('[SW] Forum sync failed:', error);
  }
}

// Push notifications
self.addEventListener('push', event => {
  console.log('[SW] Push received:', event);
  
  const options = {
    body: event.data ? event.data.text() : 'Nova notificação do TISM',
    icon: '/icons/Icon-192.png',
    badge: '/icons/Icon-96.png',
    vibrate: [200, 100, 200],
    data: {
      dateOfArrival: Date.now(),
      primaryKey: 1
    },
    actions: [
      {
        action: 'explore',
        title: 'Ver no app',
        icon: '/icons/explore.png'
      },
      {
        action: 'close',
        title: 'Fechar',
        icon: '/icons/close.png'
      }
    ]
  };
  
  event.waitUntil(
    self.registration.showNotification('TISM', options)
  );
});

// Clique em notificação
self.addEventListener('notificationclick', event => {
  console.log('[SW] Notification click:', event);
  
  event.notification.close();
  
  if (event.action === 'explore') {
    event.waitUntil(
      clients.openWindow('/')
    );
  }
});

// Utilitários para IndexedDB
async function getStoredData(key) {
  return new Promise((resolve, reject) => {
    const request = indexedDB.open('tism-offline-db', 1);
    
    request.onsuccess = () => {
      const db = request.result;
      const transaction = db.transaction(['offline-data'], 'readonly');
      const store = transaction.objectStore('offline-data');
      const getRequest = store.get(key);
      
      getRequest.onsuccess = () => resolve(getRequest.result?.data);
      getRequest.onerror = () => reject(getRequest.error);
    };
    
    request.onerror = () => reject(request.error);
  });
}

async function clearStoredData(key) {
  return new Promise((resolve, reject) => {
    const request = indexedDB.open('tism-offline-db', 1);
    
    request.onsuccess = () => {
      const db = request.result;
      const transaction = db.transaction(['offline-data'], 'readwrite');
      const store = transaction.objectStore('offline-data');
      const deleteRequest = store.delete(key);
      
      deleteRequest.onsuccess = () => resolve();
      deleteRequest.onerror = () => reject(deleteRequest.error);
    };
    
    request.onerror = () => reject(request.error);
  });
}

console.log('[SW] Service Worker loaded successfully');