<CODEGEN_FILENAME>I<WCF_SERVICE>.dbl</CODEGEN_FILENAME>
<REQUIRES_USERTOKEN>API_NAMESPACE</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>WCF_SERVICE</REQUIRES_USERTOKEN>
;;******************************************************************************
;; WARNING: THIS FILE WAS CODE GENERATED. CHANGES MAY BE LOST IF REGENERATED
;;******************************************************************************

import System
import System.Collections.Generic
import System.Runtime.Serialization
import System.ServiceModel
import System.Threading.Tasks
import AppDomainProtection
import AppDomainProtectionCore
import <API_NAMESPACE>

namespace <NAMESPACE>

    {ServiceContract(SessionMode = SessionMode.Required)}
    {SingletonBehaviorAttribute(^typeof(<WCF_SERVICE>))}
    {MarshaledAsyncBehavior}
    public partial interface I<WCF_SERVICE>

    endinterface

    {DataContract}
    {Serializable}
    public class <WCF_SERVICE>Response
        {DataMember}
        public property Status, MethodStatus
            method get
            endmethod
            method set
            endmethod
        endproperty
        {DataMember}
        public property ErrorMessage, String
            method get
            endmethod
            method set
            endmethod
        endproperty
    endclass

endnamespace
