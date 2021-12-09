using System;
using System.Reflection;
using System.ServiceModel.Channels;
using System.ServiceModel.Description;
using System.ServiceModel.Dispatcher;

namespace AppDomainProtectionCore
{
    public class MarshaledOperationInvokerBehavior : IOperationBehavior
    {
        IOperationBehavior defaultBehavior;

        public MarshaledOperationInvokerBehavior()
        {
            defaultBehavior = typeof(IOperationInvoker).Assembly.GetType("System.ServiceModel.Dispatcher.OperationInvokerBehavior").GetConstructor(new Type[0]).Invoke(null) as IOperationBehavior;
        }
        
        public void AddBindingParameters(OperationDescription description, BindingParameterCollection bindingParameters)
        {
            defaultBehavior.AddBindingParameters(description, bindingParameters);
        }

        public void ApplyClientBehavior(OperationDescription description, ClientOperation operation)
        {
            defaultBehavior.ApplyClientBehavior(description, operation);
        }

        private static readonly PropertyInfo TaskTResult = typeof(OperationDescription).GetProperty("TaskTResult", BindingFlags.NonPublic | BindingFlags.Instance);
        
        public void ApplyDispatchBehavior(OperationDescription description, DispatchOperation operation)
        {
            if (description.TaskMethod != null)
                operation.Invoker = new MarshalableOperationInvocation(description.TaskMethod, TaskTResult.GetValue(description) as Type);
            else
                defaultBehavior.ApplyDispatchBehavior(description, operation);
        }

        public void Validate(OperationDescription description)
        {
            defaultBehavior.Validate(description);
        }
    }
}
