using System;
using System.Collections.Generic;
using System.Text;
using DAL.UsuarioDAL;
using DAL;

namespace BLL.UsuarioBLL
{
    public class UsuarioLogic
    {
        #region DAL´s
        UsuarioRepository usuarioRepository;
        #endregion


        public Usuario Add(Usuario record)
        {
            usuarioRepository = new UsuarioRepository();
            Usuario newRecord = new Usuario();
            if(usuarioRepository.Get(rec => rec.nombreUsuario == record.nombreUsuario).GetEnumerator() != null)
            {
                throw new Exception("Ya existe un usuario con el mismo nombre de usuario.");
            }

            if (usuarioRepository.Get(rec => rec.correo == record.correo).GetEnumerator() != null)
            {
                throw new Exception("Ya se tiene registrado ese correo.");
            }

            newRecord.apellidos = record.apellidos;
            newRecord.contrasenia = record.contrasenia;
            newRecord.direccion = record.direccion;
            newRecord.nombres = record.nombres;
            newRecord.nombreUsuario = record.nombreUsuario;
            usuarioRepository.Add(newRecord);
            return newRecord;
        }

        public Usuario Update(Usuario record)
        {
            usuarioRepository = new UsuarioRepository();
            Usuario newRecord = usuarioRepository.GetById(record.id);


            newRecord.apellidos = record.apellidos;
            newRecord.contrasenia = record.contrasenia;
            newRecord.direccion = record.direccion;
            newRecord.nombres = record.nombres;
            newRecord.nombreUsuario = record.nombreUsuario;
            usuarioRepository.Update(newRecord);
            return newRecord;
        }

        public void Delete(int id)
        {
            usuarioRepository = new UsuarioRepository();
            usuarioRepository.Delete(this.GetById(id));
        }

        public IEnumerable<Usuario> GetAll()
        {
            usuarioRepository = new UsuarioRepository();
            return usuarioRepository.GetAll();
        }

        public Usuario GetById(int id)
        {
            usuarioRepository = new UsuarioRepository();
            return usuarioRepository.GetById(id);

        }

        public IEnumerable<Usuario> GetByUserAndPass(string userName, string pass)
        {
            usuarioRepository = new UsuarioRepository();
            return usuarioRepository.Get(record => record.nombreUsuario == userName && record.contrasenia == pass);
        }

    }
}
