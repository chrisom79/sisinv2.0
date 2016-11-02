package com.chrisom.waay.actions;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;

import com.chrisom.sisinv.model.VendedorModel;
import com.chrisom.sisinv.utils.SISINVConstants;
import com.chrisom.sisinv.utils.WaayException;

/**
 * Servlet implementation class SettingsAction
 */
@WebServlet("/SettingsAction")
public class SettingsAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SettingsAction() {
        super();
        // TODO Auto-generated constructor stub
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
		String task = request.getParameter("task");
		if(SISINVConstants.SETTINGS_TASKS.CAMBIAR_PASSWORD.equalsIgnoreCase(task)) {
			String newPass = request.getParameter("txtNvoPass");
			String newConfirmPass = request.getParameter("txtConfNvoPass");
			VendedorModel vend = new VendedorModel();
			if(newPass.equals(newConfirmPass)) {
				Subject _currentUser = SecurityUtils.getSubject();
				List<String> userInfo = _currentUser.getPrincipals().asList();
				try {
					vend.updatePassword(userInfo.get(0), newPass);
					
					request.setAttribute("mensaje", "Tu password ha sido actualizado");
				} catch (WaayException e) {
					request.setAttribute("error", "Tu password NO ha sido actualizado");
				}
				
				request.getRequestDispatcher("/home.jsp").forward(request, response);
			}
		}
	}

}
