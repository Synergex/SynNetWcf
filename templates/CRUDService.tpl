<CODEGEN_FILENAME><WCF_SERVICE>_<StructureName>.dbl</CODEGEN_FILENAME>
<REQUIRES_USERTOKEN>WCF_SERVICE</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>API_NAMESPACE</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>API_CLASS</REQUIRES_USERTOKEN>
<PROCESS_TEMPLATE>CRUDInterface</PROCESS_TEMPLATE>
<PROCESS_TEMPLATE>CRUDServiceBase</PROCESS_TEMPLATE>
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

    public partial class <WCF_SERVICE>

        public method Create<StructureName>, @Task<<WCF_SERVICE>Response>
            required in a<StructureName>, @<StructureName>
        proc
            data completionSource = new TaskCompletionSource<<WCF_SERVICE>Response>()
            lambda curryParams()
            begin
                data api = new <API_CLASS>()
                data tmpErrorMessage, string
                data response = new <WCF_SERVICE>Response()
                response.Status = api.Create<StructureName>(a<StructureName>,tmpErrorMessage)
                response.ErrorMessage = tmpErrorMessage
                completionSource.SetResult(response)
            end
            this.ServiceDispatcher.Dispatch(curryParams)
            mreturn completionSource.Task
        endmethod

        <PRIMARY_KEY>
        public method Read<StructureName>, @Task<<StructureName>ReadResponse>
            <SEGMENT_LOOP>
            required in  a<SegmentName>, <SEGMENT_CSTYPE>
            </SEGMENT_LOOP>
        proc
            data completionSource = new TaskCompletionSource<<StructureName>ReadResponse>()
            lambda curryParams()
            begin
                data api = new <API_CLASS>()
                data tmp<StructureName>, @<StructureName>
                data tmpGrfa, [#]byte
                data tmpErrorMessage, string
                data response = new <StructureName>ReadResponse()
                response.Status = api.Read<StructureName>(<SEGMENT_LOOP>a<SegmentName>,</SEGMENT_LOOP>tmp<StructureName>,tmpGrfa,tmpErrorMessage)
                response.ErrorMessage = tmpErrorMessage
                response.Result = tmp<StructureName>
                response.Grfa = tmpGrfa
                completionSource.SetResult(response)
            end
            this.ServiceDispatcher.Dispatch(curryParams)
            mreturn completionSource.Task
        endmethod
        </PRIMARY_KEY>

        public method ReadAll<StructureName>s, @Task<<StructureName>ReadAllResponse>
        proc
            data completionSource = new TaskCompletionSource<<StructureName>ReadAllResponse>()
            lambda curryParams()
            begin
                data api = new <API_CLASS>()
                data tmp<StructureName>s, @List<<StructureName>>
                data tmpErrorMessage, string
                data response = new <StructureName>ReadAllResponse()
                response.Status = api.ReadAll<StructureName>s(tmp<StructureName>s,tmpErrorMessage)
                response.ErrorMessage = tmpErrorMessage
                response.Result = tmp<StructureName>s
                completionSource.SetResult(response)
            end
            this.ServiceDispatcher.Dispatch(curryParams)
            mreturn completionSource.Task
        endmethod

        public method Update<StructureName>, @Task<<StructureName>UpdateResponse>
            required in a<StructureName>, @<StructureName>
            required in aGrfa, [#]byte
        proc
            data completionSource = new TaskCompletionSource<<StructureName>UpdateResponse>()
            lambda curryParams()
            begin
                data api = new <API_CLASS>()
                data tmp<StructureName>, @<StructureName>, a<StructureName>
                data tmpGrfa, [#]byte, aGrfa
                data tmpErrorMessage, string
                data response = new <StructureName>UpdateResponse()
                response.Status = api.Update<StructureName>(tmp<StructureName>,tmpGrfa,tmpErrorMessage)
                response.ErrorMessage = tmpErrorMessage
                response.Result = tmp<StructureName>
                response.Grfa = tmpGrfa
                completionSource.SetResult(response)
            end
            this.ServiceDispatcher.Dispatch(curryParams)
            mreturn completionSource.Task
        endmethod

        public method Delete<StructureName>, @Task<<WCF_SERVICE>Response>
            required in aGrfa, [#]byte
        proc
            data completionSource = new TaskCompletionSource<<WCF_SERVICE>Response>()
            lambda curryParams()
            begin
                data api = new <API_CLASS>()
                data tmpErrorMessage, string
                data response = new <WCF_SERVICE>Response()
                response.Status = api.Delete<StructureName>(aGrfa,tmpErrorMessage)
                response.ErrorMessage = tmpErrorMessage
                completionSource.SetResult(response)
            end
            this.ServiceDispatcher.Dispatch(curryParams)
            mreturn completionSource.Task
        endmethod

        <PRIMARY_KEY>
        public method <StructureName>Exists, @Task<<WCF_SERVICE>Response>
            <SEGMENT_LOOP>
            required in a<SegmentName>, <SEGMENT_CSTYPE>
            </SEGMENT_LOOP>
        proc
            data completionSource = new TaskCompletionSource<<WCF_SERVICE>Response>()
            lambda curryParams()
            begin
                data api = new <API_CLASS>()
                data tmpErrorMessage, string
                data response = new <WCF_SERVICE>Response()
                response.Status = api.<StructureName>Exists(<SEGMENT_LOOP>a<SegmentName><,></SEGMENT_LOOP>,tmpErrorMessage)
                response.ErrorMessage = tmpErrorMessage
                completionSource.SetResult(response)
            end
            this.ServiceDispatcher.Dispatch(curryParams)
            mreturn completionSource.Task
        endmethod
        </PRIMARY_KEY>

    endclass

endnamespace
