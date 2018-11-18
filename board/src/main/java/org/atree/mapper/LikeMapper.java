package org.atree.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.atree.domain.BoardVO;
import org.atree.domain.LikeVO;

public interface LikeMapper {

	@Select("select * from tbl_like where userid=#{userid} and bno=#{bno} ")
	public LikeVO getLike(LikeVO vo);
	
	@Insert("insert into tbl_like(bno,userid) " + 
			"values (#{bno},#{userid})")
	public void insertLike(LikeVO vo);
	
	@Delete("delete from tbl_like where bno=#{bno} and userid=#{userid}")
	public void deleteLike(LikeVO vo);
}
