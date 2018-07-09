#! "netcoreapp2.0"
#r "nuget: Microsoft.Windows.Compatibility, 2.0.0"

using Microsoft.Win32;
using System.Runtime.InteropServices;

if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
{
    Console.WriteLine($"Windows {System.Environment.OSVersion}");
    using(var reg = Microsoft.Win32.Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Windows\CurrentVersion"))
    {
        if(reg?.GetValue("ProgramFilesDir") is string dir)
            Console.WriteLine(dir);
    }
}
else
{
    System.Console.WriteLine("Not running on Windows");
}