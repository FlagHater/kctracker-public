kctracker_sources = [
  'main.vala',
  'application.vala',
  'window.vala',
  'gtk/mapwidget.vala',
  'gtk/markers.vala',
  'gtk/markermaker.vala'
]

kctracker_deps = [
  config_dep,
  dependency('gtk4'),
  dependency('libadwaita-1', version: '>= 1.4'),
  dependency('shumate-1.0'),
  dependency('libsoup-3.0'),
  dependency('json-glib-1.0')
]

kctracker_sources += gnome.compile_resources('kctracker-resources',
  'kctracker.gresource.xml',
  c_name: 'kctracker',
  source_dir: ['../src', '../data']  # Add this line to include both directories
)

executable('kctracker', kctracker_sources,
  dependencies: kctracker_deps,
  include_directories: config_inc,
       install: true,
)