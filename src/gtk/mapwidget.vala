public class Kctracker.Mapwidget : Gtk.Box {
    public Shumate.SimpleMap shumateMap;
    public Shumate.MarkerLayer viewportLayer;
    public Shumate.RasterRenderer rasterRenderer;

    construct {
        orientation = Gtk.Orientation.HORIZONTAL;

        // Create the raster renderer
        rasterRenderer = new Shumate.RasterRenderer.full_from_url (
            "carto",
            "Carto Voyager",
            "MapSources: ©CARTO, © OpenStreetMap Contributers. Transit scheduling, geographic, and real-time data provided by permission of King County",
            "MULTIPLE SOURCES",
            0,
            20,
            256,
            Shumate.MapProjection.MERCATOR,
            "https://basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png"
        );

        // Create SimpleMap with the custom renderer
        shumateMap = new Shumate.SimpleMap() {
            vexpand = true,
            hexpand = true,
            map_source = rasterRenderer,
            show_zoom_buttons = false,
        };

        var viewport = shumateMap.get_viewport();
        viewport.set_location(47.606102, -122.254164);
        viewport.set_zoom_level(10);

        viewportLayer = new Shumate.MarkerLayer(viewport);

        var marker = new Markermaker();
        var markerArray = marker.marker_compiler();
        
        for (var i = 0; i < markerArray.length; i++) {
            viewportLayer.add_marker(markerArray.index(i));
        }

        shumateMap.add_overlay_layer(viewportLayer);
        append(shumateMap);
    }
}