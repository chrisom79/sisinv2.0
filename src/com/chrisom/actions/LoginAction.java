package com.chrisom.actions;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.config.IniSecurityManagerFactory;
import org.apache.shiro.util.Factory;

import com.chrisom.sisinv.utils.Algorithms;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.subject.Subject;

/**
 * Servlet implementation class LoginAction
 */
@WebServlet("/LoginAction")
public class LoginAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Subject _currentUser = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginAction() {
    	Factory<SecurityManager> factory = new IniSecurityManagerFactory();
		org.apache.shiro.mgt.SecurityManager securityManager = factory.getInstance();
		SecurityUtils.setSecurityManager(securityManager);
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user = request.getParameter("txtUsuario");
		String pass = request.getParameter("txtPassword");
		if (user == null || pass == null) {
			request.setAttribute("message", "Usuario/Password invalidos");
		} else {
			String passMD5 = Algorithms.encryptMD5(pass);
			boolean b = tryLogin(user, pass, false);
			if (b) {
				HttpSession session = request.getSession();
				session.setAttribute("user", _currentUser);
				request.getRequestDispatcher("/home.jsp").forward(request, response);
			} else {
				request.setAttribute("message",
						"Error! user/password erroneos...");
			}
		}		
	}
	
	public boolean tryLogin(String username, String password, Boolean rememberMe) {
		// get the currently executing user:
		_currentUser = SecurityUtils
				.getSubject();

		if (!_currentUser.isAuthenticated()) {
			// collect user principals and credentials in a gui specific manner
			// such as username/password html form, X509 certificate, OpenID,
			// etc.
			// We'll use the username/password example here since it is the most
			// common.
			UsernamePasswordToken token = new UsernamePasswordToken(username,
					password);
			// this is all you have to do to support 'remember me' (no config -
			// built in!):
			token.setRememberMe(rememberMe);

			try {
				_currentUser.login(token);
				System.out.println("User ["
						+ _currentUser.getPrincipal().toString()
						+ "] logged in successfully.");

				// save current username in the session, so we have access to
				// our User model
				_currentUser.getSession().setAttribute("username", username);
				return true;
			} catch (UnknownAccountException uae) {
				System.out.println("No existe usuario con ese ID "
						+ token.getPrincipal());
			} catch (IncorrectCredentialsException ice) {
				System.out.println("El password de la cuenta "
						+ token.getPrincipal()
						+ " es incorrecto!");
			} catch (LockedAccountException lae) {
				System.out.println("El usuario de la cuenta "
						+ token.getPrincipal()
						+ " esta bloqueado.  "
						+ "Por favor contacta al administrador.");
			}
		} else {
			return true; // already logged in
		}

		return false;
	}

}
