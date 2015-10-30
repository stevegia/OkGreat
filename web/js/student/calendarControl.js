/**
 * Created by Steve on 10/22/2015.
 */

function initiate() {

    console.log("got here");

    var calendar = $("#calenderChart").calendar(
    {
        tmpl_path: "../tmpls/",
        events_source: function () { return [
            {
                "id": 0,
                "title": "Event 1",
                "url": "http://example.com",
                "class": "event-important",
                "start": 1445537644,
                "end": 1445537000
            }

        ]; }
    });



    $('.btn-group button[data-calendar-nav]').each(function() {
        var $this = $(this);
        $this.click(function() {
            calendar.navigate($this.data('calendar-nav'));
        });
    });

    $('.btn-group button[data-calendar-view]').each(function() {
        var $this = $(this);
        $this.click(function() {
            calendar.view($this.data('calendar-view'));
        });
    });
}
