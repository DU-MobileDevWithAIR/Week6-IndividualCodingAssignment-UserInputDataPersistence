/**
 * Created by jun on 10/16/14.
 */
package edu.du.mobile.model.vo {

    [Bindable]
    [RemoteClass(alias="edu.du.mobile.model.vo.Venue")]
    public class Venue {
        public var name:String;
        public var contactPhone:String;
        public var addressLine1:String;
        public var addressLine2:String;
    }
}
