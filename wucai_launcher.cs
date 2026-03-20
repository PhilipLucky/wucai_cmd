using System;
using System.Diagnostics;
using System.IO;
using System.Linq;

internal static class Program
{
    private static int Main(string[] args)
    {
        string workingDirectory = Environment.CurrentDirectory;
        string wucaiCmd = Path.Combine(
            Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData),
            "npm",
            "wucai.cmd");

        if (!File.Exists(wucaiCmd))
        {
            Console.Error.WriteLine("[wucai.exe] Missing command: " + wucaiCmd);
            return 1;
        }

        string forwardedArgs = string.Join(" ", args.Select(QuoteForCmd));
        string command = "call \"" + wucaiCmd + "\"";

        if (!string.IsNullOrWhiteSpace(forwardedArgs))
        {
            command += " " + forwardedArgs;
        }

        var startInfo = new ProcessStartInfo
        {
            FileName = Environment.GetEnvironmentVariable("COMSPEC") ?? "cmd.exe",
            Arguments = "/k " + command,
            WorkingDirectory = workingDirectory,
            UseShellExecute = false,
        };

        Process.Start(startInfo);
        return 0;
    }

    private static string QuoteForCmd(string value)
    {
        if (string.IsNullOrEmpty(value))
        {
            return "\"\"";
        }

        string escaped = value.Replace("\"", "\"\"");
        return "\"" + escaped + "\"";
    }
}
