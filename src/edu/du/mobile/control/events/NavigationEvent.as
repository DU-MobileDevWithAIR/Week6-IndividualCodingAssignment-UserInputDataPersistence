/**
 * Created by jun on 10/1/14.
 */
package edu.du.mobile.control.events
{
    import flash.events.Event;

    public class NavigationEvent extends Event
    {
        public static const GOTO_SCREEN:String = "gotoScreen";

        public var screenName:String;

        public function NavigationEvent( type:String, screenName:String, bubbles:Boolean = true, cancelable:Boolean = false )
        {
            super(type, bubbles, cancelable);
            this.screenName = screenName;
        }

        override public function clone():Event
        {
            return new NavigationEvent( type, screenName, bubbles, cancelable );
        }
    }
}
