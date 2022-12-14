package kr.co.kmarket1.controller.admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.kmarket1.dao.ProductDAO;
import kr.co.kmarket1.vo.ProductVO;

@WebServlet("/admin/productRegister.do")
public class ProductRegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/admin/productRegister.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//데이터 수신
		String prodName = req.getParameter("prodName");
		String descript = req.getParameter("descript");
		String company  = req.getParameter("company");
		String price    = req.getParameter("price");
		String discount = req.getParameter("discount");
		String point    = req.getParameter("point");
		String stock    = req.getParameter("stock");
		String delivery = req.getParameter("delivery");
		String thumb1   = req.getParameter("thumb1");
		String thumb2   = req.getParameter("thumb2");
		String thumb3   = req.getParameter("thumb3");
		String detail   = req.getParameter("detail");
		String status   = req.getParameter("status");
		String duty     = req.getParameter("duty");
		String receipt  = req.getParameter("receipt");
		String bizType  = req.getParameter("bizType");
		String origin   = req.getParameter("origin");
		
		ProductVO vo = new ProductVO();
		
		vo.setProdName(prodName);
		vo.setDescript(descript);
		vo.setCompany(company);
		vo.setPrice(price);
		vo.setDiscount(discount);
		vo.setPoint(point);
		vo.setStock(stock);
		vo.setDelivery(delivery);
		vo.setThumb1(thumb1);
		vo.setThumb2(thumb2);
		vo.setThumb3(thumb3);
		vo.setDetail(detail);
		vo.setStatus(status);
		vo.setDuty(duty);
		vo.setReceipt(receipt);
		vo.setBizType(bizType);
		vo.setOrigin(origin);
		
		ProductDAO.getInstance().insertProduct(vo);;
		
	}
	
}
