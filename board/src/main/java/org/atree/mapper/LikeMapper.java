package org.atree.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.atree.domain.BoardVO;
import org.atree.domain.LikeVO;

public interface LikeMapper {

	@Select("select * from tbl_like where userid=#{writer} and bno=#{bno} ")
	public LikeVO getLike(BoardVO vo);
	
	@Insert("insert into tbl_like(bno,userid) " + 
			"values (#{bno},#{userid})")
	public int insertLike(LikeVO vo);
}
