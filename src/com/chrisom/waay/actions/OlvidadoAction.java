package com.chrisom.waay.actions;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authc.credential.DefaultPasswordService;

import com.chrisom.sisinv.entity.Vendedor;
import com.chrisom.sisinv.model.VendedorModel;
import com.chrisom.sisinv.utils.Algorithms;
import com.chrisom.sisinv.utils.WaayException;
import com.chrisom.waay.mail.SendMail;

/**
 * Servlet implementation class OlvidadoAction
 */
@WebServlet("/OlvidadoAction")
public class OlvidadoAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OlvidadoAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		VendedorModel model = new VendedorModel();
		String email = request.getParameter("fp_email");
		Vendedor vendedor = model.finVendedorByEmail(email);
		if(vendedor != null) {
			String randPass = Algorithms.randomPassword();
			System.out.println(randPass);
			SendMail mail = new SendMail();
			
			try {
				model.updatePassword(vendedor.getUsuario(), randPass);
				mail.sendMail(email, randPass);
				request.setAttribute("mensaje",
						"Tu nuevo password e instrucciones han sido enviadas a tu correo registrado");
			} catch (WaayException e) {
				request.setAttribute("error",
						"No se pudo actualizar el nuevo password en la DB");
			}			
		} else {
			request.setAttribute("error",
					"El correo electronico no existe en los registros");
		}
		
		request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
