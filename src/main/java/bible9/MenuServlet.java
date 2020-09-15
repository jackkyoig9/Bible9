package bible9;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/menu_serv/*")
public class MenuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String path = request.getContextPath();
		String url = request.getRequestURL().toString();
		String uri = request.getRequestURI();
		System.out.println(uri);
		System.out.println("url:" + url);
		System.out.println("path:" + path);
		if (uri.indexOf("bible9.do") != -1) {
			String page = path + "/bib/menu.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
		else if (uri.indexOf("/index.do") != -1) {
			String page = path + "../index.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
		else if (uri.indexOf("app.do") != -1) {
			String page = path + "/bib/menu.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
		else if (uri.indexOf("loadsplayer.do") != -1) {
			String page = path + "/bib/loadsplayer.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
		else if (uri.indexOf("apostlescreed.do") != -1) {
			String page = path + "/bib/apostlescreed.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
		else if (uri.indexOf("bib_book.do") != -1) {
			String page = path + "/bib/bib_book.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
