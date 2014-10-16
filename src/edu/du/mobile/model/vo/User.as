/**
 * Created by jun on 10/16/14.
 */
package edu.du.mobile.model.vo {
    [Bindable]
    [RemoteClass(alias="edu.du.mobile.model.vo.User")]
    public class User {
        public var username:String;
        public var email:String;
        public var password:String;
        public var gender:String;
    }
}
