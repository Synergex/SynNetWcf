<CODEGEN_FILENAME><StructureName>Wrapper.dbl</CODEGEN_FILENAME>
<PROCESS_TEMPLATE>DataUtils</PROCESS_TEMPLATE>
;;******************************************************************************
;; WARNING: THIS FILE WAS CODE GENERATED. CHANGES MAY BE LOST IF REGENERATED
;;******************************************************************************

import System
import System.Runtime.Serialization

namespace <NAMESPACE>

    .include "<STRUCTURE_NOALIAS>" repository, structure="str<StructureName>", end

    {Serializable}
    public class <StructureName>Wrapper implements ISerializable

        internal m<StructureName>, str<StructureName>

        public method <StructureName>Wrapper
        proc
            init m<StructureName>
        endmethod

        public method <StructureName>Wrapper
            info, @SerializationInfo
            context, StreamingContext
            this()
        proc
            data myType = ^typeof([#]byte)
            m<StructureName> = (a)([#]byte)info.GetValue("Record",myType)
        endmethod

        public method GetObjectData, void
            info, @SerializationInfo 
            context, StreamingContext 
        proc
            data bytes, [#]byte, (a)m<StructureName>
            info.AddValue("Record",bytes)
        endmethod
        
        public property Record, String
            method get
            proc
                mreturn (String)m<StructureName>
            endmethod
            method set
            proc
                m<StructureName> = value
            endmethod
        endproperty

        <FIELD_LOOP>
        ;;; <summary>
        ;;; <FIELD_DESC> (<FIELD_NAME>, <FIELD_SPEC>)
        ;;; </summary>
        public property <FieldNetName>, <FIELD_SNTYPE>
            method get
            proc
                <IF ALPHA>
                mreturn %atrim(m<StructureName>.<field_name>)
                </IF ALPHA>
                <IF DECIMAL>
                mreturn m<StructureName>.<field_name>
                </IF DECIMAL>
                <IF DATE_NULLABLE>
                <IF DATE>
                mreturn DataUtils.NullableDateFromDecimal(m<StructureName>.<field_name>)
                </IF DATE>
                <IF TIME>
                mreturn DataUtils.NullableTimeFromDecimal(m<StructureName>.<field_name>)
                </IF TIME>
                <ELSE>
                <IF DATE>
                mreturn DataUtils.DateFromDecimal(m<StructureName>.<field_name>)
                </IF DATE>
                <IF TIME>
                mreturn DataUtils.TimeFromDecimal(m<StructureName>.<field_name>)
                </IF TIME>
                </IF DATE_NULLABLE>
                <IF INTEGER>
                mreturn m<StructureName>.<field_name>
                </IF INTEGER>
                <IF USER>
                mreturn m<StructureName>.<field_name>
                </IF USER>
            endmethod
            method set
            proc
                <IF ALPHA>
                m<StructureName>.<field_name> = value
                </IF ALPHA>
                <IF DECIMAL>
                m<StructureName>.<field_name> = value
                </IF DECIMAL>
                <IF DATE_NULLABLE>
                <IF DATE_YYYYMMDD>
                m<StructureName>.<field_name> = DataUtils.D8FromNullableDate(value)
                </IF>
                <IF DATE_YYMMDD>
                m<StructureName>.<field_name> = DataUtils.D6FromNullableDate(value)
                </IF>
                <IF TIME_HHMMSS>
                m<StructureName>.<field_name> = DataUtils.D6FromNullableTime(value)
                </IF>
                <IF TIME_HHMM>
                m<StructureName>.<field_name> = DataUtils.D4FromNullableTime(value)
                </IF>
                <ELSE>
                <IF DATE_YYYYMMDD>
                m<StructureName>.<field_name> = DataUtils.D8FromDate(value)
                </IF>
                <IF DATE_YYMMDD>
                m<StructureName>.<field_name> = DataUtils.D6FromDate(value)
                </IF>
                <IF TIME_HHMMSS>
                m<StructureName>.<field_name> = DataUtils.D6FromTime(value)
                </IF>
                <IF TIME_HHMM>
                m<StructureName>.<field_name> = DataUtils.D4FromTime(value)
                </IF>
                </IF DATE_NULLABLE>
                <IF INTEGER>
                m<StructureName>.<field_name> = value
                </IF INTEGER>
                <IF USER>
                m<StructureName>.<field_name> = value
                </IF USER>
            endmethod
        endproperty

        </FIELD_LOOP>
    endclass

endnamespace
