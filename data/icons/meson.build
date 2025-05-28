application_id = 'me.flagmaster.kctracker'

scalable_dir = 'hicolor' / 'scalable' / 'apps'
install_data(
  scalable_dir / ('@0@.svg').format(application_id),
  install_dir: get_option('datadir') / 'icons' / scalable_dir
)

symbolic_dir = 'hicolor' / 'symbolic' / 'apps'
install_data(
  symbolic_dir / ('@0@-symbolic.svg').format(application_id),
  install_dir: get_option('datadir') / 'icons' / symbolic_dir
)

# By Claude 3.5 Sonnet
# Add this new section for the circle icon
install_data(
  'compass-symbolic.svg',  # Make sure this matches your SVG file name
  install_dir: get_option('datadir') / 'icons' / 'hicolor' / 'symbolic' / 'apps'
)