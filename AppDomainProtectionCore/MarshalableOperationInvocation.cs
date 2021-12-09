using System;
using System.Reflection;
using System.Threading.Tasks;
using System.ServiceModel.Dispatcher;

namespace AppDomainProtectionCore
{
    public class MarshalableOperationInvocation : IOperationInvoker
    {
        MethodInfo _taskMethod;
        Type _taskType;
        readonly MethodInfo _specializedInvokeWrapper;
        readonly static MethodInfo _invokeWrapper = typeof(IsolatableServiceBaseBase).GetMethod("InvokeWrapper", BindingFlags.Public | BindingFlags.Instance);
        readonly static MethodInfo _invokeWrapperNoGeneric = typeof(IsolatableServiceBaseBase).GetMethod("InvokeWrapperPlain", BindingFlags.Public | BindingFlags.Instance);
        
        public MarshalableOperationInvocation(MethodInfo taskMethod, Type taskType)
        {
            _taskMethod = taskMethod;
            _taskType = taskType;
            _specializedInvokeWrapper = taskType == typeof(void) ? _invokeWrapperNoGeneric : _invokeWrapper.MakeGenericMethod(taskType);
        }

        public bool IsSynchronous
        {
            get
            {
                return false;
            }
        }

        public object[] AllocateInputs()
        {
            return new object[_taskMethod.GetParameters().Length];
        }

        public object Invoke(object instance, object[] inputs, out object[] outputs)
        {
            throw new NotImplementedException();
        }

        public IAsyncResult InvokeBegin(object instance, object[] inputs, AsyncCallback callback, object state)
        {
            //MarshalableCompletionSource<object> completionSource = new MarshalableCompletionSource<object>(callback, state);
            var completionSource = new MarshalableCompletionSource<object>(callback, state);
            _specializedInvokeWrapper.Invoke(instance, new object[] { completionSource, _taskMethod, inputs });
            return completionSource.Task;
        }

        public object InvokeEnd(object instance, out object[] outputs, IAsyncResult result)
        {
            outputs = new object[0];
            return ((Task<object>)result).Result;
        }
    }
}
