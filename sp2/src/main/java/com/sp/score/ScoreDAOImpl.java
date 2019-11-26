package com.sp.score;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("score.scoreDAO")
public class ScoreDAOImpl implements ScoreDAO {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insertScore(Score dto) throws Exception {
		try {
			sqlSession.insert("score.insertScore", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;

		try {
			result = sqlSession.selectOne("score.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public List<Score> listScore(Map<String, Object> map) {
		List<Score> list = null;

		try {
			list = sqlSession.selectList("score.listScore", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public Score readScore(String hak) {
		Score dto = null;

		try {
			dto = sqlSession.selectOne("score.readScore", hak);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public void updateScore(Score dto) throws Exception {
		try {
			sqlSession.update("score.updateScore", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	}

	@Override
	public void deleteScore(String hak) throws Exception {
		try {
			sqlSession.delete("score.deleteScore", hak);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteScoreList(List<String> list) throws Exception {
		try {
			sqlSession.delete("score.deleteScoreList", list);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	
}
