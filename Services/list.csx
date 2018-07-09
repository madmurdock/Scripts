#! "netcoreapp2.1"
#r "nuget: Microsoft.Windows.Compatibility, 2.0.0"
#r "nuget: System.ServiceProcess.ServiceController, 4.5.0"

using System;
using System.Linq;
using System.ServiceProcess;

var services = ServiceController.GetServices()
                                .Where(s => s.Status == ServiceControllerStatus.Running)
                                .OrderBy(s => s.DisplayName);

foreach(ServiceController service in services)
{
    Console.WriteLine($"{service.DisplayName} <{service.Status}>");
}