export function radFetch(url, options = {}) {
  const method = (options.method || 'GET').toUpperCase();
  const isGetRequest = method === 'GET';

  const defaultHeaders = {
    'X-Requested-With': 'XMLHttpRequest'
  };

  if (!isGetRequest) {
    const csrfToken = document.querySelector('[name="csrf-token"]')?.content;
    if (csrfToken) {
      defaultHeaders['X-CSRF-Token'] = csrfToken;
    }
  }

  const headers = { ...defaultHeaders, ...(options.headers || {}) };

  let body = options.body;

  if (body !== undefined && body !== null) {
    const bodyIsAString = Object.prototype.toString.call(body) === '[object String]';
    const hasContentType = headers['Content-Type'] !== undefined;

    if (!bodyIsAString && !hasContentType) {
      headers['Content-Type'] = 'application/json';
    }

    const contentTypeIsJson = headers['Content-Type'] === 'application/json';
    if (contentTypeIsJson && !bodyIsAString) {
      body = JSON.stringify(body);
    }
  }

  const fetchOptions = {
    ...options,
    method,
    headers,
    body
  };

  return fetch(url, fetchOptions);
}

export function get(url, options = {}) {
  return radFetch(url, { ...options, method: 'GET' });
}

export function post(url, options = {}) {
  return radFetch(url, { ...options, method: 'POST' });
}

export function put(url, options = {}) {
  return radFetch(url, { ...options, method: 'PUT' });
}

export function patch(url, options = {}) {
  return radFetch(url, { ...options, method: 'PATCH' });
}

export function del(url, options = {}) {
  return radFetch(url, { ...options, method: 'DELETE' });
}
