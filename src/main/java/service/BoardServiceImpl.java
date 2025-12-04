package service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import domain.Board;
import domain.PagingVO;
import repository.BoardDAO;
import repository.BoardDAOImpl;

public class BoardServiceImpl implements BoardService {
	
	// 로그객체
	private static final Logger log = LoggerFactory.getLogger(BoardServiceImpl.class);
	
	// BoardDAO 인터페이스 생성
	private BoardDAO bdao;
	
	public BoardServiceImpl() {
		bdao = new BoardDAOImpl();
	}

	@Override
	public int insert(Board b) {
		// TODO Auto-generated method stub
		log.info("BoardServiceImpl Test...");
		return bdao.insert(b);
	}

	@Override
	public List<Board> getList() {
		// TODO Auto-generated method stub
		return bdao.getList();
	}

	@Override
	public Board getDetail(int bno) {
		// TODO Auto-generated method stub
		return bdao.getDetail(bno);
	}

	@Override
	public int update(Board b) {
		// TODO Auto-generated method stub
		return bdao.update(b);
	}

	@Override
	public int delete(int bno) {
		// TODO Auto-generated method stub
		return bdao.delete(bno);
	}

	@Override
	public List<Board> getPageList(PagingVO pgvo) {
		// TODO Auto-generated method stub
		return bdao.getPageList(pgvo);
	}

	@Override
	public int getTotal(PagingVO pgvo) {
		// TODO Auto-generated method stub
		return bdao.getTotal(pgvo);
	}
	

}
