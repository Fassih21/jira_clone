# Puma configuration for development (Windows) and production (Linux)

# Threads
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }.to_i
threads min_threads_count, max_threads_count

# Port to listen on
port ENV.fetch("PORT") { 3000 }

# Environment
environment ENV.fetch("RAILS_ENV") { "development" }

# Workers (cluster mode) — only on non-Windows platforms
unless Gem.win_platform?
  workers ENV.fetch("WEB_CONCURRENCY") { 2 }

  # Preload application for copy-on-write
  preload_app!
end

# Restart plugin
plugin :tmp_restart

# Solid Queue support if enabled
plugin :solid_queue if ENV["SOLID_QUEUE_IN_PUMA"]

# PID file for process managers (optional)
pidfile ENV["PIDFILE"] if ENV["PIDFILE"]
