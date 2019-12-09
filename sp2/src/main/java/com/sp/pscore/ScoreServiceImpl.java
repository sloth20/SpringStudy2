package com.sp.pscore;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("pscore.scoreService")
public class ScoreServiceImpl implements ScoreService {
	@Autowired
	private CommonDAO dao;

	@Override
	public void insertScore(Score dto) throws Exception {
		try {
			dao.callUpdateProcedure("pscore.insertScore", dto);
		} catch (Exception e) {
			e.printStackTrace();

			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			dao.callSelectOneProcedureMap("pscore.dataCount", map);
			result = (Integer) map.get("result");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Score> listScore(Map<String, Object> map) throws Exception {
		List<Score> list = null;
		try {
			dao.callSelectListProcedureMap("pscore.listScore", map);
			list = (List<Score>) map.get("result");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Score> listScore() {
		List<Score> list = null;
		try {
			list=dao.selectList("pscore.listAllScore");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Score readScore(Map<String, Object> map) throws Exception {
		Score dto = null;
		try {
			dao.callSelectListProcedureMap("pscore.readScore", map);
			List<Score> list = (List<Score>) map.get("result");
			if (list != null && list.size() > 0) {
				dto = (Score) list.get(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateScore(Score dto) throws Exception {
		try {
			dao.callUpdateProcedure("pscore.updateScore", dto);
		} catch (Exception e) {
			e.printStackTrace();

			throw e;
		}
	}

	@Override
	public void deleteScore(String hak) throws Exception {
		try {
			dao.callUpdateProcedure("pscore.deleteScore", hak);
		} catch (Exception e) {
			e.printStackTrace();

			throw e;
		}
	}
}
