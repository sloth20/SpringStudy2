package com.sp.abbs;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("abbs.boardService")
public class BoardServiceImpl implements BoardService {
	@Autowired
	private CommonDAO dao;

	@Autowired
	private FileManager fileManager;

	@Override
	public int insertBoard(Board dto, String pathname) {
		int result = 0;

		try {
			String saveFilename = fileManager.doFileUpload(dto.getSelectFile(), pathname);
			if (saveFilename != null) {
				dto.setSaveFilename(saveFilename);
				dto.setOriginalFilename(dto.getSelectFile().getOriginalFilename());
			}

			result = dao.insertData("abbs.insertBoard", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;

		try {
			result = dao.selectOne("abbs.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public List<Board> listBoard(Map<String, Object> map) {
		List<Board> list = null;

		try {
			list = dao.selectList("abbs.listBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public Board readBoard(int num) {
		Board dto = null;
		try {
			dto = dao.selectOne("abbs.readBoard", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Board preReadBoard(Map<String, Object> map) {
		Board dto = null;
		try {
			dto = dao.selectOne("abbs.preReadBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Board nextReadBoard(Map<String, Object> map) {
		Board dto = null;
		try {
			dto = dao.selectOne("abbs.nextReadBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int updateBoard(Board dto, String pathname) {
		int result = 0;

		try {
			String saveFilename = fileManager.doFileUpload(dto.getSelectFile(), pathname);
			if (saveFilename != null) {
				if (dto.getSaveFilename().length() != 0) {
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);

				}
				dto.setSaveFilename(saveFilename);
				dto.setOriginalFilename(dto.getSelectFile().getOriginalFilename());
			}

			result = dao.updateData("abbs.updateBoard", dto);

		} catch (Exception e) {
		}

		return result;
	}

	@Override
	public int deleteBoard(int num, String pathname) {
		int result = 0;

		try {
			Board dto = readBoard(num);
			if (dto == null) {
				return result;
			}

			if (dto.getSaveFilename() != null) {
				fileManager.doFileDelete(dto.getSaveFilename(), pathname);
			}
			result = dao.deleteData("abbs.deleteBoard", num);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;

	}

	@Override
	public int updateHitCount(int num) {
		int result = 0;
		try {
			result = dao.updateData("abbs.updateHitCount", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Board deleteFile(int num, String pathname) {
		Board dto = null;

		try {
			dto = readBoard(num);
			if (dto == null) {
				return dto;
			}

			if (dto.getSaveFilename() != null) {
				fileManager.doFileDelete(dto.getSaveFilename(), pathname);

				dto.setSaveFilename("");
				dto.setOriginalFilename("");
				updateBoard(dto, pathname);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;

	}

}
