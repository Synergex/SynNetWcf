
Title:          SynNetWcf

Description:    An example of how to implement WCF services using Synergy .NET
                while providing the required AppDomain isolation and multi-
                threading protection needed for Synergy .NET code. This example
                implements the WCF service directly in code, not via a Synergy
                .NET Interop project. A different solution would be required
                in that case.

Authors:        Steve Ives, Synergex Professional Services Group
                Jeff Greene, Synergex Development

Revision:       1.3

Date:           17th June 2015

Requirements:   Synergy .NET 10.3.1a or higher

--------------------------------------------------------------------------------
Change history

1.0             Original example.

1.1             Simple bug fix.

1.2             Enhanced the code in the AppDomainProtection assembly to work
                better when hosted in IIS.

1.3             Re-worked the mechanisms used in the AppDomainProtection code
                and significantly improved the suggested coding pattern for
                the WCF service methods. Also all GRFA processing now uses
                [#]byte instead of string.

--------------------------------------------------------------------------------

There are some special considerations that must be taken into account when
executing Synergy .NET code in any multi-threaded environment. Specifically a
developer must give special consideration to how the following entities are
used within the code, all of which exist at the process level:

    * Channels
    * COMMON data
    * GLOBAL data
    * STATIC data or other entities
    * Environment variables

In traditional Synergy environments (when compiling with dbl.exe and executing
your code with dbr.exe) your code executes in a process that is dedicated to
running your program. If other users are running the same code then they are
running it in the context of a totally seperate process. This means that each
instance of the code has private channels and common data, etc.

However, in Synergy .NET it is possible to execute code in environments where
multi-threading (running several "threads" of code all within a single process)
is supported. Examples of multi-threaded environments include:

    * Code that you write to execute code in multiple threads
    * ASP.NET Web applications
    * Windows Communication Foundation (WCF) services

There are two main things that must be considered when running code in any
multi-threaded environment:

    1. By default code running in all threads share the same Channels, COMMON
       data, GLOBAL data and STATICs.

    2. If the code uses xfServer then it is critical that any given entity of
       code always executes on the same thread, and the code must execute
       xcall s_server_thread_init before accessing xfServer.

If you want each instance of code to be isolated from all other instances, so
that channels, COMMONs, GLOBALs, etc. are unique to that thread, then the way
to achieve that is to load each instance of the code into a seperate "AppDomain",
and if xfServer is being used then it must also be ensured that each instance
of the code always executes on the same thread. The sample code included with
this example demonstrates how to do that when implementing a WCF service.

IMPORTANT: This example code does not address the issue of environment variables.
If your application uses XCALL SETLOG to set environment variables at runtime,
and if the values of those environment variables vary (based on user, or some
other criteria) then you must implement that functionality in some other way.
In Synergy (including Syenrgy .NET) environment variables are always set at the
process level, and AppDomain protection DOES NOT CHANGE THAT!

IMPORTANT: The instance of Visual Studio that is used to open and run this
demo code MUST be "Run as Administrator". If you don't do this then the server
application will fail to start because it won't have permissions to bind to
your network adapter, and the WebHost project may also fail to load.

The solution has been configured so that when you run the application BOTH
the ServiceHost and TestClient applications will be launched. You will see
the server applications console window appear almost immediately, but it is
normal for the TestClient application to take a few seconds to appear. This
is because we're simultaneously launching two applications from one solution,
and also because there is generally a brief delay in response from a WCF
service the first time a client connects after the service starts.

================================================================================
AppDomainProtection and AppDomainProtectionCore Projects

These two projects contain standard utility code that we have developed that is
responsible for implementing the AppDomain and thread locking protections that
Synergy .NET code can require. You should be able to simply add copies of these
projects to your development solutions.

================================================================================
PartsSystem Project

This project is a Synergy .NET Class Library that essentially contains Synergy
business logic and database access code. The code in this class library is called
by the code in the WCF service.

Most of the code in this project was code generated using CodeGen. The CodeGen
templates that were used can be found in the "Templates" solution folder, and
the CodeGen commands that were used can be found in the regen.bat batch file
in the "Solution Items" solution folder.

================================================================================
WcfServiceLibrary Project

This project is a Synergy .NET WCF Service Library. It contains classes that
"wrap" the business logic in the previous project in a WCF service.

The source files that begin with an I are used to define an "Interface" that
defines the "contract" exposed by the WCF Service. The other source files
define a class that implements the contract interface.

The external interface of the sample WCF service uses an asychronous pattern in
which each of the service operations (methods) returns a Task containing a
response object. The response object in turn contains any and all data returned
by the operation. All operations return at least two pieces of data:

1. A return status defined by the ENUM MethodStatus.
2. An error message, which is populated whenever the return status is anything
   other than success.

A base response class named PartsServiceResponse is defined and conains properties
for these two "standard" return values. This class can be used for any methods
that only return status and error message, and can be extended by other return
type classes that need to contain additional data. You will see examples of this
in various response classes defined in files such as IPartsService_Part.dbl.

Again, most of the code in this project was code generated using CodeGen. Some
of the code is "hand crafted", you can find this code in the source files
IPartsService_Custom.dbl and PartsService_Custom.dbl

================================================================================
ServiceHost Project

This project is a Synergy .NET console application that is used to host the
WCF service. When using this self-hosting project to host the service you will
see a console window apper containing this text:

The service is ready at http://localhost:50074

Press a key to terminate the service

================================================================================
TestClient Project

This project is a very simple Synergy .NET WPF application. It has a service
reference to the WCF service exposed by the WcfServiceLibrary, and uses some of
the WCF services methods.

================================================================================
WebHost Project

This project is a very simple Synergy ASP.NET Web application that can be used
to host the WCF services using IIS Express or IIS.

================================================================================
Strong Name Signing

If you intend to host your Synergy .NET WCF services in Internet Information
Server (IIS) then all assemblies that will be loaded in IIS (in the case of
this example that would be AppDomainProtection.dll, PartsSystem.dll and
WcfServiceLibrary.dll) must be strong name signed.

================================================================================
Testing the environment

You can test the environment in one of three ways:

1. SelfhHosting the WCF service 
   ----------------------------
   
   Configure the solution to start BOTH the ServiceHost and TestClient projects,
   this is done by right-clicking the SynNetWcf solution, selecting "Set Startup
   Projects", selecting "Multiple Startup Projects" and setting both of the
   required projects to an Action of Start.
   
   Near the top of TestClient\ViewModel.dbl make sure that
   endPointName = "SELF_HOSTED" is enabled.
   
   Select Debug > Start Debugging

2. Hosting the WCF service in the WebHost web application using IIS Express
   ------------------------------------------------------------------------

   Configure the Web projects properties to use "IIS Express" with the URL
   http://localhost:50075/

   Configure the solution to start onlt the TestClient project, right-click on
   the project and select Set as Startup Project.
   
   Near the top of TestClient\ViewModel.dbl make sure that
   endPointName = "IIS_EXPRESS" is enabled.
   
   Select Debug > Start Debugging

3. Hosting the WCF service in the WebHost web application using IIS
   ----------------------------------------------------------------

   Configure the Web projects properties to use "Local IIS" with the URL
   http://localhost/WebHost

   If it is the first time you have done this, click the "Create Virtual Directory"
   button to configure the application in your local IIS server.

   Configure the solution to start onlt the TestClient project, right-click on
   the project and select Set as Startup Project.
   
   Near the top of TestClient\ViewModel.dbl make sure that
   endPointName = "IIS" is enabled.
   
   Select Debug > Start Debugging
