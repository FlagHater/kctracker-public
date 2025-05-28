
using Gtk;
public class Kctracker.Application : Adw.Application {
    public Application () {
        Object (
            application_id: "me.flagmaster.kctracker",
            flags: ApplicationFlags.DEFAULT_FLAGS
        );
    }

    construct {
        ActionEntry[] action_entries = {
            { "about", this.on_about_action },
            { "preferences", this.on_preferences_action },
            { "refresh", this.refresh },
            { "quit", this.quit }
        };
        this.add_action_entries (action_entries, this);
        this.set_accels_for_action ("app.quit", {"<primary>q"});
        this.set_accels_for_action ("app.refresh", {"<primary>r"});

    }

    public override void activate () {
        base.activate ();
        var win = new Kctracker.Window (this); // x = y ?? z; THIS IS: states x is assigned y's value, unless y is null, in which case it is assigned z's value.
        var map = new Kctracker.Mapwidget();
        
        
        // Aided by Zed AI
        var css_provider = new Gtk.CssProvider();
        css_provider.load_from_resource("/me/flagmaster/kctracker/iconColours.css");
       Gtk.StyleContext.add_provider_for_display(
       Gdk.Display.get_default(),
          css_provider,
          Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
            );
        
        var adwToolbarView = win.get_content() as Adw.ToolbarView;

        adwToolbarView.set_content(map);

        win.present (); //SHOWS THE APP

    }

    private void on_about_action () {
        string[] developers = { "Flagmaster" };
        var about = new Adw.AboutDialog () {
            application_name = "kctracker",
            application_icon = "me.flagmaster.kctracker",
            developer_name = "Flagmaster",
            translator_credits = _("translator-credits"),
            version = "1.0.1",
            developers = developers,
            copyright = "Mozilla Public License Version 2.0",
        };

        about.present (this.active_window);
    }

    private void on_preferences_action () {

    }

    // Aided by Llama 3.3
    private void refresh () {
        var win = this.active_window as Kctracker.Window;
        var map = new Kctracker.Mapwidget();

        var adwToolbarView = win.get_content() as Adw.ToolbarView;

        adwToolbarView.set_content(map);

    }
}
