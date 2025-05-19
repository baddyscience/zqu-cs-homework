using NLog;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Metadata.Edm;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using Unity;
using Unity.Injection;
namespace work9
{
    public class Global : System.Web.HttpApplication
    {
        private static readonly NLog.Logger Logger = NLog.LogManager.GetCurrentClassLogger();
        protected void Application_Start()
        {
            // 配置Unity容器
            var container = new UnityContainer();
            container.RegisterType<IRepository<Department>, GenericRepository<Department>>();

            // 配置NLog
            var config = new NLog.Config.LoggingConfiguration();
            var logfile = new NLog.Targets.FileTarget("logfile") { FileName = "log.txt" };
            config.AddRule(LogLevel.Debug, LogLevel.Fatal, logfile);
            NLog.LogManager.Configuration = config;
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error()
        {
            var ex = Server.GetLastError();
            Logger.Error(ex.ToString());
            Response.Redirect("/ErrorPage.aspx");
        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}