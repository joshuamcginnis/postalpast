Geocoder.configure(
  # geocoding service timeout (secs)
  timeout: 3,

  # name of geocoding service (symbol)
  lookup: :nominatim,

  # name of IP address geocoding service (symbol)
  # ip_lookup: :ipinfo_io,

  # ISO-639 language code
  language: :en,

  # use HTTPS for lookup requests? (if supported)
  use_https: true,

  # HTTP proxy server (user:pass@host:port)
  # http_proxy: nil,

  # HTTPS proxy server (user:pass@host:port)
  # https_proxy: nil,

  # API key for geocoding service
  # api_key: nil,

  # cache object (must respond to #[], #[]=, and #del)
  # cache: nil,

  # Exceptions that should not be rescued by default
  # (if you want to implement custom error handling);
  # supports SocketError and Timeout::Error
  # always_raise: [],

  # Calculation options
  # :km for kilometers or :mi for miles
  # units: :mi,

  # :spherical or :linear
  # distances: :linear

  # Cache configuration
  # cache_options: {
  #   expiration: 2.days,
  #   prefix: 'geocoder:'
  # }
)
