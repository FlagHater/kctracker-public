using Soup;
using Json;
using GLib;
using Kctracker;
using Gtk;

public class Kctracker.Markermaker {

    public GLib.Array<Shumate.Marker> marker_compiler() throws GLib.Error {
        stdout.printf ("test");
        var kcjsonurl = "https://s3.amazonaws.com/kcm-alerts-realtime-prod/vehiclepositions_enhanced.json";
        var session = new Soup.Session();
        var message = new Soup.Message("GET", kcjsonurl);
        var response = session.send(message, null);
        // session.send_and_read(message);
        Json.Parser parser = new Json.Parser();
        // Reads the Glib.inputstream
        parser.load_from_stream(response);
        // Gets the entire json
        Json.Node node = parser.get_root ();   
        // Gets all the headers/keys inside the outmost layer of the json 
        Json.Object object = node.get_object();
        // Gets the array of everything inside of  "entity"
        var entityArray = object.get_array_member("entity");

        Json.Parser localParser = new Json.Parser();

        var resource_path = "/me/flagmaster/kctracker/gtk/routes.json";
        var resource = GLib.resources_lookup_data(resource_path, GLib.ResourceLookupFlags.NONE);
        localParser.load_from_data((string)resource.get_data());

        Json.Builder jsonBuilder = new Json.Builder ();
        jsonBuilder.begin_object();



        Json.Node localNode = localParser.get_root();

        GLib.Array<Shumate.Marker> markerList = new GLib.Array<Shumate.Marker>();

        for (int i = 0; i < entityArray.get_length(); i++) {

            // Gets element i inside of entityArray
            var entityPostition = entityArray.get_element(i);
            // Gets the object from the current position
            var entityObject = entityPostition.get_object();
            // Gets string value of "id"
            var id = entityObject.get_string_member("id");
            //Gets Coordinates
            // Assigns the vehicle node 
            var outerVehicleNode = entityObject.get_member("vehicle");
            // Gets the outer vehicle node object
            var outerVehicleObject = outerVehicleNode.get_object();
            // Gets inner vehicle and makes it a node 
            var innerVehicleNode = outerVehicleObject.get_member("position");
            var innerVehicleObject = innerVehicleNode.get_object();
            var latitude = innerVehicleObject.get_double_member("latitude");
            var longitude = innerVehicleObject.get_double_member("longitude");


            var tripNode = outerVehicleObject.get_member("trip");
            var tripObject = tripNode.get_object();
            var tripID = tripObject.get_string_member("trip_id");
            var routeID = tripObject.get_string_member("route_id");

            // GLib.message(tripID);
            // GLib.message(routeID);




            // PRINTS EVERYTHING OUT
            // GLib.message ("ID: " + id);
            // GLib.message ("latitude: " + latitude.to_string());
            // GLib.message ("longitude: " + longitude.to_string());
            // Create a new Gtk.Image instance
            var image = new Gtk.Image();
            image.set_from_icon_name("compass-symbolic");
            // CREATES MARKER POINT
            var marker = new Shumate.Marker();
            marker.set_location(latitude, longitude);
            marker.set_child(image);
            marker.set_selectable(true);


            var root_array = localNode.get_array();
            string routeInfo = "";
            string routeDescription = "";
            string routeType = "";
            
            
            // Loop through the array to find matching route_id. Assigns the marker's name (for css) to either rapid or metro bus.
            for (var a = 0; a < root_array.get_length(); a++) {
                var route_object = root_array.get_element(a).get_object();
                if ((route_object.get_int_member("route_id")).to_string("%u") == routeID) {
                    routeInfo = route_object.get_string_member("route_short_name");

                    if (routeInfo.contains("Line")) {
                        image.add_css_class("Rapid");
                        routeType = "Rapid Ride";   
                    } 
                    else if (routeInfo[0].to_string() == "5" && routeInfo.length == 3) {
                        image.add_css_class("Express");
                        routeType = "Express Route";
                    }
                        

                    else {
                        image.add_css_class("Metro");
                        routeType = "Metro Bus";
                        
                    }
                    routeDescription = route_object.get_string_member("route_desc");
                }
            }



            var gesture = new Gtk.GestureClick();

            marker.add_controller(gesture);


            gesture.pressed.connect((n, x, y) => {
                var popover = new Gtk.Popover();
                var box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);

                // Title/Route Number
                var route_label = new Gtk.Label(routeInfo);
                route_label.add_css_class("title-1");
                route_label.add_css_class("bold");

                var route_type_label = new Gtk.Label(routeType);
                route_type_label.add_css_class("title-3");


                if (routeType == "Express Route"){
                    // route_label.add_css_class("Rapid");
                    route_type_label.add_css_class("Express");
                }
                else if (routeType == "Rapid Ride"){
                    // route_label.add_css_class("Rapid");
                    route_type_label.add_css_class("Rapid");
                }

                
                else{
                    route_type_label.add_css_class("Metro");
                }

                var routeDescriptionCaption = new Gtk.Label(routeDescription);
                routeDescriptionCaption.add_css_class("title-5");



                box.append(route_label);
                box.append(route_type_label);
                box.append(routeDescriptionCaption);

                popover.set_child(box);
                popover.set_parent(marker);
                popover.popup();
            });

            jsonBuilder.set_member_name(routeInfo);
            jsonBuilder.begin_object();
            jsonBuilder.set_member_name(tripID);
            jsonBuilder.begin_object();
            jsonBuilder.set_member_name("latitude");
            jsonBuilder.add_double_value(latitude);
            jsonBuilder.set_member_name("longitude");
            jsonBuilder.add_double_value(longitude);
            jsonBuilder.end_object();
            jsonBuilder.end_object();
            markerList.append_val(marker);
        }

        return markerList;
        // var objectA = icon.to_string("%u");
        // GLib.message(objectA);
        // Loop though GLib.List 
        // id.foreach(a => {GLib.message (@"$a\n");});    
    }
}
// var json_string = Json.to_string(node, true);
// CONVERTS THE NODE TO A STRING 
