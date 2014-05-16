package de.ulm.uni.vs.avid.roary;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RoarHistoryUpdate
 */
public class RoarHistoryUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RoarHistoryUpdate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String roarText = request.getParameter("roarText");
		String act = request.getParameter("act");
		
		// our application Roars from app context
		ServletContext appContext = getServletContext();
		List<Roar> roars = (List<Roar>)appContext.getAttribute("appRoars");
		
		if (act.equals("new")) {
			String author = request.getUserPrincipal().getName();
			
			if (roarText != null  && author != null) {
				// our new Roar
				Roar roar = new Roar();
				roar.setAuthor(author);
				roar.setText(roarText);
				
				// add the new Roar to the existing list
				if(roars.add(roar)) {
					appContext.setAttribute("appRoars", roars);
					response.sendRedirect("RoaryList.jsp");
				} else {
					response.getOutputStream().print("Sorry, something went wrong with that roar. Please try again.");
				}
			} else {
				response.getOutputStream().print("Sorry, that was not a valid Roar. Please make sure you are logged in and enter text for your Roar.");
			}
		} else if (act.equals("edit")) {
			Integer roarIndex = Integer.parseInt(request.getParameter("index"));
			Roar curRoar = roars.get(roarIndex);
			curRoar.setText(roarText);
			roars.set(roarIndex, curRoar);
			
			appContext.setAttribute("appRoars", roars);
			response.sendRedirect("RoaryList.jsp");
		}
	}

}
