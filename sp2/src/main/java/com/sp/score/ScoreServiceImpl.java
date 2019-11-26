package com.sp.score;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("score.scoreService")
public class ScoreServiceImpl implements ScoreService {

	@Autowired
	private ScoreDAO dao;

	@Override
	public void insertScore(Score dto) throws Exception {
		try {
			dao.insertScore(dto);
		} catch (Exception e) {
			throw e;
		}

	}

	@Override
	public int dataCount(Map<String, Object> map) {
		return dao.dataCount(map);
	}

	@Override
	public List<Score> listScore(Map<String, Object> map) {
		return dao.listScore(map);
	}

	@Override
	public Score readScore(String hak) {
		return dao.readScore(hak);
	}

	@Override
	public void updateScore(Score dto) throws Exception {
		try {
			dao.updateScore(dto);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public void deleteScore(String hak) throws Exception {
		try {
			dao.deleteScore(hak);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public void deleteScoreList(List<String> list) throws Exception {
		try {
			dao.deleteScoreList(list);
		} catch (Exception e) {
			throw e;
		}
	}

	
}
