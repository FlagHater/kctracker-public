
[GtkTemplate (ui = "/me/flagmaster/kctracker/window.ui")]
//[GtkTemplate (ui = "/me/flagmaster/kctracker/gtk/map-widget.ui")]
public class Kctracker.Window : Adw.ApplicationWindow {

 //   [GtkCallback]
 //   private void on_searchbutton_click (){
 //       message ("asdsajkdsna action activated");
 //   }
 //
    public Window (Gtk.Application app) {
        Object (application: app);
    }

}
