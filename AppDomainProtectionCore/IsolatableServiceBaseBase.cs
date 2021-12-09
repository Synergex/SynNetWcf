using System;
using System.Reflection;
using System.Threading.Tasks;
using System.Linq;

namespace AppDomainProtectionCore
{
    public class IsolatableServiceBaseBase : MarshalByRefObject
    {
        public void InvokeWrapper<T>(MarshalableCompletionSource<object> completionSource, MethodInfo taskMethod, object[] inputs)
        {
            var tsk = taskMethod.Invoke(this, inputs) as Task<T>;
            tsk.ContinueWith(t =>
            {
                if (t.IsFaulted) completionSource.SetException(t.Exception.InnerExceptions.ToArray());
                else if (t.IsCanceled) completionSource.SetCanceled();
                else completionSource.SetResult(t.Result);
            });
        }

        public void InvokeWrapperPlain(MarshalableCompletionSource<object> completionSource, MethodInfo taskMethod, object[] inputs)
        {
            var tsk = taskMethod.Invoke(this, inputs) as Task;
            tsk.ContinueWith(t =>
            {
                if (t.IsFaulted) completionSource.SetException(t.Exception.InnerExceptions.ToArray());
                else if (t.IsCanceled) completionSource.SetCanceled();
                else completionSource.SetResult(null);
            });
        }
    }    
}
