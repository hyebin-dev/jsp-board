package service;

import java.util.List;

import domain.Board;
import domain.PagingVO;

public interface BoardService {

	int insert(Board b);

	List<Board> getList();

	Board getDetail(int bno);

	int update(Board b);

	int delete(int bno);

	List<Board> getPageList(PagingVO pgvo);

	int getTotal(PagingVO pgvo);

}
