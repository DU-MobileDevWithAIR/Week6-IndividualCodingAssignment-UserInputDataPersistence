/**
 * Created by jun on 10/8/14.
 */
package edu.du.mobile.model
{

    import flash.events.EventDispatcher;

    import mx.collections.ArrayCollection;

    public class AppModel extends EventDispatcher
    {
        private static var _instance:AppModel;

        private var _locationCollection:ArrayCollection;

        private var _selectedLocation:Object;


        ///////////////////////
        public function AppModel( enforcer:SingletonEnforcer )
        {
            _init();
        }

        private function _init():void
        {
            _locationCollection = new ArrayCollection();
        }

        public static function getInstance():AppModel
        {
            if( _instance == null )
            {
                _instance = new AppModel( new SingletonEnforcer() );
            }

            return _instance;
        }


        //////////////////////////

        [Bindable]
        public function get locationCollection():ArrayCollection
        {
            return _locationCollection;
        }
        public function set locationCollection( value:ArrayCollection ):void
        {
            _locationCollection = value;
        }

        [Bindable]
        public function get selectedLocation():Object
        {
            return _selectedLocation;
        }
        public function set selectedLocation( value:Object ):void
        {
            _selectedLocation = value;
        }

    }
}
internal class SingletonEnforcer{}
