<CODEGEN_FILENAME>I<WCF_SERVICE>_<StructureName>.dbl</CODEGEN_FILENAME>
<REQUIRES_USERTOKEN>WCF_SERVICE</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>API_NAMESPACE</REQUIRES_USERTOKEN>
<PROCESS_TEMPLATE>CRUDInterfaceBase</PROCESS_TEMPLATE>
;;******************************************************************************
;; WARNING: THIS FILE WAS CODE GENERATED. CHANGES MAY BE LOST IF REGENERATED
;;******************************************************************************

import System
import System.Collections.Generic
import System.Runtime.Serialization
import System.ServiceModel
import System.Threading.Tasks
import AppDomainProtection
import <API_NAMESPACE>

namespace <NAMESPACE>

    public partial interface I<WCF_SERVICE>

        {OperationContract}
        method Create<StructureName>, @Task<<WCF_SERVICE>Response>
            required in a<StructureName>, @<StructureName>
        endmethod

        <PRIMARY_KEY>
        {OperationContract}
        method Read<StructureName>, @Task<<StructureName>ReadResponse>
            <SEGMENT_LOOP>
            required in  a<SegmentName>, <SEGMENT_CSTYPE>
            </SEGMENT_LOOP>
        endmethod
        </PRIMARY_KEY>

        {OperationContract}
        method ReadAll<StructureName>s, @Task<<StructureName>ReadAllResponse>
        endmethod

        {OperationContract}
        method Update<StructureName>, @Task<<StructureName>UpdateResponse>
            required in a<StructureName>, @<StructureName>
            required in aGrfa, [#]byte
        endmethod

        {OperationContract}
        method Delete<StructureName>, @Task<<WCF_SERVICE>Response>
            required in aGrfa, [#]byte
        endmethod

        <PRIMARY_KEY>
        {OperationContract}
        method <StructureName>Exists, @Task<<WCF_SERVICE>Response>
            <SEGMENT_LOOP>
            required in a<SegmentName>, <SEGMENT_CSTYPE>
            </SEGMENT_LOOP>
        endmethod
        </PRIMARY_KEY>

    endinterface

    {DataContract}
    {Serializable}
    public class <StructureName>ReadResponse extends <WCF_SERVICE>Response
        {DataMember}
        public property Result, @<StructureName>
            method get
            endmethod
            method set
            endmethod
        endproperty
        {DataMember}
        public property Grfa, [#]byte
            method get
            endmethod
            method set
            endmethod
        endproperty
    endclass

    {DataContract}
    {Serializable}
    public class <StructureName>ReadAllResponse extends <WCF_SERVICE>Response
        {DataMember}
        public property Result, @List<<StructureName>>
            method get
            endmethod
            method set
            endmethod
        endproperty
    endclass

    {DataContract}
    {Serializable}
    public class <StructureName>UpdateResponse extends <WCF_SERVICE>Response
        {DataMember}
        public property Result, @<StructureName>
            method get
            endmethod
            method set
            endmethod
        endproperty
        {DataMember}
        public property Grfa, [#]byte
            method get
            endmethod
            method set
            endmethod
        endproperty
    endclass

endnamespace
