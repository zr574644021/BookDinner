using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(订餐平台.Startup))]
namespace 订餐平台
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
