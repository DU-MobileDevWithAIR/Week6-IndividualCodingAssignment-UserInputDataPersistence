/**
 * Created by jun on 10/8/14.
 */
package edu.du.mobile.control.events
{
    import flash.events.Event;

    public class VenueDataEvent extends Event
    {
        public static const GET_VENUES:String = "getVenues";

        public var searchString:String;

        public function VenueDataEvent( type:String, searchString:String='', bubbles:Boolean = true, cancelable:Boolean = false )
        {
            super(type, bubbles, cancelable);
            this.searchString = searchString;
        }

        override public function clone():Event
        {
            return new VenueDataEvent( type, searchString, bubbles, cancelable );
        }
    }
}
