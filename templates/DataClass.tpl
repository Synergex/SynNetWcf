<CODEGEN_FILENAME><StructureName>.dbl</CODEGEN_FILENAME>
<PROCESS_TEMPLATE>DataWrapper</PROCESS_TEMPLATE>
;;******************************************************************************
;; WARNING: THIS FILE WAS CODE GENERATED. CHANGES MAY BE LOST IF REGENERATED
;;******************************************************************************

import System
import System.Runtime.Serialization

namespace <NAMESPACE>

    {DataContract}
    {Serializable}
    public cls class <StructureName>

        {IgnoreDataMember}
        private wrapper, @<StructureName>Wrapper

        ;;; <summary>
        ;;; Construct an empty <StructureName> object
        ;;; </summary>
        public method <StructureName>
        proc
            wrapper = new <StructureName>Wrapper()
        endmethod

        ;;; <summary>
        ;;; Construct a <StructureName> object containing the data from a <STRUCTURE_NOALIAS> record
        ;;; </summary>
        ;;; <param name="a<StructureName>">Passed <StructureName> record</param>
        internal method <StructureName>
            required in a<StructureName>, String
            this()
        proc
            ;;Save the record
            wrapper.Record = a<StructureName>
        endmethod

        ;;; <summary>
        ;;; When WCF de-serializes data back into an object it uses "vudu" to construct an
        ;;; object in such a magical way that the constructors are not called!!! This causes
        ;;; problems because we need to instantiate our "wrapper" object. This method solves
        ;;; that problem by doing the "new" when deserialization takes place.
        ;;; </summary>
        {OnDeserializing}
        private method SetValuesOnDeserializing, void
            context, StreamingContext
        proc
            wrapper = new <StructureName>Wrapper()
        endmethod

        ;;; <summary>
        ;;; Provide a mechanism for INTERNAL code to be able to get the data as a record.
        ;;; </summary>
        internal property Record, String
            method get
            proc
                mreturn wrapper.Record
            endmethod
        endproperty

        ;;Expose the fields in the Synergy record as properties, using .NET types

        <FIELD_LOOP>
        ;;; <summary>
        ;;; <FIELD_DESC>
        ;;; </summary>
        {DataMember}
        public property <FieldNetName>, <FIELD_SNTYPE>
            method get
            proc
                mreturn wrapper.<FieldNetName>
            endmethod
            method set
            proc
                wrapper.<FieldNetName> = value
            endmethod
        endproperty

        </FIELD_LOOP>

    endclass

endnamespace
