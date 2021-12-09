using System;
using System.Threading.Tasks;

namespace AppDomainProtectionCore
{
    public class MarshalableCompletionSource<T> : MarshalByRefObject
    {
        private AsyncCallback _callback;
        private readonly TaskCompletionSource<T> _tcs;

        public MarshalableCompletionSource(AsyncCallback callback, object state)
        {
            _callback = callback;
            _tcs = new TaskCompletionSource<T>(state);
        }

        public void SetResult(T result)
        {
            _tcs.SetResult(result);
            if (_callback != null) _callback(_tcs.Task);
        }

        public void SetException(Exception[] exceptions)
        {
            _tcs.SetException(exceptions);
            if (_callback != null) _callback(_tcs.Task);
        }

        public void SetCanceled()
        {
            _tcs.SetCanceled(); 
            if (_callback != null) _callback(_tcs.Task);
        }

        public Task<T> Task { get { return _tcs.Task; } }
    }
}
