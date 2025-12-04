package repository;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import domain.User;
import orm.DatabasesBuilder;

public class UserDAOImpl implements UserDAO {
	private static final Logger log = LoggerFactory.getLogger(UserDAOImpl.class);
	
	private SqlSession sql;
	
	public UserDAOImpl() {
		new  DatabasesBuilder();
		sql = DatabasesBuilder.getFactory().openSession();
	}

	@Override
	public int insert(User user) {
		// TODO Auto-generated method stub
		int isOk = sql.insert("userMapper.add", user);
		if(isOk>0) sql.commit();
		return isOk;
	}

	@Override
	public User getUser(User user) {
		// TODO Auto-generated method stub
		return sql.selectOne("userMapper.getUser", user);
	}

	@Override
	public int lastLoginUpdate(String id) {
		// TODO Auto-generated method stub
		int isOk = sql.update("userMapper.lastLoginUpdate", id);
		if(isOk>0) sql.commit();
		return isOk;
	}

	@Override
	public int update(User user) {
		// TODO Auto-generated method stub
		int isOk = sql.update("userMapper.update", user);
		if(isOk > 0) sql.commit();
		return isOk;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		int isOk =sql.delete("userMapper.delete", id);
		if(isOk > 0) sql.commit();
		return isOk;
	}

}
