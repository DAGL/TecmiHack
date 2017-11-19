using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAL;
using BLL.UsuarioBLL;


namespace Ecotrash_Beta1.Vistas.Login
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        

        [WebMethod]
        public static string Log(string name, string pass)
        {
            UsuarioLogic usuarioLogic = new UsuarioLogic();
            Usuario record = usuarioLogic.GetByUserAndPass(name, pass).ToList().FirstOrDefault();
            if(record != null){
                Ecotrash_Beta1.Session.user = record;
                return "valid";
            }
            else{
                return "Verificar los datos de acceso";
            }
        }
    }
}