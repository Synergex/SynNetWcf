using System;
using System.ServiceModel.Description;
using System.ServiceModel.Dispatcher;

namespace AppDomainProtectionCore
{
    public class MarshaledAsyncBehaviorAttribute : Attribute, IContractBehaviorAttribute, IContractBehavior
    {

        #region IContractBehaviorAttribute Members

        public Type TargetContract
        {
            get { return typeof(IsolatableServiceBaseBase); }
        }

        #endregion

        #region IContractBehavior Members

        public void AddBindingParameters(ContractDescription description, ServiceEndpoint endpoint, System.ServiceModel.Channels.BindingParameterCollection parameters)
        {
            return;
        }

        public void ApplyClientBehavior(ContractDescription description, ServiceEndpoint endpoint, ClientRuntime runtime)
        {
            return;
        }

        public void ApplyDispatchBehavior(ContractDescription description, ServiceEndpoint endpoint, DispatchRuntime dispatch)
        {
            foreach (var operation in endpoint.Contract.Operations)
            {
                if (operation.Behaviors.Contains(typeof(MarshaledOperationInvokerBehavior)))
                    continue;

                operation.Behaviors.Add(new MarshaledOperationInvokerBehavior());
            }
        }

        public void Validate(ContractDescription description, ServiceEndpoint endpoint)
        {
            return;
        }

        #endregion
    }
}
