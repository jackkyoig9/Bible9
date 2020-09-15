package bible9;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/bib_serv/*")
public class BibController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String path = request.getContextPath();
		String url = request.getRequestURL().toString();
		String uri = request.getRequestURI();
//		System.out.println(uri);
//		System.out.println("url:" + url);
//		System.out.println("path:" + path);
		
		if (uri.indexOf("bib_book.do") != -1) {
			String page = path + "/bib/bib_book.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
		else if (uri.indexOf("read_bib.do") != -1) {
//			System.out.println("read_bib.do>>");
			String tot_jang = request.getParameter("tot_jang");
			String bib = request.getParameter("bib");
			String book = request.getParameter("book");
			String bib_book = bib + ".json"; // Add the file extension
			System.out.println("read_bib.do>> tot_jang=" + tot_jang);
			System.out.println("read_bib.do>> bib=" + bib);
			System.out.println("read_bib.do>> book=" + book);
			System.out.println("read_bib.do>> bib_book=" + bib_book);
			int jang = 1;
			request.setAttribute("jang", jang);
			request.setAttribute("book", book);
			request.setAttribute("bib_book", bib_book);
			request.setAttribute("tot_jang", tot_jang);
			String page = path + "/bib/bib.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
//			System.out.println("send to /bib/bib.jsp");
		}
		else if (uri.indexOf("read_bib_jang.do") != -1) {
//			System.out.println("read_bib_jang.do>>");
			String jang = request.getParameter("jang");
//			System.out.println("read_bib_jang.do>> jang:" + jang);
			request.setAttribute("jang", jang);
			String page = path + "/bib/bib.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
