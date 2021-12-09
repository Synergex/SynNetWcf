<CODEGEN_FILENAME><MAIN_CLASS>_<StructureName>.dbl</CODEGEN_FILENAME>
<REQUIRES_USERTOKEN>MAIN_CLASS</REQUIRES_USERTOKEN>
<PROCESS_TEMPLATE>MethodStatus</PROCESS_TEMPLATE>
<PROCESS_TEMPLATE>DataClass</PROCESS_TEMPLATE>
;;******************************************************************************
;; WARNING: THIS FILE WAS CODE GENERATED. CHANGES MAY BE LOST IF REGENERATED
;;******************************************************************************

import System.Collections.Generic
import Synergex.SynergyDE.Select

namespace <NAMESPACE>

    ;;; <summary>
    ;;; This partial class exposes the CRUD methods for <StructureName>.
    ;;; </summary>
    public partial class <MAIN_CLASS>

        ;;; <summary>
        ;;; Create a <StructureName> record
        ;;; </summary>
        ;;; <param name="a<StructureName>">Passed <StructureName> object (@<StructureName>)</param>
        ;;; <param name="aErrorMessage">Returned error message (blank if return value is MethodStatus.Success)</param>
        ;;; <returns>Method status</returns>
        public method Create<StructureName>, MethodStatus
            required in  a<StructureName>, @<StructureName>
            required out aErrorMessage, string
        proc
            data status = MethodStatus.Success
            data ch = 0

            try
            begin
                open(ch,u:i,"<FILE_NAME>")
                store(ch,a<StructureName>.Record)
                aErrorMessage = ""
            end
            catch (ex, @NoFileFoundException)
            begin
                status = MethodStatus.FatalError
                aErrorMessage = "File not found, check appSettings in Web.config or App.config!"
            end
            catch (ex, @DuplicateException)
            begin
                status = MethodStatus.Fail
                aErrorMessage = "Record already exists!"
            end
            catch (ex, @Exception)
            begin
                status = MethodStatus.FatalError
                aErrorMessage = String.Format("Error while creating record: {0}",ex.Message)
            end
            finally
            begin
                if (ch&&chopen(ch))
                    close ch
            end
            endtry

            mreturn status

        endmethod

        <PRIMARY_KEY>
        ;;; <summary>
        ;;; Read a <StructureName> record by primary key (<KEY_NAME>: <KEY_DESCRIPTION>)
        ;;; </summary>
        <SEGMENT_LOOP>
        ;;; <param name="a<SegmentName>">Passed <SEGMENT_DESC> (<SEGMENT_CSTYPE>)</param>
        </SEGMENT_LOOP>
        ;;; <param name="a<StructureName>">Returned <StructureName> object (@<StructureName>)</param>
        ;;; <param name="aGrfa">Returned GRFA data (byte array)</param>
        ;;; <param name="aErrorMessage">Returned error message (blank if return value is MethodStatus.Success)</param>
        ;;; <returns>Method status</returns>
        public method Read<StructureName>, MethodStatus
            <SEGMENT_LOOP>
            required in  a<SegmentName>, <SEGMENT_CSTYPE>
            </SEGMENT_LOOP>
            required out a<StructureName>, @<StructureName>
            required out aGrfa, [#]byte
            required out aErrorMessage, string
        proc
            data status = MethodStatus.Success
            data ch = 0

            data <structureName>Rec, str<StructureName>
            init <structureName>Rec
            <SEGMENT_LOOP>
            <IF DATE_YYYYMMDD>
            <structureName>Rec.<segment_name> = DataUtils.D8FromDate(a<SegmentName>)
            <ELSE>
            <structureName>Rec.<segment_name> = a<SegmentName>
            </IF DATE_YYYYMMDD>
            </SEGMENT_LOOP>

            try
            begin
                data grfa, a10
                open(ch=0,I:I,"<FILE_NAME>")
                read(ch,<structureName>Rec,%keyval(ch,<structureName>Rec,0),GETRFA:grfa)
                a<StructureName> = new <StructureName>((String)<structureName>Rec)
                aGrfa = grfa
                aErrorMessage = ""
            end
            catch (ex, @EndOfFileException)
            begin
                status = MethodStatus.Fail
                aErrorMessage = "Record not found!"
            end
            catch (ex, @KeyNotSameException)
            begin
                status = MethodStatus.Fail
                aErrorMessage = "Record not found!"
            end
            catch (ex, @Exception)
            begin
                status = MethodStatus.FatalError
                aErrorMessage = String.Format("Error while reading record: {0}",ex.Message)
            end
            finally
            begin
                if (ch&&chopen(ch))
                    close ch
            end
            endtry

            mreturn status

        endmethod
        </PRIMARY_KEY>

        ;;; <summary>
        ;;; Real all <StructureName> records
        ;;; </summary>
        ;;; <param name="a<StructureName>s">Returned collection of <StructureName> objects (@List<<StructureName>>)</param>
        ;;; <param name="aErrorMessage">Returned error message (blank if return value is MethodStatus.Success)</param>
        ;;; <returns>Method status</returns>
        public method ReadAll<StructureName>s, MethodStatus
            required out a<StructureName>s, @List<<StructureName>>
            required out aErrorMessage, string
        proc
            aErrorMessage = ""
            data status = MethodStatus.Success
            a<StructureName>s = new List<<StructureName>>()

            try
            begin
                data <structureName>Rec, str<StructureName>
                foreach <structureName>Rec in new Select(new From("<FILE_NAME>",<structureName>Rec))
                    a<StructureName>s.Add(new <StructureName>((String)<structureName>Rec))
            end
            catch (ex, @Exception)
            begin
                status = MethodStatus.FatalError
                aErrorMessage = String.Format("Error while reading records: {0}",ex.Message)
            end
            endtry

            mreturn status

        endmethod

        ;;; <summary>
        ;;; Update a <StructureName> record
        ;;; </summary>
        ;;; <param name="a<StructureName>">Passed/returned <StructureName> object (@<StructureName>)</param>
        ;;; <param name="aGrfa">Passed/returned GRFA</param>
        ;;; <param name="aErrorMessage">Returned error message (blank if return value is MethodStatus.Success)</param>
        ;;; <returns>Method status</returns>
        public method Update<StructureName>, MethodStatus
            required inout a<StructureName>, @<StructureName>
            required inout aGrfa, [#]byte
            required out aErrorMessage, string
        proc
            data status = MethodStatus.Success
            data ch = 0
            data <structureName>rec, str<StructureName>
            data grfa, a10

            try
            begin
                open(ch,u:i,"<FILE_NAME>")
                ;;Attempt to read the original record by GRFA to make sure that nobody else has modified or deleted it
                grfa = aGrfa
                read(ch,<structureName>rec,RFA:grfa,GETRFA:grfa)
                write(ch,a<StructureName>.Record,,GETRFA:grfa)
                aGrfa = grfa
                aErrorMessage = ""
            end
            catch (ex, @RecordNotSameException)
            begin
                ;;Failed to lock the original record, it must have been changed
                ;;by another process since this user obtained it. We'll return
                ;;the new record and it's GRFA to the user
                a<StructureName> = new <StructureName>((String)<structureName>rec)
                aGrfa = grfa
                status = MethodStatus.Fail
                aErrorMessage = "Record was changed by another user! A copy of the current record was returned."
            end
            catch (ex, @DuplicateException)
            begin
                status = MethodStatus.Fail
                aErrorMessage = "Duplicate key error!"
            end
            catch (ex, @Exception)
            begin
                status = MethodStatus.FatalError
                aErrorMessage = String.Format("Error while updating record: {0}",ex.Message)
            end
            finally
            begin
                if (ch&&chopen(ch))
                    close ch
            end
            endtry

            mreturn status

        endmethod

        ;;; <summary>
        ;;; Delete a <StructureName> record
        ;;; </summary>
        ;;; <param name="aGrfa">Passed GRFA (string)</param>
        ;;; <param name="aErrorMessage">Returned error message (blank if return value is MethodStatus.Success)</param>
        ;;; <returns>Method status</returns>
        public method Delete<StructureName>, MethodStatus
            required in aGrfa, [#]byte
            required out aErrorMessage, string
        proc
            data status = MethodStatus.Success
            data ch = 0
            data <structureName>rec, str<StructureName>
            data grfa, a10

            try
            begin
                open(ch,u:i,"<FILE_NAME>")
                ;;Attempt to read the original record by GRFA to make sure that nobody else has modified or deleted it
                grfa = aGrfa
                read(ch,<structureName>rec,RFA:grfa)
                delete(ch)
                aErrorMessage = ""
            end
            catch (ex, @RecordNotSameException)
            begin
                status = MethodStatus.Fail
                aErrorMessage = "The record was updated by another user!"
            end
            catch (ex, @Exception)
            begin
                status = MethodStatus.FatalError
                aErrorMessage = String.Format("Error while deleting record: {0}",ex.Message)
            end
            finally
            begin
                if (ch&&chopen(ch))
                    close ch
            end
            endtry

            mreturn status

        endmethod

        ;;; <summary>
        ;;; Determine if a <StructureName> record exists
        ;;; </summary>
        <PRIMARY_KEY>
        <SEGMENT_LOOP>
        ;;; <param name="a<SegmentName>">Passed <SEGMENT_DESC> (<SEGMENT_CSTYPE>)</param>
        </SEGMENT_LOOP>
        </PRIMARY_KEY>
        ;;; <param name="aErrorMessage">Returned error message (blank if return value is MethodStatus.Success)</param>
        ;;; <returns>Method status</returns>
        public method <StructureName>Exists, MethodStatus
            <PRIMARY_KEY>
            <SEGMENT_LOOP>
            required in  a<SegmentName>, <SEGMENT_CSTYPE>
            </SEGMENT_LOOP>
            </PRIMARY_KEY>
            required out aErrorMessage, string
        proc
            data status = MethodStatus.Success
            data ch = 0
            data <structureName>rec, str<StructureName>

            init <structureName>rec
            <PRIMARY_KEY>
            <SEGMENT_LOOP>
            <structureName>rec.<segment_name> = a<SegmentName>
            </SEGMENT_LOOP>
            </PRIMARY_KEY>

            try
            begin
                open(ch,I:I,"<FILE_NAME>")
                find(ch,,%keyval(ch,<structureName>rec,0))
                aErrorMessage = ""
            end
            catch (ex, @EndOfFileException)
            begin
                status = MethodStatus.Fail
                aErrorMessage = "Record not found!"
            end
            catch (ex, @KeyNotSameException)
            begin
                status = MethodStatus.Fail
                aErrorMessage = "Record not found!"
            end
            catch (ex, @Exception)
            begin
                status = MethodStatus.FatalError
                aErrorMessage = String.Format("Error while locating record: {0}",ex.Message)
            end
            finally
            begin
                if (ch&&chopen(ch))
                    close ch
            end
            endtry

            mreturn status

        endmethod

    endclass

endnamespace
