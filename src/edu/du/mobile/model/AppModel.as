/**
 * Created by jun on 10/8/14.
 */
package edu.du.mobile.model
{

import edu.du.mobile.model.vo.Favorite;
import edu.du.mobile.model.vo.User;
import edu.du.mobile.model.vo.Venue;

import flash.events.Event;

import flash.events.EventDispatcher;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.utils.describeType;
import mx.collections.ArrayCollection;

    public class AppModel extends EventDispatcher {
        private static var _instance:AppModel;

        private var _userCollection:ArrayCollection;

        private var _favoritesCollection:ArrayCollection;

        private var _venuesCollection:ArrayCollection;

        private var _selectedVenue:Venue;

        private var _loggedInUser:User;

        private var _userDB:File = File.applicationStorageDirectory.resolvePath("users.data");
        private var _favoritesDB:File = File.applicationStorageDirectory.resolvePath("favorites.data");

        ///////////////////////
        public function AppModel(enforcer:SingletonEnforcer) {
            _init();
        }

        private function _init():void {
            trace('appmodel was init');
            var fileStream:FileStream = new FileStream();

            _venuesCollection = new ArrayCollection();

            if (_userDB.exists) {
                fileStream.open(_userDB, FileMode.READ);
                _userCollection = fileStream.readObject() as ArrayCollection;
            }
            else {
                _userCollection = new ArrayCollection();
            }

            // do the same for favorites...
            var favsStream:FileStream = new FileStream();
            if (_favoritesDB.exists) {
                favsStream.open(_favoritesDB, FileMode.READ);
                _favoritesCollection = favsStream.readObject() as ArrayCollection;
            }
            else {
                _favoritesCollection = new ArrayCollection();
            }

        }
        // I just added this so I could test without recompiling so often.
        public function manageFiles(toDelete) {
            if(toDelete == 'users' && _userDB.exists) {
                _userDB.deleteFile();
                trace('users file deleted');
            }
            if(toDelete == 'favs' && _favoritesDB.exists) {
                _favoritesDB.deleteFile();
                trace('favs file deleted');
            }
        }
        public static function getInstance():AppModel {
            if (_instance == null) {
                _instance = new AppModel(new SingletonEnforcer());
            }

            return _instance;
        }

        public function addUserToCollection(user:User):void {
            _userCollection.addItem(user);
            _updateFile(_userDB, _userCollection);
            _loggedInUser = user;
            // force login.
        }

        public function addFavoriteToCollection(favorite:Favorite):void {
            _favoritesCollection.addItem(favorite);
            _updateFile(_favoritesDB, _favoritesCollection);
        }

        public function removeFavoriteFromCollection(favorite:Favorite) {
            var itemToRemove = null;
            for(var i:Object in _favoritesCollection) {
                if(_favoritesCollection[i].username == favorite.username && _favoritesCollection[i].venue == favorite.venue) {
                    itemToRemove = _favoritesCollection[i];
                }
            }
            _favoritesCollection.removeItem(_favoritesCollection[i]);
            _updateFile(_favoritesDB, _favoritesCollection);
        }

        public function isUserFavorite(favorite:Favorite) {
            for(var i:Object in _favoritesCollection) {
                if(_favoritesCollection[i].username == favorite.username && _favoritesCollection[i].venue == favorite.venue) {
                    return true;
                }
            }
            return false;

        }
        private function _updateFile( fileToUpdate:File, dataToWrite:Object):void
        {
            // TO-DONE: Use a FileStream to update the _userDB with a writeObject( userCollection ) call.
            /*
            var getStructure = describeType(dataToWrite);
            var classParams:Array = getStructure.@name.toString().split("::");
            var properElementName = String(classParams[classParams.length-1]).toLowerCase();
            var xmlToAdd:XML = new XML("<"+properElementName+'></'+properElementName+'>');
            var variables:XMLList = getStructure.accessor;
            for each(var variable:XML in variables) {
                trace('User Object ' + variable.@name + " = " + dataToWrite[variable.@name]);
                var nodeChild:XML = new XML();
                nodeChild = <{variable.@name}>{dataToWrite[variable.@name]}</{variable.@name}>;
                xmlToAdd.appendChild(nodeChild);
            }
            var fileStream:FileStream = new FileStream();
            fileStream.open(fileToUpdate, FileMode.WRITE);
            fileStream.writeObject(xmlToAdd.toString);
            trace('write to file' + xmlToAdd.toString); */
            /* Okay, whoops! Here was some almost functional overkill. I was trying to dynamically generate XML
             * nodes based on the properties of the class being passed. Completely unnecessary.
             */
            var fileStream:FileStream = new FileStream();
            fileStream.open(fileToUpdate, FileMode.WRITE);
            fileStream.writeObject(dataToWrite);

        }

        //////////////////////////

        public function get userCollection():ArrayCollection
        {
            return _userCollection;
        }

        public function get favoritesCollection():ArrayCollection
        {
            return _favoritesCollection;
        }


        [Bindable]
        public function get venuesCollection():ArrayCollection
        {
            return _venuesCollection;
        }
        public function set venuesCollection( value:ArrayCollection ):void
        {
            _venuesCollection = value;
        }

        [Bindable]
        public function get selectedVenue():Venue
        {
            return _selectedVenue;
        }
        public function set selectedVenue( value:Venue ):void
        {
            _selectedVenue = value;
        }

        [Bindable]
        public function get loggedInUser():User
        {
            return _loggedInUser;
        }
        public function set loggedInUser( value:User ):void
        {
            _loggedInUser = value;
        }
    }
}
internal class SingletonEnforcer{}
